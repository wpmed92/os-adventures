
[org 0x7c00]

mov bx, msg
call print

boot:
  jmp boot ;our infinite loop

%include 'print.asm'

msg:
  db 'This is a message from a bootsector. How cool is that?', 0

times 510 - ($-$$) db 0
dw 0xaa55