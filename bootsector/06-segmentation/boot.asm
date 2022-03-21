;memory segmentation in 16bit real mode
;cs: code segment, ds: data segment, ss: stack segment, es: extra segment (user defined)
mov ah, 0x0e; tty mode

mov dx, 0x7c0 ;setting up data segment pointer, will be shifted << 4, so 0x7c0 will evaluate to 0x7c00 bootsector start address
mov ds, dx ;saving data segment pointer in ds
mov al, [test] ;will be automatically overlapped with ds (data segment)
int 0x10 ;bios interrupt, print al

mov es, dx
mov al, [es:test1] ;segmenting with es
int 0x10

jmp $ ;infinito

test:
  db 'X'

test1:
  db 'A'

times 510-($-$$) db 0
dw 0xaa55