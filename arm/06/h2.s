
	.section	.rodata
	.align	2
.LC0:
	.string	"i > 10 && i < 20\n"
	.align	2
.LC1:
	.string	"i > 20 && i < 60\n"
	.align	2
.LC2:
	.string	"i > 60 && i < 90\n"
	.align	2
.LC3:
	.string	"other\n"

	.section	.text
	.align	2
	.global	main
main:
	mov r10, lr		@保存_start返回地址到r10 
	
	mov r4, #20

	cmp	r4, #10
	bgt	cmp2
	b	out1
cmp2:
	cmp r4, #20
	blt	do1
	b	out1
do1:
	ldr r0, =.LC0
	bl	printf
	b	out
out1:
	cmp	r4, #20
	bgt	cmp3
	b	out2
cmp3:
	cmp	r4, #60
	blt	do2
	b	out2
do2:
	ldr r0, =.LC1
	bl	printf
	b	out

out2:
	cmp	r4, #60
	bgt	cmp4
	b	out3
cmp4:
	cmp	r4, #90
	blt	do3
	b	out3
do3:
	ldr r0, =.LC2
	bl	printf
	b	out
out3:
	cmp	r4, #10
	blt	do4
	cmp	r4, #90
	bgt	do4
	b	out
do4:
	ldr r0, =.LC3
	bl	printf
	b	out
out:

	mov r0, #0
	mov lr, r10
	mov pc, lr

