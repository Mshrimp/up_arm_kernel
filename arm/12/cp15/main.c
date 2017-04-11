#include <config.h>
#include <board.h>
#include <string.h>

int main(void)
{
	printf("MIDR : %p\n", MIDR());
	printf("SCTLR: %p\n", SCTLR());
	printf("TTBCR: %p\n", TTBCR());

	//mmu_enable();

	return 0;
}	

