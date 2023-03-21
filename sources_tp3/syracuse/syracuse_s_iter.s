.text
.globl syracuse_s_iter
.globl afficher
syracuse_s_iter:
pushl   %ebp
movl    %esp, %ebp
pushl %ebx
# DEBUT COMPLETION
# should be crispy
init:
movl 4(%ebp), %ecx
xor %eax, %eax
xor %ebx, %ebx

loop:
    affichage:
        subl $4, %esp
        movl %eax, (%esp)
        subl $4, %esp
        movl %ecx, (%esp)
        call afficher
        movl (%esp), %ecx
        addl $4, %esp
        movl (%esp), %eax
        addl $4, %esp
    test:
        cmp $1, %ecx
        je isOne
        incl %ebx
        xor %edx, %edx
        movl %ecx, %eax
        pushl %ecx
        movl $2, %ecx
        divl %ecx
        cmp $0, %edx
        je isEven
        jmp isOdd

isEven:
    popl %ecx
    movl %eax, %ecx
    jmp loop

isOdd:
    popl %ecx
    movl %ecx, %eax
    movl $3, %ecx
    mull %ecx
    addl $1, %eax
    movl %eax, %ecx
    xor %edx, %edx
    jmp loop


isOne:
    movl %ebx, %eax
    jmp retour

# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
