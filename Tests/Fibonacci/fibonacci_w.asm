Wanderson Silva, recursive fibonacci
#
#   int fib(int n) {
#	if (n == 0) {
#	    return 0;
#	}else if (n == 1) {
#	    return 1;
#   }
#	return fib(n-1) + fib(n-2);
#   }
#
fib :
  ADDIU $sp , $sp , −12
  SW $ra , 0 ( $sp )        # backup ra for recursive calls
  SW $a0 , 4 ( $sp )        # backup a0 for recursive calls
  SW $s0 , 8 ( $sp )        # backup s0 since we use it
  BEQ $a0 , $zero , Return0 # return 0 if a0 = 0
  ADDIU $t0 , $zero , 0     # t0 = zero + 0
  SLTI $t0 , $a0 , 2        # you can also beq with one
  BNE $t0 , $zero , Return1 # retutn 1 if t0 != zero
  ADDIU $a0 , $a0 , −1      # a0 = a0 - 1
  JAL fib
  MOVE $s0 , $v0
  LW $a0 , 4 ( $sp )
  ADDIU $a0 , $a0 , −2
  JAL fib
  ADD $v0 , $v0 , $s0
  LW $s0 , 8 ( $sp )
  LW $ra , 0 ( $sp )
  ADDIU $sp , $sp , 12
  JR $ra
Return1 :
  # block just to make our returns consistent
  LW $s0 , 8 ( $sp )
  LW $ra , 0 ( $sp )
  ADDIU $sp , $sp , 12
  LI $v0 , 0
  JR $ra
Return0 :
  # block just to make our returns consistent
  LW $s0 , 8 ( $sp )
  LW $ra , 0 ( $sp )
  ADDIIU $sp , $sp , 12
  LI $v0 , 1
  JR $ra
