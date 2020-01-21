# Samuel Miles
# Project Phase 3 - Application 2 (The Next Value in the Sequence is a Summation of Pseudo-Random Values based on the Previous Values in the Sequence)
# ECE 36500 - F19
# 12-07-19
	.data
arr:	.space	96		#Max Array Size in Bytes (24 Values) **24 was chosen because going beyond caused Arithmetic Errors
len:	.word	24		#Array Length (in number of values)
nl:	.asciiz	"\n"
	.text
main:	li 	$t0, 0			#Reset Counter to 0
	li	$a0, 1			#Load the Initial Value of 1
	la	$s0, arr		#Load the Array Adress

loop1:	mul	$v0, $t0, 4		#Multiply the Number of Elements in the Array by 4
	add	$s1, $s0, $v0		#Move to the End of the Array by Adding the Number of Elements * 4
	ble	$t0, 1, store		#If this is the First or Second Number in the Sequence, skip the addition
loop2:	lw	$a1, ($s0)		#Load the Array Value
	add	$a0, $a0, $a1		#Otherwise, Sum all previous Array Values into $a0
	addi	$s0, $s0, 4		#Increment through the Array
	beq	$s0, $s1, store		#If we have reached the last position in the Array, store the value
	b	loop2			#Branch back to the beginning of the summation, loop2
	
store:	sw	$a0, ($s1)		#Store the Summarized Value as into the Array
	addi	$t0, $t0, 1		#Increment the Counter
	lw	$t1, len		#Load the Max Length of the Sequence
	la	$s0, arr		#Load the Array Adress
	blt	$t0, $t1, loop1		#If we have not reached the Max Length of the Sequence, continue to Sum
					
out:	lw	$a0, ($s0)		#Load Array Element
	addi	$s0, $s0, 4		#Increment through the Array
	li	$v0, 1			#System call code for Printing an Integer
	syscall
	
newln:	move   	$a2, $a0		#Copy the diplay value into a seperate register
	li	$v0, 4			#System call code for printing string = 4 (to create a newline)
	la	$a0, nl			#Print a newline character
	syscall
	move	$a0, $a2		#Switch the display value back into the a0 register
	bne	$s0, $s1, out		#If we have not printed the whole array, branch back to printing
	
term:	li	$v0, 17			#System call code for Terminating
	syscall 


	
	