#include <stdio.h>

int main(void)
{
	int sum = 0;
	int a = 1;
	int b = 2;
	int c = 3;
	int d = 4;
	int e = 5;
	int f = 6;
	int g = 7;
	asm (
		"add %0, %1\n\t"
		"add %0, %2\n\t"
		"add %0, %3\n\t"
		"add %0, %4\n\t"
		"add %0, %5\n\t"
		"add %0, %6\n\t"
		"add %0, %7\n\t"
		"mov r4, #100\n\t"
		: "=&r" (sum)
		: "r"(a), "r"(b), "r"(c), "r"(d), "r"(e), "r"(f), "r"(g)
		: "r4"		//告诉编译器我破坏了r4
	);
	printf("sum = %d\n", sum);
	return 0;
}
