#include <config.h>
#include <board.h>
#include <string.h>

extern void vector_start();
extern void vector_end();

u32 *ttb1 = (void*)0x60000000;	//16K对齐的地址;
int main(void)
{
	memset(ttb1, 0, 16 * 1024); 
	mmu_l1_init(ttb1);
	//自定义映射虚拟地址;
	//	虚拟			物理
	//0xffff0000 --> 0x7fff0000		(0x40000000 - 0x80000000)
	mmu_l1_mmap(ttb1, 0xffff0000, 0x7fff0000);
	memcpy((void*)0x7fff0000, vector_start, vector_end - vector_start);
	set_h_vector();

	set_ttb(ttb1);
	set_domain(0xffffffff);	
	mmu_enable();
	
	printf("swi start\n");
	//asm ("swi #5");			//内嵌汇编;
	asm ("svc #5");			//内嵌汇编;
	printf("swi end\n");

	printf("undef start\n");
	asm (".word	0xffffffff");	
	//asm (".short	0xffff");
	printf("undef end \n");

	printf("dabort start\n");
	u32 *p = (void *)0xc0000000;
	*p = 120;
	printf("dabort end\n");

	printf("pabort start\n");
	void (*func)(void) = (void*)0xc0000000;
	func();
	asm (
		".global	main_end\n"
	"main_end: nop\n"
	);
	printf("pabort end\n");

	printf("reset start\n");
	udelay(1000000);
	reset();
	printf("reset end\n");

	return 0;
}	

