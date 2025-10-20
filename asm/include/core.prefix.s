  .include "include/address-map.v21.s"
  .include "include/operators-map.s"

  .org ROM0

reset:
  ; initialize stack pointer at $01ff
  ldx #$ff
  txs
