# Samuel Miles
# Project Phase 3 - Application 1 (Generate an array of Random Numbers and sort it as you go using Bubble-Sort)
# ECE 36500 - F19
# 12-05-19
	.data
arr:	.space	2048		#Max Array Size in Bytes (64 Values)
max:	.word	300		#Max Value for Generating Random Numbers
len:	.word	64		#Array Length (in number of values)
count:	.word	0		#Array Element Counter (Increments of 4)
temp:	.word	0		#A Temporary Variable for Holding Values as they are Sorted
nl:	.asciiz	"\n"
	.text
main:	li 	$t0, 0			#Reset Counter to 0
	jal 	numGen			#Branch to RNG (Random Number Generator)
	
numGen:	lw 	$a1, max		#Load the Maximum RNG Bound
    	li 	$v0, 42			#Generate Random Number between 0 and max, stored in $a0
    	syscall

genArr:	la 	$s0, arr		#Load the Address of the Array Space
	mul	$a2, $t0, 4		#Multiply the Number of Elements in the Array by 4
	add	$s1, $s0, $a2		#Move to the End of the Array by Adding the Number of Elements * 4
	beqz	$t0, skip1		#If this is the First Element in the Array, skip the Sorting
	b	sort			#Branch to sort, so that the New Element can be Sorted into the Array
skip1:	sw	$a0, ($s1)		#Store the Highest Value (so far) at the end of the Array
	addi	$t0, $t0, 1		#Increment the Counter
	lw	$v1, len		#Load the Maximum Length of the Array (in Elements)
	blt	$t0, $v1, numGen	#Branch to the RNG if Number of Elements in the Array is Less than Max Length
	la	$s0, arr		#Load the Address of the Array
	b	out			#Branch to the Printing Loop
	
sort:	lw	$a3, ($s0)		#Load the Next Element in the Array
	bge 	$a0, $a3, skip2		#Branch if the New Value is Greater than or Equal to the Current Array Value	
	jal	swap			#Otherwise, Swap the Elements
skip2:	addi	$s0, $s0, 4		#Increment through the Array
	bne	$s0, $s1, sort		#If we have not looked through the whole array, branch back to continue sorting
	b	skip1			#Otherwise, return from sorting (Should Return the Highest Value in the Array so far)
	
swap:	sw	$a0, temp		#Store the Newly Generated Value into temp to be swapped
	move	$a0, $a3		#Swap the Value Being Presently Looked at in the Array to be the New Value
	lw	$a3, temp		#Load the Value stored in temp into $a3
	sw	$a3, ($s0)		#Replace the Original Value in the Array with the New Value from temp
	jr	$ra			#Return from Swapping
	
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
