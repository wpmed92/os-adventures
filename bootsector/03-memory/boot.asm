;System initally boots in 16-bit real mode for backward compatibility reasons (Intel: emulate the oldest CPU in the family, 8086) 
;Memory layout of an x86 system is shown in 'memory_layout.png'
;the boot sector is loaded at 0x7c00
;at 0x00 is the start of the Interupt Vector Table

;registers in x86
;general purpose:
;EAX (16bit__AH(8bit)_AL(8bit)), EBX (16bit__BH(8bit)_BL(8bit)), ECX (16bit__CH(8bit)_CL(8bit)), EDX (16bit__DH(8bit)_DL(8bit)), ESI, EDI
;special purpose
;ESP (stack pointer), EBP (base pointer)

;start of the boot sector, by defining it with org, we direct the assembler to use it for every memory access, so we don't have to prefix everything with 0x7c00
[org 0x7c00]

mov ah, 0x0e ;tty mode
;try it out: mov al, test_data -> won't work: moves the address of test_data and not the actual data to al
mov al, [test_data] ; [] syntax is like dereferencing a pointer in C
int 0x10

test_data:
  db "X"

times 510 - ($-$$) db 0
dw 0xaa55