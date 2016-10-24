#Teste Level - 1
#
#Descrição : Teste para a saida da soma de dois números
#
# Out = A + B
#-------------------------------------------------------
ADDI $t0 $zero 8 #int A = 8#
ADDI $t1 $zero 4 #int B = 4#

ADD $t2 $t0 $t1 #int Sum = A+B#
#Print--------------------------------------------------
LUI $t3 65528
LUI $t8 65532

SW $t2 0($t3) #Inserir no topo da pilha reservado ao dispositivo

POOLING1:
  LW $t7 0($t8) #Carrega status do dispositivo
  BNE $t7 $zero POOLING1
#-------------------------------------------------------
