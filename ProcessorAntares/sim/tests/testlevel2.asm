;Teste Level - 2
;
;Descrição : Teste para saidas continuas de somas de dois numeros
;
; Outs = A + B
;-------------------------------------------------------
;Variables Declaration----------------------------------
ADDI $t0,$zero,8 ;int A = 8;
ADDI $t1,$zero,4 ;int B = 4;
ADDI $t3,$zero,2 ;int C = 2;
ADDI $t4,$zero,3 ;int D = 3;
ADDI $t6,$zero,1 ;int E = 1;
;Making Sums--------------------------------------------
ADD $t2,$t0,$t1 ;int Sum = A+B;
ADD $t5,$t3,$t4 ;int Sum = C+D;
ADD $t7,$t4,$t6 ;int Sum = D+E;
;Print--------------------------------------------------
SW $t2, -4($sp)
SW $t5, -4($sp)
SW $t7, -4($sp)
;-------------------------------------------------------
