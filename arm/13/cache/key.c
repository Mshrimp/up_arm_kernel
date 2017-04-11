#include <gpio_reg.h>
#include <board.h>

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
