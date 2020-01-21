# Project Phase 3 - Example Code
	.data
arr: .space 2048 # max array size in BYTES
	.text
main:
li $a0, 256 # array size in BYTES
li $a1, 8 # step size
li $a2, 2 # rep count
li $a3, 1
jal wordAccess
#END PROGRAM----
li $v0, 10
syscall
#---------------

wordAccess:
la $s0, arr # array pointer
addu $s1, $s0, $a0 # array limit
sll $t1, $a1, 2 # inc step

wordLP:
move $s6, $a0
move $s7, $a1
move $s5, $v0
addiu $a0, $0, 100 # seed for random number generator
addiu $a1, $a1, 0
addiu $v0, $0, 42 # syscall 42 is random int range
syscall
sll $a0, $a0, 2 # offset
addu $s4, $s0, $a0 # move pointer
sw $0, 0($s4) # array[(index+offset)/4] = 0
move $a0, $s6
move $a1, $s7
move $v0, $s5

wordCheck:
addu $s0, $s0, $t1 # increment ptr
blt $s0, $s1, wordLP
addi $a2, $a2, -1
bgtz $a2, wordAccess
jr $ra

byteAccess:
la $s0, arr # array pointer
addu $s1, $s0, $a0 # array limit

byteLP:
beq $a3, $0, byteZero
lbu $t0, 0($s0) # inc index
addi $t0, $t0, 1
sb $t0, 0($s0)
j byteCheck

byteZero:
sb $0, 0($s0) # reset index

byteCheck:
addu $s0, $s0, $a1 # inc pointer
blt $s0, $s1, byteLP
addi $a2, $a2, -1
bgtz $a2, byteAccess
jr $ra