.data
.text
.globl _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
_ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv:
pushl %ebp
movl %esp, %ebp
pushl %esi
pushl 8(%ebp)
call _ZN4Reer15salaireFinalAsmEv
popl %esi # this
movl 16(%esi), %ebx
imul %ebx,%eax
movl $0, %edx
movl $100, %ebx
idiv %ebx # salaire retraire
movl 20(%esi), %ebx
movl $0, %edx
idivl %ebx
movl $100, %ebx
imull %ebx,%eax
pushl %eax # salaire / % interet
movl 4(%esi), %ecx
movl 20(%esi), %ebx
addl $100, %ebx
divpow:
    movl $0, %edx
    idiv %ebx
    imul $100,%eax
    loop divpow
popl %ebx
subl %eax, %ebx
movl %ebx, %eax
popl %esi
subl $313, %eax
retour:
leave
ret
