.data
.text
.globl _ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv

_ZN4Reer34montantAmasseFinalAvantRetraiteAsmEv:
pushl %ebp
movl %esp, %ebp
# DEBUT COMPLETION

# const int salaireRetraite = salaireFinal() * double(_salaireVouluRetraite) / 100;
# return salaireRetraite * (pow(1 + double(_tauxInteret) / 100, _anneesDeRetraite) - 1) / (double(_tauxInteret) / 100 * (pow(1 + double(_tauxInteret) / 100, _anneesDeRetraite)));
init:
    movl 4(%ebp), %ebx      # %ebx now accesses the "this" pointer to the class
    xor %eax, %eax
    xor %edx, %edx

callSalaireFinaleAndGetSalaireRetraite:
    call _ZN4Reer12salaireFinalEv   # i think this is right, have to review name mangling
    # %eax now holds the value that the function returns, in floating point format
    
    ## now computing "const int salaireRetraite":
    # need to access the "int _salaireVouluRetraite", the 4th class attribute:
    addl $12, %ebx          # now accessing _salaireVouluRetraite
    movl $0x42c80000, %ecx  # %ecx = 100.0 in floating point
    flds (%ecx)             # st[0] = 100.0
    flds (%ebx)             # st[0] = _salaireVouluRetraite, st[1] = 100.0
    fdivp                   # st[0] = _salaireVouluRetraite / 100.0, st[1] = free
    flds (%eax)             # st[0] = return value of salaireFinal(), st[1] = _salaireVouluRetraite / 100.0
    fmulp                   # st[0] = salaireFinal() * _salaireVouluRetraite / 100.0, st[1] = free

    # a good idea is to push the value on the general purpose stack in order to free up registers

    subl $4, %esp
    pushl (%esp)
    fstps (%esp)            # stack empty
    movl (%esp), %edx       # %edx = salaireFinal() * _salaireVouluRetraite / 100.0 = salaireRetraite
    popl (%esp)
    addl $4, %esp
    pushl %edx              # GP stack[0] = salaireRetraite


#---------------------- function called -----------------------------
#--------------------------------------------------------------------

pow:
    ## now we can simply reimplemente the functions created in the salaireFinalAsm, except we would need to switch up to adapte to the context:
    ## here is the copy paste w/ the modifs:
    ## also, the "this" pointer is now %ebx instead of %eax, %ebx = _salaireVouluRetraite

    #-----------------------BEGIN----------------------

    divisionBy100:
        addl $4, %ebx           # now accessing the "int _tauxInteret" attribute
        movl $0x42c80000, %eax  # floating point value 100.0 in %eax
        movl %eax, (%esp)
        flds (%esp)             # st[0] = 100.0
        flds (%ebx)             # st[0] = _tauxInteret,    st[1] = 100.0
        fdivp                   # st[0] = _tauxInteret/100.0,     st[1] = free
        movl %ebx, %esp
        subl $8, %esp           # clear +4 spaces
        fstps (%esp)            # stack empty
        movl (%esp), %ecx       # %ecx = _tauxInteret/100.0
        addl $4, %esp

    addOne:
        xor %eax, %eax
        movl $0x3f800000, %eax  # floating point value 1.0 in %eax
        pushl %esp
        movl %eax, (%esp)
        flds (%esp)             # st[0] = 1.0, st[1] = free
        flds (%ecx)             # st[0] = _tauxInteret/100.0, st[1] = 1.0
        faddp                   # st[0] = 1.0 + _augmentationSalariale/100.0, st[1] = free
        popl %esp
        subl $4, %esp           # clear +4 space
        fstps (%esp)
        movl (%esp), %ecx
        addl $4, %esp           # %ecx holds 1.0 + (_tauxInteret/100.0) in floating point

    powAndMult:

        # base is in %ecx register
        # need to compute power:
        # need to access protected int _anneeAvantRetraite
        # ebx is already @ _tauxInteret, so still needs to substract 4*4
        
        subl $16, %ebx          # now accessing int _anneeAvantRetraite

        flds (%ecx)             # st[0] = 1.0 + (_tauxInteret/100.0), st[1] = free
        flds (%ebx)             # st[0] = _anneeAvantRetraite, st[1] = 1.0 + (_augmentationSalariale/100.0)

        ## the fyl2x instruction converts the exponent to a base 2 exponent
        ## => exp * (log2 (base) ) 
        ## by then pushing 1.0 on the stack (st[0] = 1, st[1] = exp * (log2(base)) ),
        ## we can perform the f2xm1 instruction, which performs 2 ^ (exp * (log2(base))) - 1
        ## we then need to add 1 and we should be big chilling :)

        fyl2x                   # st[0] = exp * (log2 (base)) , st[1] = free
        fld1                    # st[0] = 1.0, st[1] = exp * (log2 (base))
        f2xm1                   # st[0] = 2^(exp * (log2 (base))) - 1, st[1] = free
        fld1                    # st[0] = 1.0, st[1] = 2^(exp * (log2 (base))) - 1
        faddp                   # st[0] = 2^(exp * (log2 (base))) = base ^ exp, st[1] = free

        
        ## done, need to load the value into a register to later push it on the FPU stack
        pushl (%esp)
        subl $4, %esp           # make some room
        fstps (%esp)            # FPU stack is free, %esp points to the value of the return val
        movl (%esp), %ecx       # we don't need %ecx anymore so we can safely recycle it
        popl (%esp)             # ecx now holds the value of "pow(1 + double(_tauxInteret) / 100, _anneesDeRetraite)"
        addl $4, %esp

upperOperand:
    flds (%ecx)
    fld1
    fsubp                   # ((1+_tauxInteret)**_anneesDeRetraite) -1
    pushl (%esp)
    subl $4, %esp           # make some room
    fstps (%esp)            # FPU stack is free, %esp points to the value of the return val
    movl (%esp), %edx       # we don't need %edx for now so we can safely use it
    popl (%esp)             # edx now holds the value of ((1+_tauxInteret)**_anneesDeRetraite) -1
    addl $4, %esp

divide:
    

ASSemble:

bye:
# FIN COMPLETION
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:
leave
ret
