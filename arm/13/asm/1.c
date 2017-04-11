#include <stdio.h>

int main(void)
{
	asm (
		"nop\n\t"
		"nop\n\t"
		"nop"
	);

	asm ("nop");
	asm ("nop");
	asm ("nop");

	return 0;
}
