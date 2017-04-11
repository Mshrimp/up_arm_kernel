#include <stdio.h>

int main(void)
{
	int i, j, k;
	asm (
		"mov %0, #1\n\t"
		"mov %1, #2\n\t"
		"mov %2, #3\n\t"
		: "=r" (i), "=r" (j), "=r" (k)
	);

	printf("i = %d, j = %d, k = %d\n", i, j, k);

	return 0;
}
