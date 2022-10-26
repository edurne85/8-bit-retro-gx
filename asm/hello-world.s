  .include "include/core.prefix.s"
  
  jsr lcd_init

  ldx #0
print:
  lda message,x
  beq loop
  jsr lcd_print_char
  inx
  jmp print

loop:
  jmp loop

message: .asciiz "Hello, World!"

  .include "include/via.lcd1604.inc.s"
  .include "include/core.suffix.s"