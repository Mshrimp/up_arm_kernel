
	.section	.rodata
	.align	2
.LC0:
	.string	"val = %p\n"

	.section	.text
	.align	2
	.global	main
main:
	mov r10, lr		@保存_start返回地址到r10 

	mov r1, #0xff
	bic r1, r1, #(1<<3)
	ldr r0, =.LC0
	bl	printf

	mov r1, #0xff
	bic r1, r1, #((1<<3)|(1<<5)|(1<<7))
	ldr r0, =.LC0
	bl	printf

	mov r1, #0xf0
	orr r1, r1, #(1<<3)
	ldr r0, =.LC0
	bl	printf

	mov r1, #0xff00
	orr r1, r1, #((1<<3)|(1<<5)|(1<<7))
	ldr r0, =.LC0
	bl	printf

	mov r1, #0xff00
	add r1, r1, #0x37
	bic r1, r1, #(0xf0<<3)
	bic r1, r1, #(0xf<<3)
	bic r1, r1, #(0x300<<3)
	mov r2, #0x300
	add r2, #0x27			@0x327<<3
	orr r1, r1, r2, lsl #3
	ldr r0, =.LC0
	bl	printf

	
	mov r1, #0xff00
	add r1, r1, #0x37
	mov r2, #0xff
	add r2, #0x300			@0x3ff<<3
	eor r1, r1, r2, LSL #3
	ldr r0, =.LC0
	bl	printf


	mov r1, #0xff00
	add r1, r1, #0x37
	mov r2, #0xff
	add r2, #0x300
	and r1, r1, r2, lsl #3	
	lsr r1, #3
	ldr r0, =.LC0
	bl	printf

	mov r0, #0
	mov lr, r10
	mov pc, lr

