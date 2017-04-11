#include <config.h>
#include <board.h>
#include <string.h>

u32 *ttb = (void*)0x60000000;	//16K对齐的地址;
u32 *ttb2= (void*)0x60004000;	//1K对齐地址;
int main(void)
{
	memset(ttb, 0, 16 * 1024); 
	//mmu使能后, 所有地址都是虚拟地址;
	u32 i;
	//段映射:
	//ddr内存地址平板映射;
	for(i = 0x40000000; i < 0x80000000; i += 0x100000)
		ttb[i >> 20] = i | 0x2;				//平板映射; 
	//外设寄存器平板映射;
	for(i = 0x10000000; i < 0x14000000; i += 0x100000)
		ttb[i >> 20] = i | 0x2;

	//自定义映射虚拟地址;
	//0xc2345678 --> 0x57845678		
	//	虚拟			物理
	//段映射:
	//ttb[0xc23] = (0x578 << 20) | 0x2;
	
	//粗小映射:
	ttb[0xc23] = ((u32)ttb2 | 0x1);		//一级页表中存二级页表;
	memset(ttb2, 0, 1 * 1024);
	ttb2[0x45] = 0x57845000 | 0x2;		//二级页表小页映射;

	u32 *p = (u32 *)0x57845678;
	*p = 0x11223344;

	p = (void *)0x57845000;
	for(i = 0; i < 1025; i++)
		p[i] = i;
	
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

	p = (u32 *)0xc2345000;
	for(i = 0; i < 1025; i++)
		printf("p[%d] = %d\n", i, p[i]);

	return 0;
}	

