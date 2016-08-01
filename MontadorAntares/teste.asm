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
      ADD $s0, $zero, $a0 ; s0 = a0 ; variable X
      ADDU $s1, $zero, $a1 ; s1 = a1 ; variable Y
      SUB $s1, $zero, $a1 ; s1 = a1 ; variable Y
      SUBU $s1, $zero, $a1 ; s1 = a1 ; variable Y
      And $s1, $zero, $a1 ; s1 = a1 ; variable Y
      Nor $s1, $zero, $a1 ; s1 = a1 ; variable Y
      Or $s1, $zero, $a1 ; s1 = a1 ; variable Y
      xor $s1, $zero, $a1 ; s1 = a1 ; variable Y
      mul $s1, $zero, $a1 ; s1 = a1 ; variable Y
      sllv $s1, $zero, $a1 ; s1 = a1 ; variable Y
      srav $s1, $zero, $a1 ; s1 = a1 ; variable Y
      srlv $s1, $zero, $a1 ; s1 = a1 ; variable Y
      LI $s2, 1           ; s2 = 1 ; variable result
      LI $s3, 0           ; s3 = 0 ; variable i
      ADDIU $s0, $s1, -1
      mfhi $s0
      mflo $s0
      mthi $s0
      mtlo $s0
      seb $s0 $s2
      SEH $s0, $s1
      clz $s0 $s2
      clo $s0 $s1
L1:   
      BNE $s3, $s1, L2    ; if(s3 != s1) go to L2
      MUL $s2, $s2, $s0    ; result = result*x
      ADDI $s3, $s3, 1   ; i = i + 1
      J L1                ; Next iteration of loop
L2:   
      MOVE $v0, $s2       ; v0 = s2
      JR $ra              ; return
