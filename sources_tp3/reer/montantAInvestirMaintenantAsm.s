.data
.text
.globl _ZN4Reer29montantAInvestirMaintenantAsmEv

_ZN4Reer29montantAInvestirMaintenantAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

init:
    movl 4(%ebp), %ebx      # %ebx now accesses the "this" pointer to the class
    xor %eax, %eax
    xor %edx, %edx
    pushl %esi
    pushl 8(%ebp)
callMontantAccumule:
    call _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv
    popl %esi # this

    # %eax now holds the value that the function returns, in floating point format
    # now i need to access _tauxInteret in the class, @ %ebx+16

    addl $16, %ebx

divideBy100AndAdd1:
    movl $0x42c80000, %ecx  # %ecx = 100.0
    flds (%ebx)             # st[0] = _tauxInteret, st[1] = free
    flds (%ecx)             # st[0] = 100.0, st[1] = _tauxInteret
    fdivrp                  # st[0] = _tauxInteret/100.0 st[1] = free
    fld1                    # st[0] = 1.0, st[1] = _tauxInteret/100.0
    faddp                   # st[0] = 1 + (_tauxInteret/100.0), st[1] = free

exponentiateAndMult:

    ## its kinda stupid to try and do a negative exponential, especialy in IA32 assembly; its easier to simply divide
    # to recap, st[0] holds 1 + (_tauxInteret/100.0), the base, and we want to exponentiate it by _anneeAvantRetraite
    # all we need to do is push it on the FPU stack and perform the regular arithmetic to get the value we want
    # we then need to remember that we have to DIVIDE (%eax) by the value on the stack, and we should be bing chilling

    # ebx is currently @ _tauxInteret, we need to add +4 to it to access _anneeAvantRetraite

    addl $4, %ebx
    flds (%ebx)            # st[0] = _anneeAvantRetraite, st[1] = 1 + (_tauxInteret/100.0)

    fyl2x                   # st[0] = exp * (log2 (base)) , st[1] = free
    fld1                    # st[0] = 1.0, st[1] = exp * (log2 (base))
    f2xm1                   # st[0] = 2^(exp * (log2 (base))) - 1, st[1] = free
    fld1                    # st[0] = 1.0, st[1] = 2^(exp * (log2 (base))) - 1
    faddp                   # st[0] = 2^(exp * (log2 (base))) = base ^ exp, st[1] = free

    flds (%eax)             # st[0] = MontantAccumule, st[1] = (1 + _tauxInteret/100) ** _anneeAvantRetraite
    fdivp                   # st[0] = what i want to return, st[1] = free

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
