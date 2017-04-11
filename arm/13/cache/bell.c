#include <gpio_reg.h>
#include <board.h>
#include <gpio.h>

int bell_count = 0;

void bell_config(void)
{
	//*(v32 *)GPD0CON &= ~0xf;
	//*(v32 *)GPD0CON |= 0x1;
	//set_nbit(GPD0CON, 0, 4, 1);

	gpio_cfg_pin((void *)GPD0CON, 0, 1);
	bell_count ++;
}

void bell_on(void)
{
	//*(v32 *)GPD0DAT |= 1;
	set_one(GPD0DAT, 0);
}

void bell_off(void)
{
	//*(v32 *)GPD0DAT &= ~1;
	set_zero(GPD0DAT, 0);
}


