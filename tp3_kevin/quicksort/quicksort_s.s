
.data
CUTOFF: 
.int 2
.text
.globl quicksort_s
quicksort_s:
pushl %ebp
movl %esp, %ebp
pushl %ebx
movl 8(%ebp), %esi      # pointeur T
movl 12(%ebp), %ebx     # left
movl 16(%ebp), %ecx     # right
movl %ebx, %edx
movl %ecx, %edi
addl CUTOFF, %ebx
movl %edx, %ebx         
subl $4, %esp
movl %ecx, (%esp)
subl $4, %esp
movl %ebx, (%esp)
subl $4, %esp
movl %esi, (%esp)
call medianOfThree 
movl (%esp), %esi
addl $4, %esp
movl (%esp), %ebx
addl $4, %esp
movl (%esp), %ecx
addl $4, %esp
movl %edi, %ecx         
decl %ecx           
loop:
    incl %ebx
    subl $2, %ecx                 
    cmpl %ecx, %ebx
    jae switch
    subl $4, %esp
    movl %eax, (%esp)
    subl $4, %esp
    movl %ecx, (%esp)
    subl $4, %esp
    movl %ebx, (%esp)
    subl $4, %esp
    movl %esi, (%esp)
    call swapRefs
    movl (%esp), %esi
    addl $4, %esp
    movl (%esp), %ebx
    addl $4, %esp
    movl (%esp), %ecx
    addl $4, %esp
    movl (%esp), %eax
    addl $4, %esp
    jmp  loop
switch:
    movl %edi, %ecx     
    sub $1, %ecx
    subl $4, %esp
    movl %ecx, (%esp)
    subl $4, %esp
    movl %ebx, (%esp)
    subl $4, %esp
    movl %eax, (%esp)
    subl $4, %esp
    movl %esi, (%esp) 
    call swapRefs 
    movl (%esp), %esi
    addl $4, %esp
    movl (%esp), %eax
    addl $4, %esp
    movl (%esp), %ebx
    addl $4, %esp
    movl (%esp), %ecx
    addl $4, %esp
    decl %eax
    subl $4, %esp
    movl %eax, (%esp)
    subl $4, %esp
    movl %ebx, (%esp)
    subl $4, %esp
    movl %ecx, (%esp)
    subl $4, %esp
    movl %esi, (%esp)
    call quicksort 
    movl (%esp), %esi
    addl $4, %esp
    movl (%esp), %ecx
    addl $4, %esp
    movl (%esp), %ebx
    addl $4, %esp
    movl (%esp), %eax
    addl $4, %esp
    movl %edi, %ecx     
    incl %eax
    subl $4, %esp
    movl %ecx, (%esp)        
    subl $4, %esp
    movl %eax, (%esp)
    subl $4, %esp
    movl %esi, (%esp)
    call quicksort    
    movl (%esp), %esi
    addl $4, %esp
    movl (%esp), %eax
    addl $4, %esp
    movl (%esp), %ecx
    addl $4, %esp
fin:
popl %ebx
leave
ret
