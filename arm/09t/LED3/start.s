	
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
	
loop:
	ldr r0, =0x110002E4
	ldr r1, [r0]
	orr r1, r1, #0xf
	str r1, [r0]

	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xF
	orr r1, r1, #0xE		
	str r1, [r0]

	@延时约1秒
	mov r2, #0x9F
	mov r0, r2, lsl #12
	mov lr, pc
	ldr pc, =0xc3e26588

	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xF
	orr r1, r1, #0xD
	str r1, [r0]

	@延时约1秒
	mov r2, #0x9F
	mov r0, r2, lsl #12
	mov lr, pc
	ldr pc, =0xc3e26588

	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xF
	orr r1, r1, #0xB		
	str r1, [r0]

	@延时约1秒
	mov r2, #0x9F
	mov r0, r2, lsl #12
	mov lr, pc
	ldr pc, =0xc3e26588

	ldr r0, =0x110002E4
	ldr r1, [r0]
	bic r1, r1, #0xF
	orr r1, r1, #0x7		
	str r1, [r0]

	@延时约1秒
	mov r2, #0x9F
	mov r0, r2, lsl #12
	mov lr, pc
	ldr pc, =0xc3e26588


	b	loop


	ldmfd sp!, {pc}



