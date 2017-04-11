	
	.section	.text
	.align	2
	.global	_start
_start:
	stmfd sp!, {lr}

	bl	led_config

	mov r4, #0
1:
	mov r0, r4
	bl	led_on
	ldr r0, =10000
	bl	udelay

	mov r0, r4
	bl	led_off
	ldr r0, =10000
	bl	udelay

	add r4, #1
	cmp	r4, #4
	moveq	r4, #0
	b	1b

	ldmfd sp!, {pc}

	.align	2
	.global	led_config
led_config:
	stmfd sp!, {lr}

	@配置GPM4_0-GPM4_1为输出;
	ldr r0, =0x110002E0
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
	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xf	@输出低电平;
	str r1, [r0]

	ldmfd sp!, {pc}

	.align	2
	.global	led_alloff
led_alloff:
	stmfd sp!, {lr}	

	@GPM4_0-GPM4_1输出低电平;
	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xf	@输出高电平;
	str r1, [r0]

	ldmfd sp!, {pc}


	.align	2
	.global	delay
delay:
	subs r0, #1
	bne	delay
	mov pc, lr

	.align	2
	.global	udelay
udelay:
	stmfd sp!, {lr}
	mov lr, pc
	ldr pc, =0x43e26480	
	ldmfd sp!, {pc}

	.align	2
	.global	led_on
led_on:	@0 1 2 3
	stmfd sp!, {lr}
	mov r2, r0

	ldr r0, =0x110002E4
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

	ldr r0, =0x110002E4
	ldr r1, [r0]
	mov r3, #1
	orr r1, r1, r3, lsl r2 
	str r1, [r0]

	ldmfd sp!, {pc}


