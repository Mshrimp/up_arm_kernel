	
#include <gpio.h>
@.equ	GPM4CON, 0x110002E0

	.section	.text
	.align	2
	.global	led_config
led_config:
	stmfd sp!, {lr}

	@配置GPM4_0-GPM4_1为输出;
	@ldr r0, =0x110002E0
	ldr r0, =GPM4CON	
	ldr r1, [r0]
	ldr r2, =0xFFFF		@清除低16位;
	bic	r1, r1, r2
	ldr r2, =0x1111		@设置低16位为1111; 输出;
	orr r1, r1, r2
	str r1, [r0]

	ldmfd sp!, {pc}

	.align	2
	.global	led_allon
led_allon:
	stmfd sp!, {lr}	

	@GPM4_0-GPM4_1输出低电平;
	ldr r0, =GPM4DAT
	ldr r1, [r0]
	bic r1, r1, #0xf	@输出低电平;
	str r1, [r0]

	ldmfd sp!, {pc}

	.align	2
	.global	led_alloff
led_alloff:
	stmfd sp!, {lr}	

	@GPM4_0-GPM4_1输出低电平;
	ldr r0, =GPM4DAT
	ldr r1, [r0]
	orr r1, r1, #0xf	@输出高电平;
	str r1, [r0]

	ldmfd sp!, {pc}


	.align	2
	.global	led_on
led_on:	@0 1 2 3
	stmfd sp!, {lr}
	mov r2, r0

	ldr r0, =GPM4DAT
	ldr r1, [r0]
	mov r3, #1
	bic r1, r1, r3, lsl r2 
	str r1, [r0]

	ldmfd sp!, {pc}

	.align	2
	.global	led_off
led_off:	@0 1 2 3
	stmfd sp!, {lr}
	mov r2, r0

	ldr r0, =GPM4DAT
	ldr r1, [r0]
	mov r3, #1
	orr r1, r1, r3, lsl r2 
	str r1, [r0]

	ldmfd sp!, {pc}

	.align	2
	.global	led_set
led_set:
	mov r2, r0
	ldr r0, =GPM4DAT
	ldr r1, [r0]
	mvn r3, #0			@0xffffffff
	and r3, r2			@0xfffffff?
	orr r1, #0xf
	and r1, r3			@
	str r1, [r0]
	mov pc, lr	

	.align	2
	.global	led_get
led_get:
	ldr r1, =GPM4DAT
	ldr r0, [r1]
	mov pc, lr	

	

