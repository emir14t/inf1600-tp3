.text
.globl syracuse_s_iter
.globl afficher
syracuse_s_iter:
pushl %ebp
movl %esp, %ebp
pushl %ebx
movl 8(%ebp), %eax
xor %ecx, %ecx
loop:
    subl $4, %esp
    movl %eax, (%esp)
    subl $4, %esp
    movl %ecx, (%esp)
    call afficher
    movl (%esp), %ecx
    addl $4, %esp
    movl (%esp), %eax
    addl $4, %esp
    cmpl $1, %eax
    je retour
    incl %ecx
    movl $2, %ebx
    subl $4, %esp
    movl %eax, (%esp)
    xor %edx, %edx
    idivl %ebx
    cmpl $0, %edx
    je even 
odd:
    movl $3, %ebx
    movl (%esp), %eax
    addl $4, %esp
    imull %ebx
    incl %eax
    jmp loop
even:
    movl (%esp), %eax
    addl $4, %esp
    xor %edx, %edx
    idivl %ebx
    jmp loop
retour:   
popl %ebx
leave
ret
