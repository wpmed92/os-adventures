;print something without BIOS interrupts
[bits 32]

;0xb8000 + 2 * (row * 80 + col)
;2 bytes, first char, second attribute
WHITE_ON_BLACK equ 0x0f

BEGIN_32:
  pusha
  mov ebx, 0xb8000
  mov al, [TEST_DATA]
  mov ah, WHITE_ON_BLACK
  mov [ebx], ax
  popa
  ret

TEST_DATA: db 'X'
