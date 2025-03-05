
; ----------=----------=----------=----- CODE STARTS HERE -----=----------=----------=----------

; ======================================== Declarations ==========================================

global students

extern printf


; ====================================== Initialized Data ========================================

section .data

    welcome         db "Welocme to students, can you use gdb to find:", 10, "1. Where the studentGPAs are located?", 10, "2. What are the first 4 student's GPA?", 10, "3. What is the address of the first index of busSeats?", 10, 0
    studentGPAs     dq  3.0, 4.0, 3.6, 2.9, 3.4, 3.8, 3.0, 2.6, 2.8, 3.0
    classTimeSecs   dq 3600, 4200, 2000, 2550, 3500, 2000, 6000


; ====================================== Uninitalized Data ========================================
section .bss
    align 64               ;64-byte alignment is necessary for xsav and xrstor to operate
    mainstorage resb 832


    busSeats resq 20


; ============================================ Text ==============================================
section .text
students:

; ------------------------- Backup Registers -------------------------
    mov rax,7
    mov rdx,0

    ; Note that program needs to align the data first in order for xsave to work
    xsave [mainstorage]


    push    rbp
    mov     rbp, rsp

    push    rbx
    push    rcx
    push    rdx
    push    rsi
    push    rdi
    push    r8 
    push    r9 
    push    r10
    push    r11
    push    r12
    push    r13
    push    r14
    push    r15
    pushf
; ------------------------- Finished backup -------------------------

; Welcome user
    mov     rax, 0
    mov     rdi, welcome
    call    printf

    mov     r15, [studentGPAs]
    mov     r14, busSeats  

break_spot:



; ------------------------- Restore Registers -------------------------

    popf          
    pop     r15
    pop     r14
    pop     r13
    pop     r12
    pop     r11
    pop     r10
    pop     r9 
    pop     r8 
    pop     rdi
    pop     rsi
    pop     rdx
    pop     rcx
    pop     rbx

    pop     rbp

    mov rax,7
    mov rdx,0
    xrstor [mainstorage]
; ------------------------- Finished Restoring -------------------------

    ret