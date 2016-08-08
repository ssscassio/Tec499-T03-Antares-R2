#Wanderson Silva,Cássio Santos, Khaick Brito
# Bubble sort
# $t0 array limit
# $a0 base array
.data
     Array: .word 0, 5, 2, 1, 6, 9, 3, 7, 8, 4
.text
    la  $t0, Array            # Copy the base address of the array into $t1
    add $t0, $t0, 40          # 4 bytes per int * 10 ints = 40 bytes
outterLoop:
    add $t1, $zero, $zero     # $t1 holds a flag to determine when the list is sorted
    la  $a0, Array            # Set $a0 to the base address of the Array
innerLoop:
    lw  $t2, 0($a0)           # current element in array
    lw  $t3, 4($a0)           # next element in array
    slt $t5, $t2, $t3         # $t5 = 1 if $t0 < $t1
    beq $t5, $zero, continue     # if $t5 = 1, then swap them
    addi $t1, $zero, 1            # if we need to swap, we need to check the list again
    sw  $t2, 4($a0)           # store the greater numbers contents in the higher position in array (swap)
    sw  $t3, 0($a0)           # store the lesser numbers contents in the lower position in array (swap)
continue:
    addi $a0, $a0, 4          # advance the array to start at the next location from last time
    bne  $a0, $t0, innerLoop  # If $a0 != the end of Array, jump back to innerLoop
    bne  $t1, $zero, outterLoop  # $t1 = 1, another pass is needed, jump back to outterLoop