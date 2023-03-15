.text
.globl syracuse_s_iter
.globl afficher
syracuse_s_iter:
pushl   %ebp
movl    %esp, %ebp
pushl %ebx
# DEBUT COMPLETION

init:
movl 4(%ebp), %ecx
xor %eax, %eax
xor %ebx, %ebx

loop:
test:
cmp $1, %ecx
je isOne
incl %ebx
xor %edx, %edx
movl %ecx, %eax
divl $2
cmp $0, %edx
je isEven
jmp isOdd

isEven:
movl %eax, %ecx
jmp loop

isOdd:
movl %ecx, %eax
mull $3
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
