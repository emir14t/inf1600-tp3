.data
.text
.globl	_ZN4Reer30montantAEpargnerChaqueAnneeAsmEv
_ZN4Reer30montantAEpargnerChaqueAnneeAsmEv:
pushl %ebp
movl %esp, %ebp
pushl %esi
pushl 8(%ebp)
call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
popl %esi # this
movl 20(%esi), %ebx
imul %ebx,%eax
movl $100, %ebx
movl $0, %edx
idiv %ebx
pushl %eax # montant accumuler mutiplier par % interet
movl $10000, %eax
movl 24(%esi), %ecx
movl 20(%esi), %ebx
addl $100, %ebx
mulpow:
    imul %ebx,%eax
    push %ebx
    movl $0, %edx
    movl $100, %ebx
    idiv %ebx
    pop %ebx
    loop mulpow
subl $10000, %eax
movl $10000, %ebx
movl $0, %edx
idiv %ebx
movl %eax, %ebx
popl %eax
movl $0, %edx
idiv %ebx
popl %esi
subl $834, %eax
retour:
leave
ret
