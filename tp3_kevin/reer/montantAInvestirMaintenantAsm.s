.data
.text
.globl _ZN4Reer29montantAInvestirMaintenantAsmEv
_ZN4Reer29montantAInvestirMaintenantAsmEv:
pushl %ebp
movl %esp, %ebp
pushl %esi
pushl 8(%ebp)
call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
popl %esi # this
movl 24(%esi), %ecx
movl 20(%esi), %ebx
addl $100, %ebx
divpow:
    movl $0, %edx
    idiv %ebx
    imul $100,%eax
    loop divpow
popl %esi
addl $660, %eax
retour:
leave
ret
