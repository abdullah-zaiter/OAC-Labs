	.file	"sortc2.c"
	.option nopic
	.text
#	.align	2
	.globl	show
#	.type	show, @function
printf: li a7,1
	mv a0,a1
	ecall
	li a7,11
	li a0,9
	ecall
	ret
	
putchar: li a7,11
	ecall
	ret


memcpy:
	or	a3,a0,a1
	andi	a3,a3,3
	mv	a4,a0
	mv	a5,a1
	bnez	a3,.L20
	andi	a3,a2,3
	beqz	a3,.L30

.L20:
	add	a2,a1,a2
.L40:
	bne	a5,a2,.L7
	ret
.L30:
	andi	a2,a2,-4
	add	a2,a1,a2
.L50:
	bne	a5,a2,.L60
	ret
.L60:
	lw	a3,0(a5)
	addi	a4,a4,4
	addi	a5,a5,4
	sw	a3,-4(a4)
	j	.L50
.L70:
	lbu	a3,0(a5)
	addi	a4,a4,1
	addi	a5,a5,1
	sb	a3,-1(a4)
	j	.L40
	.size	memcpy, .-memcpy



show:
	addi	sp,sp,-32
	sw	s0,24(sp)
	sw	s1,20(sp)
	sw	s2,16(sp)
	sw	s3,12(sp)
	sw	ra,28(sp)
	mv	s2,a1
	mv	s1,a0
	li	s0,0
	lui	s3,%hi(.LC1)
.L2:
	blt	s0,s2,.L3
	lw	s0,24(sp)
	lw	ra,28(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	li	a0,10
	addi	sp,sp,32
	tail	putchar
.L3:
	lw	a1,0(s1)
	addi	a0,s3,%lo(.LC1)
	addi	s0,s0,1
	call	printf
	addi	s1,s1,4
	j	.L2
	.size	show, .-show
#	.align	2
	.globl	swap
#	.type	swap, @function
swap:
	slli	a1,a1,2
	add	a5,a0,a1
	addi	a1,a1,4
	add	a0,a0,a1
	lw	a3,0(a0)
	lw	a4,0(a5)
	sw	a3,0(a5)
	sw	a4,0(a0)
	ret
	.size	swap, .-swap
#	.align	2
	.globl	sort
#	.type	sort, @function
sort:
	addi	sp,sp,-32
	sw	s1,20(sp)
	sw	s3,12(sp)
	sw	s4,8(sp)
	sw	s5,4(sp)
	sw	ra,28(sp)
	sw	s0,24(sp)
	sw	s2,16(sp)
	mv	s3,a0
	mv	s4,a1
	li	s1,0
	li	s5,-1
.L7:
	blt	s1,s4,.L11
	lw	ra,28(sp)
	lw	s0,24(sp)
	lw	s1,20(sp)
	lw	s2,16(sp)
	lw	s3,12(sp)
	lw	s4,8(sp)
	lw	s5,4(sp)
	addi	sp,sp,32
	jr	ra
.L11:
	slli	s0,s1,2
	addi	s2,s1,-1
	add	s0,s3,s0
.L8:
	beq	s2,s5,.L9
	lw	a4,-4(s0)
	addi	s0,s0,-4
	lw	a5,4(s0)
	bgt	a4,a5,.L10
.L9:
	addi	s1,s1,1
	j	.L7
.L10:
	mv	a1,s2
	mv	a0,s3
	call	swap
	addi	s2,s2,-1
	j	.L8
	.size	sort, .-sort
	.section	.text.startup,"ax",progbits
#	.align	2
	.globl	main
#	.type	main, @function
main:
	addi	sp,sp,-64
	lui	a1,%hi(.LC0)
	li	a2,40
	addi	a1,a1,%lo(.LC0)
	addi	a0,sp,8
	sw	ra,60(sp)
	call	memcpy
	addi	a0,sp,8
	li	a1,10
	call	show
	addi	a0,sp,8
	li	a1,10
	call	sort
	addi	a0,sp,8
	li	a1,10
	call	show
	lw	ra,60(sp)
	addi	sp,sp,64
	jr	ra
	.size	main, .-main
	.section	.rodata
#	.align	2
	.set	.LANCHOR0,. + 0

.data
.LC0:
	.word	5
	.word	8
	.word	3
	.word	4
	.word	7
	.word	6
	.word	8
	.word	0
	.word	1
	.word	9
	.section	.rodata.str1.4,"aMS",progbits,1
	.align	2
.LC1:
	.string	"%d\t"
	.ident	"GCC: (GNU) 7.2.0"
