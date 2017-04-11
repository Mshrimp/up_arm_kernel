	
	.section	.text
	.align	2
	.global	_start
_start:
	stmfd sp!, {lr}

	bl	led_config
	
	mov r4, #0
loop:
	bl	led_allon
	@ldr r0, =1000000000
	@bl	delay
	ldr r0, =1000000
	mov lr, pc
	ldr pc, =0xc3e26588

	bl	led_alloff
	@ldr r0, =1000000000
	@bl delay
	ldr r0, =1000000
	mov lr, pc
	ldr pc, =0xc3e26588

	add r4, #1
	cmp r4, #10
	bge		out

	b	loop

out:
	ldmfd sp!, {pc}


	.align	2
	.global	led_config
led_config:
	stmfd sp!, {lr}

	@配置GPM4_0 - GPM4_3为输出
	ldr r0, =0x110002E0
	ldr r1, [r0]
	ldr r2, =0xFFFF		@清除低16位
	bic r1, r1, r2
	ldr r2, =0x1111		@设置为输出
	orr r1, r1, r2
	str r1, [r0]

	ldmfd sp!, {pc}


	.align	2
	.global	led_allon
led_allon:
	stmfd sp!, {lr}

	@设置GPM4_0 - GPM4_3输出为低电平
	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xf	@将低4位输出设置为低
	str r1, [r0]

	ldmfd sp!, {pc}


	.align	2
	.global	led_alloff
led_alloff:
	stmfd sp!, {lr}

	@设置GPM4_0 - GPM4_3输出为高电平
	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xf		@将低4位输出设置为高
	str r1, [r0]

	ldmfd sp!, {pc}


	.align	2
	.global	delay
delay:
	subs r0, #1
	bne		delay
	mov pc, lr




