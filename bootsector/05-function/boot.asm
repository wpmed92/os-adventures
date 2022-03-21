
[org 0x7c00]

mov bx, msg
call print

mov dx, 0x1224
call print_hex

;jmp $ is short for
;boot:
; jmp boot

jmp $

%include 'print.asm'
%include 'print_hex.asm'

msg:
  db 'This is a message from a bootsector. How cool is that?', 0

times 510 - ($-$$) db 0
dw 0xaa55