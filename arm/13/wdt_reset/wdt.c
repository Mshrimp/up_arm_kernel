#include <board.h>
#include <wdt.h>
#include <pmu.h>

void wdt_reset_init(unsigned int s)
{
	if(s > 20)
		s = 20;
	set_zero(MASK_WDT_RESET_REQUEST, 20);
	set_zero(AUTOMATIC_WDT_RESET_DISABLE, 20);
	set_val(WTCNT, 3125*s);
	set_val(WTCON, (249<<8)|(1<<5)|(3<<3)|1);
}
