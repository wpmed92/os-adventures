;stack operations
;bp -> base stack pointer, sp -> top stack pointer
;stack grows downward, towards lower addresses

[org 0x7c00]

mov ah, 0x0e; tty mode
mov bp, 0x8000 ; set stack pointer far away from boot sector
mov sp, bp; top and base stack pointer point to same

push 'o'
push 'l'
push 'l'
push 'e'
push 'H'

;0x8000 
;0x7FFF empty
;0x7FFE 'o'
;0x7FFD empty
;0x7FFC 'l'
;0x7FFB empty
;0x7FFA 'l'
;0x7FF9 empty
;0x7FF8 'e'
;0x7FF7 empty
;0x7FF6 'H'

;we can only pop word (16bit)
pop bx
mov al, bl ;move lower 8bit of bx to al
int 0x10 ;should print 'H'

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

pop bx
mov al, bl
int 0x10

;After the whole stack is popped it should print 'Hello'

times 510 - ($ - $$) db 0; zero padding to 512 byte boot sector expected size

dw 0xaa55; magic word tells BIOS it's a bootable sector
