#include <adc.h>

	.section	.text
	.align	2
	.global	adc_config
adc_config:
	@mov pc, lr

	stmfd sp!, {lr}
	ldr r0, =ADC_CON
	ldr r1, [r0]

	ldr r2, =0
	orr r2, #(1<<16)
	orr r2, #(1<<14)
	ldr r3, =(19<<6)
	orr r1, r2, r3	@
		
	str r1, [r0]

	mov r0, r1
	ldmfd sp!, {pc}



	.align	2
	.global	adc_mux
adc_mux:	@ 0 1 2 3
	stmfd sp!, {r4, lr}

	mov r4, r0
	ldr r0, =ADC_MUX
	ldr r1, [r0]
	bic r1, #0xF
	orr r1, r4
	str r1, [r0]

	ldmfd sp!, {r4, pc}


	.align	2
	.global	adc_start
adc_start:
	stmfd sp!, {lr}

	ldr r0, =ADC_CON
	ldr r1, [r0]
	orr r1, #1

	str r1, [r0]

	ldmfd sp!, {pc}


	.align	2
	.global	adc_end
adc_end:
	ldr r0, =ADC_CON
	ldr r1, [r0]

	tst r1, #(1<<15)
	beq		false
true:
	mov r0, #1
	b	out
false:
	mov r0, #0
out:
	mov pc, lr


	.align	2
	.global	adc_get_data
adc_get_data:
	ldr r1, =ADC_DAT
	ldr r0, [r1]
	ldr r2, =((1<<12)-1)
	and r0, r2	
	
	mov pc, lr


