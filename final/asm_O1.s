	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_zmmul1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	2
	.globl	next_random
	.type	next_random, @function
next_random:
	li	a5,1662976
	addi	a5,a5,1549
	mul	a0,a0,a5
	li	a5,1013903360
	addi	a5,a5,863
	add	a0,a0,a5
	ret
	.size	next_random, .-next_random
	.align	2
	.globl	get_bucket
	.type	get_bucket, @function
get_bucket:
	mv	a5,a0
	li	a4,49
	ble	a0,a4,.L4
	li	a4,64
	li	a0,1
	ble	a5,a4,.L2
	li	a4,74
	li	a0,2
	ble	a5,a4,.L2
	li	a0,84
	sgt	a0,a5,a0
	addi	a0,a0,3
	ret
.L4:
	li	a0,0
.L2:
	ret
	.size	get_bucket, .-get_bucket
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	sw	s1,36(sp)
	sw	s2,32(sp)
	sw	s3,28(sp)
	sw	s4,24(sp)
	sw	s5,20(sp)
	sw	s6,16(sp)
	sw	s7,12(sp)
	sw	s8,8(sp)
	sw	s9,4(sp)
	lui	s0,%hi(.LANCHOR0)
	addi	s0,s0,%lo(.LANCHOR0)
	addi	s2,s0,172
	mv	a2,s0
	li	a3,1228800
	addi	a3,a3,1219
	li	a7,1662976
	addi	a7,a7,1549
	li	a6,1013903360
	addi	a6,a6,863
	li	a0,1148157952
	addi	a0,a0,1623
	li	t1,101
.L9:
	mul	a3,a3,a7
	add	a3,a3,a6
	srli	a4,a3,16
	mulhu	a5,a4,a0
	sub	a1,a4,a5
	srli	a1,a1,1
	add	a5,a5,a1
	srli	a5,a5,6
	mul	a5,a5,t1
	sub	a4,a4,a5
	sw	a4,0(a2)
	addi	a2,a2,4
	bne	a2,s2,.L9
	lui	a5,%hi(pass_count)
	lw	s5,%lo(pass_count)(a5)
	mv	s1,s0
	li	s7,0
	li	s3,0
	lui	s4,%hi(.LANCHOR0)
	addi	s4,s4,%lo(.LANCHOR0)
	li	s6,58
	li	s8,1
	j	.L11
.L10:
	slli	a0,a0,2
	add	a0,s4,a0
	sw	a5,172(a0)
	addi	s1,s1,4
	beq	s1,s2,.L21
.L11:
	lw	s9,0(s1)
	mv	a0,s9
	call	get_bucket
	slli	a5,a0,2
	add	a5,s4,a5
	lw	a5,172(a5)
	addi	a5,a5,1
	add	s3,s3,s9
	ble	s9,s6,.L10
	addi	s5,s5,1
	mv	s7,s8
	j	.L10
.L21:
	beq	s7,zero,.L12
	lui	a5,%hi(pass_count)
	sw	s5,%lo(pass_count)(a5)
.L12:
	li	a4,799064064
	addi	a4,a4,-381
	mulh	a4,s3,a4
	srai	a4,a4,3
	srai	s3,s3,31
	sub	a4,a4,s3
	lui	a5,%hi(below_count)
	lw	a3,%lo(below_count)(a5)
	li	a2,0
	li	a1,1
	j	.L14
.L13:
	addi	s0,s0,4
	beq	s0,s2,.L22
.L14:
	lw	a5,0(s0)
	ble	a4,a5,.L13
	ori	a5,a5,256
	sw	a5,0(s0)
	addi	a3,a3,1
	mv	a2,a1
	j	.L13
.L22:
	beq	a2,zero,.L15
	lui	a5,%hi(below_count)
	sw	a3,%lo(below_count)(a5)
.L15:
.L19:
	j	.L19
	.size	main, .-main
	.globl	pass_count
	.globl	below_count
	.globl	mean
	.globl	bucket
	.globl	grades
	.globl	SID
	.bss
	.align	2
	.set	.LANCHOR0,. + 0
	.type	grades, @object
	.size	grades, 172
grades:
	.zero	172
	.type	bucket, @object
	.size	bucket, 20
bucket:
	.zero	20
	.section	.sbss,"aw",@nobits
	.align	2
	.type	pass_count, @object
	.size	pass_count, 4
pass_count:
	.zero	4
	.type	below_count, @object
	.size	below_count, 4
below_count:
	.zero	4
	.type	mean, @object
	.size	mean, 4
mean:
	.zero	4
	.section	.srodata,"a"
	.align	2
	.type	SID, @object
	.size	SID, 4
SID:
	.word	1230019
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
