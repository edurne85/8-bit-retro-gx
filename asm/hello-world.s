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

  .include "include/core.suffix.s"