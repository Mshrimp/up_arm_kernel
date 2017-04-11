#include <config.h>
#include <board.h>

int sum = 0;

void delay(volatile unsigned int n)
{
	while(n--);
}

void __udelay(unsigned int n)
{
	((delay_t)udelay)(n);
}

/*
void *memset(void *s, int c, int size)
{
	while(size--)
		((char *)s)[size] = c;
	((char *)s)[size] = c;

	return s;
}
*/

