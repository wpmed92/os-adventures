print:
  pusha ;push all registers to stack, so when we are finished with the function, we recover the registers

start:
  mov al, [bx] ;we moved the function parameter (the starting address of our string) to bx in boot.asm
  cmp al, 0 ;check if current byte is null terminator
  je done ;if it is, we are done printing the string, jump to done, and exit subroutine
  mov ah, 0x0e ;tty mode for 0x10 interrupt
  int 0x10 ;al already contains the byte to be printed out, so raise BIOS interrupt 0x10
  add bx, 1 ;increase the address by one to point to next byte in string, like in C you would do string++, where string is a char*
  jmp start ;loop back to start, we're not done yet

done:
  popa ;pop all registers, restore them to the state before function execution
  ret ;return from subroutine

