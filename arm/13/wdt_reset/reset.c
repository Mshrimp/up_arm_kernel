#include <config.h>
#include <board.h>
#include <pmu.h>

void reset(void)
{
	set_one(SWRESET, 0);
}


