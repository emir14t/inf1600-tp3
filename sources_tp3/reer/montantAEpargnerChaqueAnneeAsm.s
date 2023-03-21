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
    pushl %esi
    pushl 8(%ebp)

CallMontantAccumule:
    call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
    popl %esi # this
    # %eax now holds the value that the function returns, in floating point format
    # now i need to access _tauxInteret in the class, @ %ebx+16

    addl $16, %ebx          # %ebx now points to _tauxInteret

    flds (%ebx)             # st[0] = _tauxInteret, st[1] = free

    interestPCT:
        movl $0x42c80000, %ecx  # %ecx = 100.0 in floating point
        flds (%ecx)             # st[0] = 100.0, st[1] = _tauxInteret
        fdivrp                  # st[0] = _tauxInteret / 100.0
        
        subl $4, %esp
        pushl (%esp)
        fstps (%esp)            # stack empty
        movl (%esp), %edx       # %edx = _tauxInteret / 100.0
        popl (%esp)
        addl $4, %esp
        pushl %edx              # GP stack[0] = salaireRetraite
    
    
exponentiate:
    addOne:
        flds (%edx)             # st[0] = _tauxInteret / 100.0, st[1] = free
        fld1                    # st[0] = 1.0, st[1] = _tauxInteret / 100.0
        faddp                   # st[0] 1.0 + _tauxInteret / 100.0, st[1] = free
    exp:

        # take whats on the FPU stack and store in a GP register

        
        subl $4, %esp
        pushl (%esp)
        fstps (%esp)            # stack empty
        movl (%esp), %ecx       # %ecx = 1.0 + (_tauxInteret / 100.0)
        popl (%esp)
        addl $4, %esp


        # %ebx is now pointing to _tauxInteret, i want it to point to _anneeAvantRetraite
        # just need to add +4 to %ebx

        addl $4, %ebx
        flds (%ebx)             # st[0] = _anneeAvantRetraite, st[1] = free
        fld1                    # st[0] 1.0, st[1] = _anneeAvantRetraite
        fsubp                   # st[0] = _anneeAvantRetraite - 1.0, st[1] = free
        
        ## need to reshape the stack to have _anneeAvantRetraite - 1.0 as the st[0] parameter and 1.0 + (_tauxInteret / 100.0) as the st[1] parameter
        
        subl $4, %esp
        pushl (%esp)
        fstps (%esp)            # stack empty
        flds (%ecx)             # st[0] = 1.0 + (_tauxInteret / 100.0), st[1] = free
        flds (%esp)             # st[0] = _anneeAvantRetraite - 1.0, st[1] = 1.0 + (_tauxInteret / 100.0)

        fyl2x                   # st[0] = exp * (log2 (base)) , st[1] = free
        fld1                    # st[0] = 1.0, st[1] = exp * (log2 (base))
        f2xm1                   # st[0] = 2^(exp * (log2 (base))) - 1, st[1] = free
        fld1                    # st[0] = 1.0, st[1] = 2^(exp * (log2 (base))) - 1
        faddp                   # st[0] = 2^(exp * (log2 (base))) = base ^ exp, st[1] = free

        addl $4, %esp

    division:
        ## at this point, % ecx = _tauxInteret / 100.0, and st[0] = (1 + (_tauxInteret / 100.0)) ** (_anneeAvantRetraite-1)
        # all we need to do is divide %ecx by st[0]
        flds (%ecx)             # st[0] = _tauxInteret / 100.0, st[1] = (1 + (_tauxInteret / 100.0)) ** (_anneeAvantRetraite-1)
        fdivp                   # st[0] =  (_tauxInteret / 100.0) / ((1 + (_tauxInteret / 100.0)) ** (_anneeAvantRetraite-1)), st[1] =free

multiplication:
    # st[0] = (_tauxInteret / 100.0) / ((1 + (_tauxInteret / 100.0)) ** (_anneeAvantRetraite-1))
    # %eax still holds the return value of montantAccumule
    flds (%eax)                 # st[0] = %eax, st[1] = ...
    fmulp                       # st[0] = the value i want to return, st[1] = free

    pushl (%esp)
    subl $4, %esp           # make some room
    fstps (%esp)            # FPU stack is free, %esp points to the value of the return val
    movl (%esp), %eax       # we don't need %eax anymore, so we can directly store the return value in it
    popl (%esp)             # eax now holds the retrurn value
    addl $4, %esp

bye:
    flds (%eax)
    popl %ebp


# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
