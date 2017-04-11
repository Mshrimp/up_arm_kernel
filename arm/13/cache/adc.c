#include <board.h>
#include <adc.h>

void adc_config(void)
{
	set_val(ADCCON, (1<<16)|(1<<14)|(19<<6));
}

void adc_mux(int n)
{
	set_nbit(ADCMUX, 0, 4, n);
}

void adc_start(void)
{
	set_one(ADCCON, 0);
}

int adc_end(void)
{
	return get_bit(ADCCON, 15);
}

int adc_data(void)
{
	return get_nbit(ADCDAT, 0, 12);
}

