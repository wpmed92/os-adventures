;dx: dh = number of sectors to read, dl = num of drive
;we will read our word from disk to address in bx
disk_load:
  pusha

  push dx ;we will overwrite input parameter in dx, so let's save it on stack

  ;set up inputs for 0x13 disk IO interrupt
  mov ah, 0x02 ;0x2 is read mode
  mov al, dh ;set number of sectors to read
  mov cl, 0x02 ;select sector 2
  mov ch, 0x00 ;select cylinder 0
  mov dh, 0x0  ;select head 0 -> we just modified our input register dx, this is why we saved it to stack earlier

  ;[es: bx] will be the pointer to our buffer to where the interrupt will put the read data from disk
  ;caller sets bx
  int 0x13 ;initiate disk read
  jc disk_error ;if error occurs, carry bit is set, jump to error handling

  pop dx ;get back dx, so we will have our input params back dh = number of sectors read, dl = num of drive
  cmp al, dh ;check how many sectors we read
  jne sectors_error ;sector reading error handling

  popa
  ret

disk_error:
  mov bx, DISK_ERROR
  call print
  call print_nl
  mov dh, ah ;get error code
  call print_hex
  jmp disk_loop

sectors_error:
  mov bx, SECTOR_ERROR
  call print

disk_loop:
  jmp $

DISK_ERROR: db 'Error reading from disk', 0
SECTOR_ERROR: db 'Error reading sectors', 0





