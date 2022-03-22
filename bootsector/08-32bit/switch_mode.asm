;TODO in 16-bit mode: lgdt
[bits 16]
switch_mode:
  cli ;disable interrupts
  lgdt [gdt_meta_descriptor]
  mov eax, cr0
  or eax, 0x1 ;set first bit, which means 32-bit mode
  mov cr0, eax
  jmp CODE_SEG:init_32bit_mode ;far jump into our 32-bit initialization code

;setup data segment registers
;DATA_SEG is an index into GDT, it points to the data segment descriptor
[bits 32]
init_32bit_mode:
  mov ax, DATA_SEG
  mov ds, ax
  mov ss, ax
  mov es, ax
  mov fs, ax
  mov gs, ax

  mov ebp, 0x90000 ;set stack base pointer
  mov esp, ebp

  call BEGIN_32
  jmp $