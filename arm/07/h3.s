
	.section	.rodata
	.align	2
.LC0:
	.string	"ar[%3d] = %3d br[%3d] = %3d\n"

	.section	.text
	.align	2
	.global	mod		@int mod(int a, int b)
mod:
	cmp	r0, r1
	subge r0, r1
	bge	mod
	mov pc, lr

	.align	2
	.global	cmp_int
cmp_int:
	ldr r0, [r0]
	ldr r1, [r1]
	cmp	r0, r1
	movgt	r0, #1
	movle	r0, #0
	mov pc, lr

	.align	2
	.global	main
main:
	mov r10, lr		@保存_start返回地址到r10 

	sub sp, sp, #400
	mov r5, sp		@ar
	sub	sp, sp, #400	
	mov r6, sp		@br

	bl	getpid
	bl	srandom

	mov r4, #0
1:
	cmp	r4, #100
	bge	1f
	
	bl	random
	mov r1, #500
	bl	mod
	str r0, [r5, r4, lsl #2]		@r5[r4] = r0

	add r4, #1
	b	1b
1:

	mov r4, #0
1:
	cmp	r4, #100
	bge	1f
	
	ldr r0, [r5, r4, lsl #2]		@r0 = r5[r4]
	str r0, [r6, r4, lsl #2]		@r6[r4] = r0

	add r4, #1
	b	1b
1:

	ldr r3, =cmp_int
	mov r2, #4
	mov r1, #100
	mov r0, r6
	bl	qsort

	mov r4, #0
1:
	cmp	r4, #100
	bge	1f

	ldr r0, [r6, r4, lsl #2]
	push {r0}
	ldr r0, =.LC0
	mov r1, r4
	ldr r2, [r5, r4, lsl #2]
	mov r3, r4
	bl	printf
	pop {r0}

	add r4, #1
	b	1b
1:

	add sp, sp, #800
	mov r0, #0
	mov lr, r10
	mov pc, lr
.L0:
	.word	.LC0

