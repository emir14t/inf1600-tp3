.data
.text
.globl _ZN4Reer30montantAEpargnerChaqueAnneeAsmEv

_ZN4Reer30montantAEpargnerChaqueAnneeAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION


init:
    movl 4(%ebp), %ebx      # %ebx now accesses the "this" pointer to the class
    xor %eax, %eax
    xor %edx, %edx




# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
