
	.section	.rodata
	.align	2
.LC0:
	.string	"val = %p\n"
	.align	2
.LC1:
	.string	"0x1 0x1000 + 0xF0000008 * 0x1000000F = %p %p\n"

	.section	.text
	.align	2
	.global	main
main:
	stmfd sp!, {lr}

	@mov r2, #100
	@cmp	r2, #200
	@cpylt	r1, r2
	@.word	0b10110001101000000001000000000010

	@ldr r2, .L0
	ldr r2, =0x11223344
	cmp r2, #0
	revgt r1, r2
	ldr r0, =.LC0
	bl	printf


	mov r1, #0x1
	mov r2, #0x1000
	mov r3, #0xF0000008
	mov r4, #0x1000000F
	cmp r2, r1
	@smlalbtgt r2, r1, r3, r4
	.word 0b11000001010000010010010011000011
	ldr r0, =.LC1
	bl	printf
	

loop:
	nop
	mov r1, #0x100
	ldr r0, =.LC0
	bl	printf
	@.word	0b11101010111111111111111111111010 
	.word	0xeafffffa


	@andeq r0, r1, r4, LSL pc

	andeq r8, r0, r0, ror #8

	ldmfd sp!, {pc}

@.L0
	@.word	0x11223344


