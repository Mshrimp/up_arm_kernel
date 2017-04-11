
	.section	.rodata
	.align	2
.LC0:
	.string	"%s filename\n"
	.align	2
.LC1:
	.string	"r+"
	.align	2
.LC2:
	.string	"fopen"

	.section	.text
	.align	2
	.global	cmp_char
cmp_char:
	ldrb r0, [r0]
	ldrb r1, [r1]
	cmp	r0, r1
	movgt r0, #1
	movle r0, #0
	mov pc, lr

	.align	2
	.global	main
main:
	stmfd sp!, {r4, r5, lr}
	mov fp, sp
	mov r4, r0
	mov r5, r1

	@int main(int argc, char ** argv)
	cmp r4, #2
	beq	1f;

		ldr r0, =stderr	
		ldr r0, [r0]
		ldr r1, =.LC0
		ldr r2, [r5, #0]
		bl	fprintf

		mov r0, #-1
		b	out
1:

	sub sp, sp, #216
	mov r0, sp
	mov r1, #0
	mov r2, #216
	bl	memset

@	FILE *fp = NULL;		@[fp - 4]
@	char buf[200] = {};		@[fp - 204]
@	char **p = NULL;		@[fp - 208]
@	int len = 0;			@[fp - 212]
@	int ret = 0;			@[fp - 216]

	ldr r0, [r5, #4]
	ldr r1, =.LC1
	bl	fopen
	str r0, [fp, #-4]

@	fp = fopen(argv[1], "r+");

	cmp	r0, #0
	bne	1f
	
	ldr r0, =.LC2	
	bl	perror

	mov r0, #-1
	b	out

@	if(NULL == fp)
@	{
@		perror("fopen");
@		return -1;
@	}
1:
	
1:
	sub r0, fp, #204
	mov r1, #200
	ldr r2, [fp, #-4]
	bl	fgets
	cmp	r0, #0
	beq	1f

@		if(fgets(buf, 200, fp) == NULL)
@			break;

	sub r0, fp, #204
	bl	strlen
	cmp	r0, #1
	beq	1b
@
@		if(strlen(buf) == 1)
@			continue;

	ldr r0, [fp, #-208]	
	mov r1, #4
	ldr r2, [fp, #-212]
	add r2, #1
	mul r1, r2, r1
	bl	realloc	
	str r0, [fp, #-208]

@		p = realloc(p, sizeof(char *)*(len+1));

	
	sub r0, fp, #204
	bl	strlen
	sub r1, r0, #1
	sub r0, fp, #204
	mov r2, #1
	ldr r3, =cmp_char
	bl	qsort

@		qsort(buf, strlen(buf)-1, 1, cmp_char);

	sub r0, fp, #204
	bl	strdup
	ldr r1, [fp, #-208]
	ldr r2, [fp, #-212]
	str r0, [r1, r2, lsl #2]

@		p[len] = strdup(buf);

	ldr r0, [fp, #-212]
	add r0, #1
	str r0, [fp, #-212]
	
@		len++;

	sub r0, sp, #204
	mov r1, #0
	mov r2, #200
	bl	memset

@		memset(buf, 0, 200);
	b	1b
1:
	
	ldr r0, [fp, #-4]
	mov r1, #0
	mov r2, #0
	bl	fseek
@	fseek(fp, 0, SEEK_SET);

	mov r4, #0
1:
	ldr r0, [fp, #-212]
	cmp	r4, r0
	bge	1f
		
		ldr r0, [fp, #-4]
		ldr r1, [fp, #-208]
		ldr r1, [r1, r4, lsl #2]
		bl	fprintf
@		fprintf(fp, p[i]);

	add r4, #1
	b	1b
1:

	ldr r0, [fp, #-4]
	bl	fclose
@	fclose(fp);

	mov r0, #0

out:

	mov sp, fp
	ldmfd sp!, {r4, r5, pc}

