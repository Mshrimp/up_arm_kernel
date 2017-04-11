#include <board.h>
#include <pwm.h>

void pwm_timer4_init(unsigned int s)
{
	//100MHZ / (249+1) / 4 = 100000HZ
	set_nbit(TCFG0, 8, 8, 249);		// /(249+1)
	set_nbit(TCFG1, 16, 4, 2);		// /4
	set_val(TCNTB4, 100000 * s);
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
	set_val(TCNTB0, 100000 * s);
	set_nbit(TCON, 0, 5, 2);	
	set_one(TINT_CSTAT, 0);
	set_nbit(TCON, 0, 5, 9);
}

void pwm_timer0_stop(void)
{
	set_zero(TCON, 0);
}

void pwm_timer0_clean_irq(void)
{
	set_one(TINT_CSTAT, 5);
}
