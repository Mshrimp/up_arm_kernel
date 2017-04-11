#include <config.h>
#include <board.h>
#include <string.h>
#include <gic.h>
#include <pwm.h>

extern void vector_start();
extern void vector_end();

u32 *ttb1 = (void*)0x60000000;	//16K对齐的地址;
int main(void)
{
	printf("main start\n");
	memset(ttb1, 0, 16 * 1024); 
	//mmu_l1_init(ttb1);
	mmu_l1_init_uboot(ttb1);
	mmu_l1_mmap(ttb1, 0xffff0000, 0x7fff0000);
	memcpy((void*)0x7fff0000, vector_start, vector_end - vector_start);

	asm __volatile__(
		"mcr p15, 0, r0, c8, c7, 0\n\t"		//clear_tlb
		"mcr p15, 0, %0, c2, c0, 0\n\t"		//set_ttb
		"mcr p15, 0, %1, c3, c0, 0\n\t"		//set_domain
		"mrc p15, 0, r0, c1, c0, 0\n\t"		//
		"orr r0, r0, #(1<<13)\n\t"			//V
		"orr r0, r0, #1\n\t"				//M
		"mcr p15, 0, r0, c1, c0, 0\n\t"		//SCTLR 
		: 
		: "r" (ttb1), "r" (0xffffffff) 
		: "memory", "r0"
	);

	/*
	asm __volatile__(
		"mrs r0, cpsr\n\t"
		"bic r0, #(1<<7)\n\t"				//cpu使能中断cpsr.I
		"msr cpsr, r0\n\t"
		::: "r0"
	);
	*/

	asm __volatile__(
		"cpsie i"							//cpsr.I = 0
	);

	
	/*
	asm __volatile__(
		".word	0xffffffff"
	);
	*/

	//SGI: CPU0 64
	//cpu: 
	set_one(ICCICR_CPU0, 0);			//使能CPU 接口;
	set_nbit(ICCPMR_CPU0, 0, 8, 255);	//设置CPU 中断屏蔽级别(优先级)

	//ICD:
	set_one(ICDDCR, 0);					//使能仲裁器;	
	set_one(ICDISER2_CPU0, 0);			//使能某一个中断;
	set_nbit(ICDIPR16_CPU0, 0, 8, 100);	//设置中断优先级别;
	set_nbit(ICDIPTR16_CPU0, 0, 8, 1);	//设置中断目标cpu ;	
										//00000001 : cpu0
										//00000010 : cpu1
										//00000011 : cpu0 & cpu1
	//SGI: send IRQID:2 to cpu0
	//set_val(ICDSGIR, (1<<16)|13);	//延迟发生中断
	
	//wdt enable; 2s
	//wdt_timer_init(2);
	
	//pwm timer4;
	//pwm_timer4_stop();
	//pwm_timer4_init(10);
	//pwm_timer0_init(2);

	//key eint irq
	key_irq_init();
	

	printf("main end\n");
	return 0;
}	

asm (
	".align	2\n\t"
	".global	vector_start\n"
"vector_start:\n\t"
	"nop\n\t"
	"ldr pc, _undef\n\t"
	"ldr pc, _swi\n\t"
	"ldr pc, _pabort\n\t"
	"ldr pc, _dabort\n\t"
	"nop\n\t"			
	"ldr pc, _irq\n\t"
	"ldr pc, _firq\n"
"_undef:\n\t"
	".word	undef\n"
"_swi:\n\t"
	".word	swi\n"
"_pabort:\n\t"
	".word	pabort\n"
"_dabort:\n\t"
	".word	dabort\n"
"_irq:\n\t"
	".word	irq\n"
"_firq:\n\t"
	".word	firq\n"

	".global vector_end\n"
"vector_end:\n\t"
	"nop\n\t"
);

void do_undef(unsigned int s)
{
	printf("s = %p\n", s);
}

void do_swi(unsigned int n)
{
	printf("system call num %d\n", n);
}

void do_irq(void)
{
	//printf("do irq\n");
	u32 tmp = get_val(ICCIAR_CPU0);
	printf("CPUID: %d IRQID: %d\n", (tmp >> 10) & 0x7, tmp & 0x3ff);
	set_val(ICCEOIR_CPU0, tmp);
	switch(tmp & 0x3ff) 
	{
		case 75:
			printf("wdt time out\n");
			clear_wdt();
			break;
		case 73:
			printf("pwm timer4 time out\n");
			pwm_timer4_clean_irq();
			break;
		case 64:
			//printf("key down\n");
			do_key();
			break;
	}
}

void do_firq(void)
{

}






