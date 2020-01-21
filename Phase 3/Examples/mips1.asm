#Project Phase 3 - Example Code
	.data
num: .word 15 # index
	.text
main:
lw $a0, num
jal magicFunc
li $v0, 2 # print float
mtc1 $zero, $f6 # clear
cvt.s.w $f6, $f6 # convert
add.s $f12, $f6, $f30 # print number return
syscall
#END PROGRAM----
li $v0, 10
syscall
#---------------

magicFunc:
beq $a0, $zero, mfReturn0
slti $t0, $a0, 2
bne $t0, $zero, mfReturn1
j mfCalc

mfReturn0:
add $t0, $zero, $zero
j mfReturn

mfReturn1:
addi $t0, $zero, 1
j mfReturn

mfReturn:
mtc1 $t0, $f30
cvt.s.w $f30, $f30
jr $ra

mfCalc:
mtc1 $zero, $f6 # clear float
cvt.s.w $f6, $f6 # convert
addi $sp, $sp, -72
sw $ra, 0($sp)
sw $a0, 4($sp)
swc1 $f0, 8($sp)
swc1 $f2, 40($sp)
addi $a0, $a0, -1
jal magicFunc
add.s $f0, $f6, $f30
lw $a0, 4($sp)
addi $a0, $a0, -2
jal magicFunc
add.s $f2, $f6, $f30
addi $t0, $zero, 4
mtc1 $t0, $f4
cvt.s.w $f4, $f4 # convert
div.s $f2, $f2, $f4
sub.s $f0, $f0, $f2
add.s $f30, $f6, $f0
lw $ra, 0($sp)
lw $a0, 4($sp)
lwc1 $f0, 8($sp)
lwc1 $f2, 40($sp)
addi $sp, $sp, 72
jr $ra