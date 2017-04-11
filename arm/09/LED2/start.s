	
	.section	.text
	.align	2
	.global	_start
_start:
	stmfd sp!, {lr}

	bl	led_config

1:
	bl	led_allon
	@ldr r0, =1000000000
	@bl	delay
	ldr r0, =1000000
	mov lr, pc
	ldr pc, =0x43e26480

	bl	led_alloff
	@ldr r0, =1000000000
	@bl	delay
	ldr r0, =1000000
	mov lr, pc
	ldr pc, =0x43e26480
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

