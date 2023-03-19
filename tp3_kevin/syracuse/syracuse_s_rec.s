.text
.globl syracuse_s_rec
.globl afficher
syracuse_s_rec:
pushl %ebp
movl %esp, %ebp
pushl %ebx
movl 8(%ebp), %eax # Premier parametre
movl 12(%ebp), %ecx # Deuxieme parametre
pushl %eax
pushl %ecx
call afficher
popl %ecx
popl %eax
loop: 
    cmpl $1, %eax
    je retour
    incl %ecx
    movl $2, %ebx
    pushl %eax
    movl $0, %edx
    idivl %ebx
    cmpl $0, %edx
    je even 
odd:
    movl $3, %ebx
    popl %eax
    imull %ebx
    incl %eax
    pushl %ecx
    pushl %eax
    call syracuse_s_rec
    popl %eax
    popl %ecx 
    jmp retour
even:
    popl %eax
    movl $0, %edx
    div %ebx
    pushl %ecx
    pushl %eax
    call syracuse_s_rec
    popl %eax
    popl %ecx 
retour:   
popl %ebx
leave
ret
