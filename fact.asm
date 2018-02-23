.text
# main()
main:

# s0 -> x
# ra -> return-address
# v0 -> return-value

li $s0, 0		# x = 0
li $a0, 5		# load 5 into argument register
jal FACT			# call fact(int)
move $s0, $v0		# x = fact(int)

li $v0, 10		# end program
syscall			# end program

FACT:

# base case
bge $a0, 1, FRECURSE
li $v0, 1
jr $ra

# recursive step
FRECURSE:
addi $sp, $sp, -8	# move stack pointer down 8 bytes
sw $a0, 0($sp)		# store a0 at the stack pointer
sw $ra, 4($sp)		# store ra 4 bytes up from the stack pointer

addi $a0, $a0, -1	# decrement argument to n-1
jal FACT		# v0 = fact(n-1)
addi $a0, $a0, 1	# increment argument to n

mult $v0, $a0		# multiply argument and fact(n-1), store it in LO
mflo $v0		# move contents of LO into return-value argument

lw $ra, 4($sp)		# recover return address from stack
lw $a0, 0($sp)		# recover argument from stack
addi $sp, $sp, 8	# move stack pointer up 8 bytes

jr $ra			# jump back to return-address
