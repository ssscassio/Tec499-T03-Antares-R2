# Cássio Santos, Khaick Brito, Wanderson Silva
# Potencial
#
#function pow(int x, int y){
#  int result = 1;
#  for(int i = 0; i!=y ; i++){
#  result = result*x;
#  }
#  return result;
#}
main:
      LI $a0, 2
      LI $a1, 3
      jal pow
      j exit

pow:
      ADD $s0, $zero, $a0
      ADD $s1, $zero, $a1
      LI $s2, 1
      LI $s3, 0
L1:
      BEQ $s3, $s1, L2
      MUL $s2, $s2, $s0
      ADDI $s3, $s3 , 1
      J L1
L2:
      MOVE $v0, $s2
      JR $ra
exit:
