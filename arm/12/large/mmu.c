#include <config.h>
#include <board.h>

void mmu_l1_init(u32 *ttb)
{
	u32 i;
	//段映射:
	//ddr内存地址平板映射;
	for(i = 0x40000000; i < 0x80000000; i += 0x100000)
		ttb[i >> 20] = i | 0x2;				//平板映射; 
	//外设寄存器平板映射;
	//uart <- printf
	for(i = 0x10000000; i < 0x14000000; i += 0x100000)
		ttb[i >> 20] = i | 0x2;
}

void mmu_l1_mmap(u32 *ttb, u32 va, u32 pa)
{
	//段映射:
	ttb[va >> 20] = (pa & 0xfff00000) | 0x2;
}

void mmu_l2_init(u32 *ttb, u32 **ttb2)		
{
	u32 i, j;
	//段映射:
	//ddr内存地址平板映射;
	for(i = 0x40000000; i < 0x80000000; i += 0x100000)
	{
		ttb[i >> 20] = ((u32)*ttb2) | 0x1;				//1M
		for(j = 0x0; j < 0x100000; j += 0x1000)
			(*ttb2)[j>>12] = (i + j) | 0x2;
		*ttb2 += 256;
	}
	//外设寄存器平板映射;
	//uart <- printf
	for(i = 0x10000000; i < 0x14000000; i += 0x100000)
	{
		ttb[i >> 20] = ((u32)*ttb2) | 0x1;				//1M
		for(j = 0x0; j < 0x100000; j += 0x1000)
			(*ttb2)[j>>12] = (i + j) | 0x2;
		*ttb2 += 256;
	}
}

void mmu_l2_mmap(u32 *ttb, u32 *ttb2, u32 va, u32 pa)
{
	//粗小映射:
	ttb[va >> 20] = ((u32)ttb2 | 0x1);		//一级页表中存二级页表;
	ttb2[(va >> 12)&0xff] = (pa & 0xfffff000)|0x2;	//二级页表小页映射;
}


