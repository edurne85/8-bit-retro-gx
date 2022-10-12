  
  .org $e000

reset:
  ; initialize stack pointer at $01ff
  ldx #$ff
  txs
