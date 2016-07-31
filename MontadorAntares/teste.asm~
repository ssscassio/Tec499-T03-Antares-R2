; Cássio Santos, Potencial
;
;function pow(int x, int y){
;  int result = 1;
;  for(int i = 0; i!=y ; i++){
;  result = result*x;
;  }
;  return result;
;}

pow:
      ADDI $s0, $zero, $ASss ; s0 = a0 ; variable X
      ADD $s1, $zero, $a1 ; s1 = a1 ; variable Y
      LI $s2, 1           ; s2 = 1 ; variable result
      LI $s3, 0           ; s3 = 0 ; variable i
L1:   
      BNE $s3, $s1, L2    ; if(s3 != s1) go to L2
      MUL $s2, $s2, s0    ; result = result*x
      ADDI $s3, $s3, 1   ; i = i + 1
      J L1                ; Next iteration of loop
L2:   
      MOVE $v0, $s2       ; v0 = s2
      JR $ra              ; return
