.text
.globl syracuse_s_rec
.globl afficher
syracuse_s_rec:
pushl %ebp
movl  %esp, %ebp
pushl %ebx
# DEBUT COMPLETION

init:
movl 4(%ebp), %ecx  # the i parameter
movl 8(%ebp), %ebx  # the u(n) parameter
xor %eax, %eax

tests:
cmp $1, %ebx
je isOne
incl %ecx
movl %ebx, %eax
xor %edx, %edx
pushl %ebx
movl $2, %ebx
divl %ebx
popl %ebx
cmp $0, %edx
je isEven
jmp isOdd

isEven:
pushl %eax
pushl %ecx
call syracuse_s_rec

isOdd:
movl %ebx, %eax
pushl %ebx
movl $3, %ebx
mull %ebx
popl %ebx
addl $1, %eax
pushl %eax
pushl %ecx
call syracuse_s_rec

isOne:
movl %ebx, %eax
jmp retour

# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
