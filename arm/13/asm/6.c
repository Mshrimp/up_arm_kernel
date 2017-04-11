#include <stdio.h>

int main(void)
{
	int sum = 10;
	asm (
		"add %0, %1, #1\n\t"
		: "=r" (sum)
		: "r" (sum)
	);
	printf("sum = %d\n", sum);
	asm (
		"add %0, %0, #1\n\t"
		: "+r" (sum)
	);
	printf("sum = %d\n", sum);
	return 0;
}
