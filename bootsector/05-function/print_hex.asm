; pass in a hex, like 0x1234
; data in dx
print_hex:
  pusha
  mov cx, 0 ;our counter

;x86 is little-endian, so the memory layout would look like this
;mem addr: value
;0: 0x34
;1: 0x12

hex_loop:
  cmp cx, 4 ;if we processed all 4 characters
  je end
  mov ax, dx ;first char we process is 4, data is in dx
  and ax, 0x000f ;imm16 immediate operand ANDed with ax, we mask out 0x34 to 0x04, to have our first char '4'
  add al, 0x30 ;numeric to ascii is by adding 48 decimal, or 0x30 [hex '0' is ascii 48 (0x30)]
  cmp al, 0x39 ; A-F is 65-70 decimal, or 0x41-0x46 hex
  jle proc
  add al, 7 ;we add 7 to shift to 65-70 range to show A-F

proc:
  mov bx, OUT_STRING
  add bx, 0x0005
  sub bx, cx
  mov [bx], al
  ror dx, 4
  add cx, 1
  jmp hex_loop

end:
  mov bx, OUT_STRING
  call print
  popa
  ret

OUT_STRING:
  db '0x0000', 0


  