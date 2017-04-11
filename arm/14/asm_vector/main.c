#include <config.h>
#include <board.h>
#include <string.h>
#include <wdt.h>

extern void vector_start();
extern void vector_end();

u32 *ttb1 = (void*)0x60000000;	//16K对齐的地址;
int main(void)
{
	printf("main start\n");
	memset(ttb1, 0, 16 * 1024); 
	mmu_l1_init(ttb1);
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
	
	asm __volatile__(
		".word	0xffffffff"
	);

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

}

void do_firq(void)
{

}






