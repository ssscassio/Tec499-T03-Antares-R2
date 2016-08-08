#Cássio Silva, Raiz
#int square_root(int rad){
#  int n=1;
#  int result = 0;
#  while(rad != 0){
#    rad = rad-n;
#    result++;
#    n+=2;
#  }
#  return result;
#}
main:
    ADD $a0, $zero, 25
    JAL square
    J exit
    
square:
    ADD $s0, $zero, $a0  # s0 = a0 # variable rad
    LI $s1, 1           # s1 = 0 # variable index
    LI $s2, 0           # s2 = 0 # variable result
L1: 
    BEQ $s0, $zero, L2
    SUB  $s0, $s0, $s1	# s0 = s0 - s3 --> rad = rad - n
    ADDI $s2, ,$s2, 1	# result++
    ADDI $s1, $s1, 2
    J L1
L2: MOVE $v0, $s2       # v0 = s2
    JR $ra              # return
exit: