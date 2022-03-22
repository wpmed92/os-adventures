;Setting up the Global Descriptor Table (GDT) to enable segmentation in 32-bit mode
;Instead of the 16-bit style segmentation, where the segment register is shifted left 4 and then the address is added to that,
;we will load an index to this GDT into the segment register, and the segment selector will load the proper
;base address, and calculate the absolute address based on that
;each segment descriptor is 8 bytes long
;the first one is set to all zero
gdt_start: ;8 null bytes as starting point of GDT
  dd 0
  dd 0

;Setting up code segment
;Very useful link is https://wiki.osdev.org/Global_Descriptor_Table
;In our bootsector both the data segment and code segment will span the same address space
gdt_data:
  dw 0xffff ;first part of limit = how long is our segment
  dw 0 ;*base address, 16-31 bit, let's set it to 0x00000000
  db 0 ;*base address, 32-39 bit
  
  ;Access Byte
  ;7	6	 5	4	 3	2	 1	 0
  ;P	DPL	  S	 E	DC RW	 A

  db  10010010b;access byte -> ring 0, non-system segment, not executable, segment grows up, writeable, accessed bit zero

  ;Flags
  ;3	2	  1	0
  ;G	DB	L	Reserved
  db 11001111b;flags -> byte granularity (segment is in one-byte blocks), 32-bit protected mode segment, 32-bit long segment, 1111 at end are limit bits
  db 0 ;*base address, 56-63 bit

;code segment, copy of gdt_data, difference is in access byte
gdt_code:
  dw 0xffff
  dw 0
  db 0

  ;Access Byte
  ;7	6	 5	4	 3	2	 1	 0
  ;P	DPL	  S	 E	DC RW	 A

  db 10011010b ;access byte -> ring 0, non-system segment, !executable! (code), segment grows up, readable, accessed bit zero
  db 11001111b ;flags
  db 0 ;*base address, 56-63 bit

gdt_end:

gdt_meta_descriptor:
  dw gdt_end - gdt_start - 1 ;16bit size of gdt
  dd gdt_start ;32bit address of gdt entry point

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
