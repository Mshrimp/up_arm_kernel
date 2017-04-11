#include <stdio.h>

int main(void)
{
	int i = 10;
	int j = 20;
	int k = 30;
	int sum = 0;
	asm (
		"add %0, %1\n\t"
		"add %0, %2\n\t"
		"add %0, %3\n\t"
		: "=r" (sum)
		: "r" (i), "r" (j), "r" (k)
	);

	printf("sum = %d\n", sum);
	return 0;
}
