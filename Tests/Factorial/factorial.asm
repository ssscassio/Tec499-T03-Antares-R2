# Cássio Santos, Wanderson Silva, Khaick Brito
# Fibonacci Recursivo
#
#function factorial(int n){
#  if(n<=1)
#     return 1;
#  else
#     return n * fatorial(n-1);
#}

main:
   li $a0,5
   jal FACT
   j END
FACT:
    sub $sp,$sp,8   # Ajust the Stack Pointer
    sw $ra, 4($sp)   # Store the linked address
    sw $a0, 0($sp)   # Store the argument of Fact(N)

   #Comparison
   slti $t0,$a0,1   # if n <= 1: $t0 = 1
   beq $t0,$zero,REC   # if n >= 1, branch to REC -> (recursive)
   li $v0,1      # if n > 1

   add $sp,$sp,8   # Release the Stack

   jr $ra      # Return
REC:
   subi $a0,$a0,1   # New argument for Fact. N-1.
   jal FACT      # Recursive call

   lw $a0, 0($sp)   # Get stored argument
   lw $ra, 4($sp)   # Get stored linked address
   add $sp,$sp,8   # Frees up space in stack

   mul $v0,$a0,$v0   # Multiplies actual argument * fact(N-1)
   jr $ra            # Jumps to linked address
END:
