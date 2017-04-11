#include <stdio.h>

void func(int);

int main(void)
{
	int val = 0xff;
	int *p = &val;
	*p &= ~0xf;

	func(*p);
	
	return 0;		//输入和输出;
}
