#include <board.h>
#include <gpio_reg.h>
#include <pwm.h>

void pwm_timer4_init(unsigned int s)
{
	//100MHZ / (249+1) / 4 = 100000HZ
	set_nbit(TCFG0, 8, 8, 249);		// /(249+1)
	set_nbit(TCFG1, 16, 4, 2);		// /4
	set_val(TCNTB4, s);
	set_one(TCON, 21);
	set_one(TINT_CSTAT, 4);			//enable timer4 irq
	//set_nbit(TCON, 20, 3, 7);		//TCNTB4 -> TCNT4	
	set_nbit(TCON, 20, 3, 5);		//auto-reload start
}
void pwm_timer4_stop(void)
{
	set_zero(TCON, 20);
}

void pwm_timer4_clean_irq(void)
{
	set_one(TINT_CSTAT, 9);
}

void pwm_timer0_init(unsigned int s)
{
	//100MHZ / (249+1) / 4 = 100000HZ
	set_nbit(TCFG0, 0, 8, 249);		// /(249+1)
	set_nbit(TCFG1, 0, 4, 2);		// /4
	set_val(TCNTB0, s);
	set_nbit(TCON, 0, 5, 2);	
	set_one(TINT_CSTAT, 0);
	set_nbit(TCON, 0, 5, 9);
}

void pwm_tout0_init(unsigned int s)
{
	set_nbit(GPD0CON, 0, 4, 2);

	set_nbit(TCFG0, 0, 8, 249);		// /(249+1)
	set_nbit(TCFG1, 0, 4, 2);		// /4
	set_val(TCNTB0, s);		// 总数;
	set_val(TCMPB0, s/2);	// 什么时候翻转;
	set_nbit(TCON, 0, 5, 2);	
	set_one(TINT_CSTAT, 0);
	set_nbit(TCON, 0, 5, (1<<3)|1);
}

void pwm_timer0_set_tcntb0(unsigned int v)
{
	set_val(TCNTB0, v);		// 总数;
}
void pwm_timer0_set_tcmpb0(unsigned int v)
{
	set_val(TCMPB0, v);	// 什么时候翻转;
}
unsigned int pwm_timer0_get_tcnto0(void)
{
	return get_val(TCNTO0);
}

void pwm_timer0_stop(void)
{
	set_zero(TCON, 0);
}

void pwm_timer0_clean_irq(void)
{
	set_one(TINT_CSTAT, 5);
}
