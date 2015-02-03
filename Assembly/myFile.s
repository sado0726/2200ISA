main:	la $a0, number		
        lw $a0, 0($a0)
	addi $v0, $a0, 1
	add $a0, $a0, $a0
	halt

number:	.word 10
