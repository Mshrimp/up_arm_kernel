	
	.section	.text
	.align	2
	.global	_start
_start:
	stmfd sp!, {lr}

	ldr r0, =0x110002E0
	ldr r1, [r0]
	ldr r2, =0xFFFF		@清除低16位;
	bic	r1, r1, r2
	ldr r2, =0x1111		@设置低16位为1111; 输出;
	orr r1, r1, r2
	str r1, [r0]


	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xf	@清除GPM4低四位
	str r1, [r0]
	
	mov r4, #0

loop:
	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xf
	str r1, [r0]

	mov r5, #1

flow:
	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xF
	bic r1, r1, r5	
	str r1, [r0]

	@延时约1秒
	mov r0, #0x9F
	mov r0, r0, lsl #12
	mov lr, pc
	ldr pc, =0xc3e26588

	lsl r5, #1

	cmp	r5, #0x8
	ble	flow

	add r4, #1
	cmp r4, #5
	bgt	out

	b	loop

out:
	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xf
	str r1, [r0]

	@延时约1秒
	mov r0, #0x9F
	mov r0, r0, lsl #12
	mov lr, pc
	ldr pc, =0xc3e26588

	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xf
	str r1, [r0]


	ldmfd sp!, {pc}



