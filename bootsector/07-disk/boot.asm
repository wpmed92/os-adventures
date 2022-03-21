;the bootsector is at head 0, cylinder 0, sector 1
;let's put some extra data outside sector 1, and try to load it, mimicking a kernel load

[org 0x7c00] ;address of the loaded bootsector in memory, use this as base address

;stack setup
mov bp, 0x8000
mov sp, bp

mov bx,  0x9000 ;setup our buffer pointer, this is where data will be read by 0x13 interrupt
mov dh, 2 ;set number of sectors to be read
call disk_load

mov dx, [0x9000] ;load first word of sector 2
call print_hex ;print the word in hex
call print_nl

mov dx, [0x9000 + 512] ;load first word of sector 3
call print_hex ;print the word in hex
call print_nl

mov dh, 2 ;read 2 sectors

jmp $ ;infinite loop

%include '../05-function/print.asm'
%include '../05-function/print_hex.asm'
%include 'disk.asm'

;pad bootsector
times 510 - ($-$$) db 0
dw 0xaa55

;add extra data to sector 2, 3
times 256 dw 0xabcd
times 256 dw 0x1224

