;Entering 32bit protected mode
;First, in 16bit mode, print something, then jump to 32bit initialization
;We should setup GDT (Global Descriptor Table), load it with lgdt
;Then we can go on and implement the printing mechanism in 32bit protected mode

[org 0x7c00] ;this is where we (the bootsector) are mapped in memory

mov bx, HELLO_16BIT
call print
call print_nl
mov bx, LETS_JUMP
call print
call print_nl

call switch_mode

jmp $

%include '../05-function/print.asm'
%include '../05-function/print_hex.asm'
%include 'gdt.asm'
%include 'switch_mode.asm'
%include 'print32.asm'

HELLO_16BIT: db 'Hello 16-bit real mode', 0
LETS_JUMP: db 'Now lets jump to 32-bit...', 0
HELLO_PROTECTED_MODE: db 'Hello 32-bit protected mode', 0

times 510 - ($ - $$) db 0
dw 0xaa55
