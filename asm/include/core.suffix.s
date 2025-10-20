
  .include "include/math.inc.s"
  .include "include/via.lcd1604.inc.s"

  .org $FFF0 ; Reserved vectors area (10 bytes)
  .byte $00, $00, $00, $00, $00, $00, $00, $00, $00, $00
  .org VECTOR_NMI
  .word $0000 ; TODO define an actual NMI handler label
  .org VECTOR_RESET
  .word reset
  .org VECTOR_IRQ
  .word $0000 ; TODO define an actual IRQ handler label
