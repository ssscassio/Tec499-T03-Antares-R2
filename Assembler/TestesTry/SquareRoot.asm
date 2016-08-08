#Wanderson Silva, Raiz
#int square_root(int rad){
#  int index=0;
#  int result = 0;
#  while(rad != 0){
#    int n = index*2+1;
#    rad = rad-n;
#    result++;
#    index++;
#  }
#  return result;
#}
square:
    ADDI $s0, $zero, 4  # s0 = a0 # variable rad
    LI $s1, 0           # s1 = 0 # variable index
    LI $s2, 0           # s2 = 0 # variable result
    LI $s3, 0           # s3 = 0 # variable n
L1: BNE $s0, $zero, L2
    LI $t0, 2		# t0 = 2
    MUL $s3, $s1, $t0	# s3 = s1 * t0 --> n = index*2
    ADDI $s3,$s3, 1	# s3 = s3 + 1  --> n = n + 1
    SUB  $s0, $s0, $s3	# s0 = s0 - s3 --> rad = rad - n
    ADDI $s2, ,$s2, 1	# result++
    ADDI $s1, $s1, 1	# index++
    J L1
L2: MOVE $v0, $s2       # v0 = s2
    JR $ra              # return
