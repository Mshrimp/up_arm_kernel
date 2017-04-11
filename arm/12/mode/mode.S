

	.section	.text
	.align	2
	.global	get_mode
get_mode:
	mrs r0, cpsr
	mov pc, lr

	.section	.text
	.align	2
	.global	set_mode
set_mode:
	@stmfd sp!, {lr}
	mov r10, lr
	mrs r1, cpsr
	bic r1, r1, #0x1f
	orr r1, r1, r0
	msr cpsr, r1
	ldr sp, =0x70000000
	mov pc, r10
	@ldmfd sp!, {pc}

