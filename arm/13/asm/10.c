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
	asm __volatile__(
		"add %0, %1\n\t"
		"add %0, %2\n\t"
		"add %0, %3\n\t"
		"add %0, %4\n\t"
		"add %0, %5\n\t"
		"add %0, %6\n\t"
		"ldr r4, %[abc]\n\t"
		"add %0, r4\n\t"
		: "=&r" (sum)		//& = + r
		: "I"(1), "r"(b), "r"(c), "r"(d), "r"(e), "r"(f), [abc]"m"(g) //I m r
		: "memory", "r4"		//告诉编译器我破坏了r4
	);
	printf("sum = %d\n", sum);
	return 0;
}
