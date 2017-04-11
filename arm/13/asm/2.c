#include <stdio.h>

int main(void)
{
	unsigned int cpsr;

	asm (
		"mrs %0, cpsr\n\t"
		: "=r" (cpsr)			//输出部分;
		:						//输入部分;
		:						//破坏部分;
	);

	printf("cpsr = %p\n", cpsr);

	return 0;
}
