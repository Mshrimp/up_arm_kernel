#include <gpio.h>
#include <board.h>

void led_config(void)
{
	//配置GPM4_0-GPM4_1为输出;
	set_nbit(GPM4CON, 0, 16, 0x1111);
}

void led_allon(void)
{
	//GPM4_0-GPM4_1输出低电平;
	//*(v32*)GPM4DAT &= ~0xf;
	set_nbit(GPM4DAT, 0, 4, 0x0);
}

void led_alloff(void)
{
	//GPM4_0-GPM4_1输出低电平;
	//*(v32*)GPM4DAT |= 0xf;
	set_nbit(GPM4DAT, 0, 4, 0xf);
}

typedef enum {one, two, three, four} LED;

void led_on(LED num)	//0 1 2 3
{
	//*(v32*)GPM4DAT &= ~(1<<num);
	set_zero(GPM4DAT, num);
}

void led_off(LED num)	//0 1 2 3
{
	//*(v32*)GPM4DAT |= (1<<num);
	set_one(GPM4DAT, num);
}

void led_set(unsigned int val)
{
	//*(v32 *)GPM4DAT |= 0xf;
	//*(v32 *)GPM4DAT &= (val | 0xfffffff0);
	set_nbit(GPM4DAT, 0, 4, val);
}

unsigned int led_get(void)
{
	//return *(v32 *)GPM4DAT;
	return get_nbit(GPM4DAT, 0, 4);
}
	
