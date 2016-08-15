# C�ssio Santos, Wanderson Silva, Khaick Brito
# Prime Numbers Generator
#
#void genPrime(int qtd){ //Generator range 
#int i = 0;
#int n = 2;
#int j = n;
#while(i!=qtd){
#	while(n%j != 0 || j == n){
#		j--;
#		if(j==1){
#			printf("%d, ",n);
#			i++;		    
#		}
#	}
#	n++;
#	j = n;
#    }
#}
.data
	array: .space 40#Initiating an array
			# Space for 100 integers
.text							
.globl main
# Registers ########
# qtd = $t0   Ex: qtd=10
# i = $t1
# n = $t2
# j = $t3
# rest = %t4
###################
main:
 addi $t0,$zero,10
 addi $t1,$zero,0
 addi $t2,$zero,2
 add $t3,$t2,$zero
 
 LOOP1:
 #While(i != qtd)
 beq $t1,$t0,END
 j LOOP2
 
 CONTINUE: #After loop2
 addi $t2,$t2,1 # n++
 addi $t3,$t2,0 #j = n
 j LOOP1

 LOOP2: #if(n%j != 0)
 div $t2,$t3
 mfhi $t4
 beq $t4,$zero,IF2
 subi $t3,$t3,1
 j IF3 
   
 IF2: #if(j==n) 
 bne $t3,$t2,CONTINUE
 subi $t3,$t3,1
 j IF3
 
 IF3: #j == 1
 bne $t3,1,LOOP2
 sw $t2, array($t5) #Storing the number
 addi $t5, $t5, 4  
 addi $t1,$t1,1 #i++
 j CONTINUE
  
 END:
  nop
 
   
