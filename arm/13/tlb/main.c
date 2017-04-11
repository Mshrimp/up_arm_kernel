#include <config.h>
#include <board.h>
#include <string.h>

u32 *ttb1 = (void*)0x60000000;	//16K对齐的地址;
u32 *ttb2 = (void*)0x60004000;
int main(void)
{
	memset(ttb1, 0, 16 * 1024); 
	memset(ttb2, 0, 16 * 1024);
	mmu_l1_init(ttb1);
	mmu_l1_init(ttb2);
	//自定义映射虚拟地址;
	//进程1:
	//	虚拟			物理
	//0xc2345678 --> 0x57845678		
	//进程2:
	//0xc2345678 --> 0x55545678
	
	mmu_l1_mmap(ttb1, 0xc2345678, 0x57845678);
	u32 *p = (u32 *)0x57845678;
	*p = 0x11223344;

	mmu_l1_mmap(ttb2, 0xc2345678, 0x55545678); 
	p = (u32 *)0x55545678;
	*p = 0x55667788;

	set_ttb(ttb1);
	set_domain(0xffffffff);	
	mmu_enable();

	p = (u32 *)0xc2345678;
	while(1)
	{
		clear_tlb();
		set_ttb(ttb1);
		printf("pid1: *p = %p\n", *p);
		printf("running ...\n");
		udelay(1000000);

		clear_tlb();
		set_ttb(ttb2);
		printf("pid2: *p = %p\n", *p);
		printf("running ...\n");
		udelay(1000000);
	}
	return 0;
}	

