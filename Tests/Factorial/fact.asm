;Khaick Oliveira Brito
.text
.globl main
main:

        li $a0,4 ; You can change this value to put your factorial argument
      	       ; For example: li $a0,9 if you want Fact(9)

        jal FACT     ; Jump to factorial code

        j END	; Jump to end
FACT:
        sub $sp,$sp,8   ; Ajust the Stack Pointer
        sw $ra, 4($sp)   ; Store the linked address
        sw $a0, 0($sp)   ; Store the argument of Fact(N)

	;Comparison
        slti $t0,$a0,1   ; if n < 1: $t0 = 1
        beq $t0,$zero,REC   ; if n >= 1, branch to REC -> (recursive)
        li $v1,1      ; if n > 1

        add $sp,$sp,8   ; Release the Stack

        jr $ra      ; Return

REC:     subi $a0,$a0,1   ; New argument for Fact. N-1.
	jal FACT      ; Recursive call

	lw $a0, 0($sp)   ; Get stored argument
	lw $ra, 4($sp)   ; Get stored linked address
	add $sp,$sp,8   ; Frees up space in stack

	mul $v1,$a0,$v1   ; Multiplies actual argument * fact(N-1)
 	jr $ra            ; Jumps to linked address
END:
	add $a0,$v1,$zero
	addi $v0,$v0,1 ; Selecting "print integer" code
	syscall  ; Show the result of Fact(N)
	li $v0, 10 ; Selecting "exit" code
	syscall  ; End of Program
