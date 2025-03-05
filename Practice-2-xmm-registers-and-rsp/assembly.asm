
; ----------=----------=----------=----- CODE STARTS HERE -----=----------=----------=----------

; ======================================== Declarations ==========================================

global math

extern printf


; ====================================== Initialized Data ========================================

section .data

    welcome         db "Welocme to maths, can you use gdb to find:", 10, "1. The values of xmm15?", 10, "2. The xmm15 value in v2_double?", 10, "3. There is an IEE-64 value pushed to the top of the stack, locate it and get the value.", 10, 0
    threeSixty      dq 360.0
    two             dq 2.0


; ====================================== Uninitalized Data ========================================
section .bss
    align 64               ;64-byte alignment is necessary for xsav and xrstor to operate
    mainstorage resb 832


; ============================================ Text ==============================================
section .text
math:

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

    xorpd   xmm15, xmm15
    addsd   xmm15, [threeSixty]
    divsd   xmm15, [two]

    mov     rax, 0x0801D00000000000
    push    qword 0
    mov     [rsp], rax

break_spot:

    mov     rax, 0
    pop     rax

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