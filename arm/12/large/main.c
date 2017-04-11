#include <config.h>
#include <board.h>
#include <string.h>

u32 *ttb = (void*)0x60000000;	//16K对齐的地址;
u32 *ttb2= (void*)0x61000000;	//1K对齐地址;
int main(void)
{
	memset(ttb, 0, 16 * 1024); 

	mmu_l2_init(ttb, &ttb2);
	//mmu_l1_init(ttb);
	//自定义映射虚拟地址;
	//0xc2345678 --> 0x57845678		
	//	虚拟			物理
	
	mmu_l2_mmap(ttb, ttb2, 0xc2345678, 0x57845678);
	//粗小映射:
	//mmu_l1_mmap(ttb, 0xc2345678, 0x57845678);

	u32 *p = (u32 *)0x57845678;
	*p = 0x11223344;

	//设置映射表的基地址;
	set_ttb(ttb);
	//设置域访问控制权限; (管理者身份)
	set_domain(0xffffffff);	
	printf("start enable mmu\n");
	//使能mmu;
	mmu_enable();
	printf("end enable mmu\n");

	//0xc2345678 -> 0x57845678
	//0x57845678 -> 0x57845678
	p = (u32 *)0xc2345678;
	printf("*p = %p\n", *p);
	p = (u32 *)0x57845678;
	printf("*p = %p\n", *p);

	return 0;
}	

