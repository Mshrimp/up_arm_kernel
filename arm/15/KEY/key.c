#include <gpio_reg.h>
#include <board.h>

void key_irq_init(void)
{
	set_nbit(GPX3CON, 8, 16, 0xffff);
	//set_nbit(EXT_INT43CON, 8, 16, 0x2222);//下降延触发;
	//set_nbit(EXT_INT43CON, 8, 16, 0x0);//低电平触发;
	//set_nbit(EXT_INT43CON, 8, 16, 0x3333);//上升延触发;
	set_nbit(EXT_INT43CON, 8, 16, 0x4444);//双边延触发;
	set_nbit(EXT_INT43_MASK, 2, 4, 0);//使能中断;	
}

void do_key(void)
{
	u32 t = get_nbit(EXT_INT43_PEND, 2, 4);
	switch(t)
	{
		case 1:
			if(get_bit(GPX3DAT, 2))
				printf("key1 up\n");
			else
				printf("key1 down\n");
			break;
		case 1<<1:
			if(get_bit(GPX3DAT, 3))
				printf("key2 up\n");
			else
				printf("key2 down\n");
			break;
		case 1<<2:
			if(get_bit(GPX3DAT, 4))
				printf("key3 up\n");
			else
				printf("key3 down\n");
			break;
		case 1<<3:
			if(get_bit(GPX3DAT, 5))
				printf("key4 up\n");
			else
				printf("key4 down\n");
			break;	
	}
	set_val(EXT_INT43_PEND, get_val(EXT_INT43_PEND));
}

void key_config(void)
{
	//@配置GPX3_2-GPM3_5为输入;
	//*(v32 *)GPX3CON &= ~(0xffff00);
	set_nbit(GPX3CON, 8, 16, 0x0);
}

unsigned int key_get(void)
{
	//return (*(v32 *)GPX3DAT >> 2) & 0xf;
	return get_nbit(GPX3DAT, 2, 4);
}
