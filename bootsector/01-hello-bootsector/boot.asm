;compiling this will generate an 512 byte boot sector, which will be interpreted by the bios as a bootable disk
;it just defines an inifite loop, adds padding zeroes, and the magic 0x55AA at the end, indicating the disk is bootable
loop:
  jmp loop

; $ is the current address, $$ is start of section, so $-$$ is the length of the code written above
; 
times 510-($-$$) db 0
dw 0xaa55


