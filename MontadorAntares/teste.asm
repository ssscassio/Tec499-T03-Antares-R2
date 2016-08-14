LABEL2:
   addi $t0, $zero, 3
   addi $t1, $zero, 3
   beq $t0, $t1, LABEL1
   addi $t0, $zero, 3
   addi $t0, $zero, 3
LABEL1:
   addi $t0, $zero, 0
   bne $t0, $t1, LABEL3
   addi $t1, $zero, 3
   addi $t2, $zero, 3
   addi $t1, $zero, 3
LABEL3:
   beqz $t0, LABEL2
