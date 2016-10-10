;Teste Level - 2
;
;Descrição : Teste para saidas continuas de somas de dois numeros
;
; Outs = A + B
;-------------------------------------------------------
;Variables Declaration----------------------------------
ADDI $t0,$zero,8 ;int A = 8;
ADDI $t1,$zero,4 ;int B = 4;
ADDI $t2,$zero,2 ;int C = 2;
ADDI $t3,$zero,3 ;int D = 3;
;Making Sums--------------------------------------------
ADD $t4,$t0,$t1 ;int Sum = A+B;
ADD $t5,$t1,$t2 ;int Sum = B+C;
ADD $t6,$t2,$t3 ;int Sum = C+D;
;Print--------------------------------------------------
  SW $t4, -4($sp)
POOLING1:
  LW $t7, -8($sp) ;Carrega status do dispositivo
  BNE $t7,$zero,POOLING1

  SW $t5, -4($sp)
POOLING2:
  LW $t7, -8($sp) ;Carrega status do dispositivo
  BNE $t7,$zero,POOLING2

  SW $t6, -4($sp)
POOLING3:
  LW $t7, -8($sp) ;Carrega status do dispositivo
  BNE $t7,$zero,POOLING3
