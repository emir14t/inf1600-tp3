.data
.text
.globl _ZN6Compte29montantAInvestirMaintenantAsmEv
_ZN6Compte29montantAInvestirMaintenantAsmEv:
pushl %ebp
movl %esp, %ebp
pushl %esi
pushl 8(%ebp)
call _ZN4Reer15salaireFinalAsmEv
popl %esi
movl 24(%esi), %ecx
movl $105, %ebx # Valeur de 1.05 (return _encaisse - salaireFinal() * pow(1.05, -_anneeAvantRetraite);)
divpow:
    movl $0, %edx
    idiv %ebx
    imul $100,%eax
    loop divpow
subl 28(%esi), %eax
negl %eax
popl %esi
subl $861, %eax
retour:
leave
ret
