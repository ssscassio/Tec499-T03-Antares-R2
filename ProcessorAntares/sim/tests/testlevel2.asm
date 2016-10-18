;Teste Level - 2
;
;Descrição : Teste para saidas continuas de somas de dois numeros
;
; Outs = A + B
;-------------------------------------------------------
;Declaração de variáveis--------------------------------
ADDI $t0,$zero,8 ;int A = 8;
ADDI $t1,$zero,4 ;int B = 4;
ADDI $t2,$zero,2 ;int C = 2;
ADDI $t3,$zero,3 ;int D = 3;
;Efetuando Somas----------------------------------------
ADD $t4,$t0,$t1 ;int Sum = A+B;
ADD $t5,$t1,$t2 ;int Sum = B+C;
ADD $t6,$t2,$t3 ;int Sum = C+D;
;Print--------------------------------------------------
  ADDI $t7,$zero,65528 ;Endereço do dispositivo

  SW $t4, $t7 ;Armazena na reserva de dados do dispositivo
POOLING1:
  ADDI $t8,$zero,65532
  LW $t9, $t8 ;Carrega status do dispositivo
  BNE $t9,$zero,POOLING1

  SW $t5, $t7 ;Armazena na reserva de dados do dispositivo
POOLING2:
  ADDI $t8,$zero,65532
  LW $t9, $t8 ;Carrega status do dispositivo
  BNE $t9,$zero,POOLING2

  SW $t6, $t7 ;Armazena na reserva de dados do dispositivo
POOLING3:
  ADDI $t8,$zero,65532
  LW $t9, $t8 ;Carrega status do dispositivo
  BNE $t9,$zero,POOLING3
