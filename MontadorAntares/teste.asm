; Cássio Santos, Potencial
;
;function pow(int x, int y){
;  int result = 1;
;  for(int i = 0; i!=y ; i++){
;  result = result*x;
;  }
;  return result;
;}
; pow:
;      rotr $s0, $S1, 32
;      sll $s0, $s1, 4
;      beq $s1, $s2, pow
;      bne $s1, $s2, pow
;      beqz $s0, pow
;      bnez $s0, pow
;      j pow
;      jal pow
;      jalr $v0, $t1
;      jr $s0
GOO:
addi $t0, $zero, 3
j GO
GO:
   addi $t0, $t0, 3
   beq $t0, $t0, GOGO
   addi $t0, $t0, 3
GOGO:
   addi $t0, $t0, 3
   j GOO
