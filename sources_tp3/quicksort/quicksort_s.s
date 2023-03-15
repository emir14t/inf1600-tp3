.text
.globl quicksort_s
quicksort_s:
pushl %ebp
movl %esp, %ebp
pushl %ebx

# DEBUT COMPLETION

init:
    movl 4(%ebp), %ebx      # right
    movl 8(%ebp), %ecx      # left
    movl 12(%ebp), %edx     # table
    xor %eax, %eax

breakRecursion:
    movl %ecx, %eax
    addl $2, %eax
    cmp %eax, %ebx
    jg bye

pivot:
    pushl %edx
    pushl %ecx
    pushl %edx
    call medianOfThree
    movl %eax, %eax
    pushl %eax  # pivot is on the stack

init2:
## Push on the stack left and right; values are to be reaccessed later
    pushl %ecx      # left,     left @ %esp + 4, pivot @ %esp + 8
    pushl %ebx      # right     right @ %esp + 4, left @ %esp + 8, pivot @ %esp + 12
    decl %ebx       # right - 1

forLoop:
whileLoopI:
    # i = left = %ecx
    pushl %edx      # table is now on the stack
    xor %edx, %edx
    movl %ecx, %eax
    addl $1, %eax 
    mull $4
    movl %eax, %ecx # ++i
    popl %edx       # table is off the stack and back into %edx
    xor %eax, %eax
    movl (%edx, %ecx), %eax # %eax = table[++i]

    ## reset %ecx back to an integer and not an address incrementor
    #------------
    ## put on the stack
    pushl %eax
    pushl %edx
    #------------
    xor %edx, %edx
    movl %ecx, %eax
    divl $4
    movl %eax, %ecx
    #------------
    ## remove from the stack
    popl %edx
    popl %eax
    #------------

    cmp %eax, 12(%esp)      # compare table[++i] with pivot
    jl whileLoopI

whileLoopK:
    # k = right - 1 = %ebx
    pushl %edx      # table is now on the stack
    xor %edx, %edx
    movl %ebx, %eax
    subl $1, %eax 
    mull $4
      
    movl %eax, %ebx # --k
    popl %edx       # table is off the stack and back into %edx
    xor %eax, %eax
    movl (%edx, %ebx), %eax  # %eax = table[--k]

    ## reset %ecx back to an integer and not an address incrementor
    #------------
    ## put on the stack
    pushl %eax
    pushl %edx
    #------------
    xor %edx, %edx
    movl %ecx, %eax
    divl $4
    movl %eax, %ecx
    #------------
    ## remove from the stack
    popl %edx
    popl %eax
    #------------

    cmp %eax, 12(%esp)      # compare table[--k] with pivot
    jg whileLoopK

conditionInLoop:
    # at this point, both while loops are done executing,
    # so the values %eax, %ebx, %ecx ans %edx are respectively:
    # -   %eax = undefined
    # -   %ebx = pivot - 1 = k
    # -   %ecx = pivot + 1 = i
    # -   %edx = table
    cmp %ecx, %ebx
    jl swapRef
    jmp break
    swapRef:
    pushl %edx
    pushl %ecx
    pushl %ebx

    call swapRefs

    # remove from the stack
    popl %ebx
    popl %ecx
    popl %edx

    jmp forLoop

    break:
    # call swapRefs and jmp to RecursivefunctionCalls tag
    # right @ 4(%esp), left @ 8(%esp)
    # i = %ecx
    jmp functionCalls

functionCalls:
    pushl %edx
    pushl %ecx
    movl 4(%esp), %ebx
    subl $1, %ebx
    pushl %ebx

    call swapRefs

    popl %ebx
    popl %ecx
    movl 8(%esp), %ebx
    pushl %ebx
    subl $1, %ecx
    pushl %ecx

    call quicksort_s

    popl %ecx
    popl %ebx
    addl $2, %ecx
    pushl %ecx
    pushl 8(%esp)

    call quicksort_s

bye:
movl %ebx, %eax
jmp retour

# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
