#include <stdio.h>

int main(void)
{
	unsigned int cpsr;
	int val = 0xf0000000;

	asm (
		"msr cpsr, %1\n\t"
		"mrs %0, cpsr\n\t"
		: "=r" (cpsr)			//输出部分;
		: "r" (val)				//输入部分;
		:						//破坏部分;
	);

	printf("cpsr = %p\n", cpsr);

	return 0;
}
