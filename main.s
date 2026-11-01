	.file	"main.c"
	.option nopic
	.attribute arch, "rv32i2p1_m2p0_zmmul1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	SID
	.section	.srodata,"a"
	.align	2
	.type	SID, @object
	.size	SID, 4
SID:
	.word	1230019
	.globl	grades
	.bss
	.align	2
	.type	grades, @object
	.size	grades, 172
grades:
	.zero	172
	.globl	bucket
	.align	2
	.type	bucket, @object
	.size	bucket, 20
bucket:
	.zero	20
	.globl	mean
	.section	.sbss,"aw",@nobits
	.align	2
	.type	mean, @object
	.size	mean, 4
mean:
	.zero	4
	.globl	below_count
	.align	2
	.type	below_count, @object
	.size	below_count, 4
below_count:
	.zero	4
	.globl	pass_count
	.align	2
	.type	pass_count, @object
	.size	pass_count, 4
pass_count:
	.zero	4
	.text
	.align	2
	.globl	next_random
	.type	next_random, @function
next_random:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a4,-20(s0)
	li	a5,1662976
	addi	a5,a5,1549
	mul	a4,a4,a5
	li	a5,1013903360
	addi	a5,a5,863
	add	a5,a4,a5
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	next_random, .-next_random
	.align	2
	.globl	get_bucket
	.type	get_bucket, @function
get_bucket:
	addi	sp,sp,-32
	sw	ra,28(sp)
	sw	s0,24(sp)
	addi	s0,sp,32
	sw	a0,-20(s0)
	lw	a4,-20(s0)
	li	a5,49
	bgt	a4,a5,.L4
	li	a5,0
	j	.L5
.L4:
	lw	a4,-20(s0)
	li	a5,64
	bgt	a4,a5,.L6
	li	a5,1
	j	.L5
.L6:
	lw	a4,-20(s0)
	li	a5,74
	bgt	a4,a5,.L7
	li	a5,2
	j	.L5
.L7:
	lw	a4,-20(s0)
	li	a5,84
	bgt	a4,a5,.L8
	li	a5,3
	j	.L5
.L8:
	li	a5,4
.L5:
	mv	a0,a5
	lw	ra,28(sp)
	lw	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.size	get_bucket, .-get_bucket
	.align	2
	.globl	main
	.type	main, @function
main:
	addi	sp,sp,-48
	sw	ra,44(sp)
	sw	s0,40(sp)
	addi	s0,sp,48
	li	a5,1228800
	addi	a5,a5,1219
	sw	a5,-20(s0)
	sw	zero,-24(s0)
	li	a5,1228800
	addi	a3,a5,1219
	li	a5,1717985280
	addi	a5,a5,1639
	mulh	a5,a3,a5
	srai	a4,a5,2
	srai	a5,a3,31
	sub	a4,a4,a5
	mv	a5,a4
	slli	a5,a5,2
	add	a5,a5,a4
	slli	a5,a5,1
	sub	a4,a3,a5
	addi	a5,a4,50
	sw	a5,-40(s0)
	sw	zero,-28(s0)
	j	.L10
.L11:
	lw	a0,-20(s0)
	call	next_random
	sw	a0,-20(s0)
	lw	a5,-20(s0)
	srli	a5,a5,16
	li	a4,1148157952
	addi	a4,a4,1623
	mulhu	a4,a5,a4
	sub	a3,a5,a4
	srli	a3,a3,1
	add	a4,a4,a3
	srli	a4,a4,6
	li	a3,101
	mul	a4,a4,a3
	sub	a4,a5,a4
	mv	a3,a4
	lui	a5,%hi(grades)
	addi	a4,a5,%lo(grades)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	sw	a3,0(a5)
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L10:
	lw	a4,-28(s0)
	li	a5,42
	ble	a4,a5,.L11
	sw	zero,-32(s0)
	j	.L12
.L14:
	lui	a5,%hi(grades)
	addi	a4,a5,%lo(grades)
	lw	a5,-32(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	sw	a5,-44(s0)
	lw	a0,-44(s0)
	call	get_bucket
	sw	a0,-48(s0)
	lui	a5,%hi(bucket)
	addi	a4,a5,%lo(bucket)
	lw	a5,-48(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	addi	a4,a5,1
	lui	a5,%hi(bucket)
	addi	a3,a5,%lo(bucket)
	lw	a5,-48(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lw	a4,-24(s0)
	lw	a5,-44(s0)
	add	a5,a4,a5
	sw	a5,-24(s0)
	lw	a4,-44(s0)
	lw	a5,-40(s0)
	blt	a4,a5,.L13
	lui	a5,%hi(pass_count)
	lw	a5,%lo(pass_count)(a5)
	addi	a4,a5,1
	lui	a5,%hi(pass_count)
	sw	a4,%lo(pass_count)(a5)
.L13:
	lw	a5,-32(s0)
	addi	a5,a5,1
	sw	a5,-32(s0)
.L12:
	lw	a4,-32(s0)
	li	a5,42
	ble	a4,a5,.L14
	lw	a5,-24(s0)
	li	a4,799064064
	addi	a4,a4,-381
	mulh	a4,a5,a4
	srai	a4,a4,3
	srai	a5,a5,31
	sub	a4,a4,a5
	lui	a5,%hi(mean)
	sw	a4,%lo(mean)(a5)
	sw	zero,-36(s0)
	j	.L15
.L17:
	lui	a5,%hi(grades)
	addi	a4,a5,%lo(grades)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	lui	a5,%hi(mean)
	lw	a5,%lo(mean)(a5)
	bge	a4,a5,.L16
	lui	a5,%hi(grades)
	addi	a4,a5,%lo(grades)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a5,0(a5)
	ori	a4,a5,256
	lui	a5,%hi(grades)
	addi	a3,a5,%lo(grades)
	lw	a5,-36(s0)
	slli	a5,a5,2
	add	a5,a3,a5
	sw	a4,0(a5)
	lui	a5,%hi(below_count)
	lw	a5,%lo(below_count)(a5)
	addi	a4,a5,1
	lui	a5,%hi(below_count)
	sw	a4,%lo(below_count)(a5)
.L16:
	lw	a5,-36(s0)
	addi	a5,a5,1
	sw	a5,-36(s0)
.L15:
	lw	a4,-36(s0)
	li	a5,42
	ble	a4,a5,.L17
.L18:
	j	.L18
	.size	main, .-main
	.ident	"GCC: (xPack GNU RISC-V Embedded GCC x86_64) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
