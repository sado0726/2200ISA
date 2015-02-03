!============================================================
! CS-2200 Homework 1
!
! Please do not change main's functionality, 
! except to change the argument for factorial or to meet your 
! calling convention
!
![70 points] Write a function in LC-2200 to compute factorial(num). Your function is required to
!follow the calling convention you established above. It should work for n >= 0, but you don’t have
!to handle detecting/handling integer overflow. YOUR FUNCTION MUST BE RECUR-
!SIVE, PURELY ITERATIVE SOLUTIONS WILL NOT RECIEVE ANY CREDIT!
!YOU MUST USE THE STACK AND STACK POINTER TO IMPLEMENT RECUR-
!SION FOR FULL CREDIT! (Recursive functions always obtain a return address through the
!function call and return to the callee using the return address.) We recommend making a helper
!multiply function. Multiply can be done iteratively. Feel free to ask us questions in our office
!hours, on Piazza, or in the weekly recitation. Make sure that fact.s is in a UNIX-readble format
!(no DOS/Windows nonsense).
!============================================================

main:       la $sp, stack		! load address of stack label into $sp
            lw $sp, 0($sp)              ! FIXME: load desired value of the stack 
            la $at, factorial	        ! load address of factorial label into $at
            addi $a0, $zero, 0 	        ! $a0 = 0, the number to factorialize
            jalr $at, $ra		! jump to factorial, set $ra to return addr
            halt			! when we return, just halt

factorial:  beq $a0, $zero, zero	! if(argument == 0)

notzero:    addi $sp, $sp, 1		! push	
	    sw $ra, 0($sp)		!
	    addi $a0, $a0, -1		! change argument to n - 1 before entering the recursion
	    jalr $at, $ra		! factorial recursion, $at still holds the value to jump to factorial
	    addi $a0, $a0, 1		! restore the original value for $a0 when coming out of the recursion
	    lw $ra, 0($sp)		! restore return address
	    addi $sp, $sp, -1		! pop

!idea of multiplication: if 2 times 3, 2 + 2 + 2 = 6 = 2 * 3 or if times 4 * 5, 4 + 4 + 4 + 4 + 4 = 20 = 4 * 5
	    add $t0, $zero, $a0		! using $t0 as the larger number
	    add $t1, $zero, $v0		! using $t1 as the smaller number
loop:	    addi $t0, $t0, -1		! decrement t0 to see if the number is added enough times
	    beq $t0, $zero, end		! check if $t0 is 0 
	    add $v0, $v0, $t1		! $v0 value change directly
	    beq $zero, $zero, loop	! unconditional

end:	    jalr $ra, $zero		! end of the method, return back to the previous address

zero:	    addi $v0, $zero, 1		! storing one stored in t0 since t0 is one after beq 
	    jalr $ra, $zero		! end of the method, return back to the previous address

stack:	    .word 0x4000		! the stack begins here (for example, that is)
