MATH_OP_A = $0200 ; Up to 4 bytes
MATH_OP_B = $0204 ; Up to 4 bytes
MATH_OP_C = $0208 ; Up to 4 bytes
MATH_OP_D = $020C ; Up to 4 bytes
MATH_RES = $0210 ; Up to 8? bytes

PTR_OP_A = $0200;
LEN_OP_A = $0202;
PTR_OP_B = $0204;
LEN_OP_B = $0206;
PTR_RES = $0210;
LEN_RES = $0212;

  .org $e000

reset:
  ; initialize stack pointer at $01ff
  ldx #$ff
  txs
