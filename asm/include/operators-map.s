
MATH_OP_A = SRAM_CORE + $0000 ; Up to 4 bytes
MATH_OP_B = SRAM_CORE + $0004 ; Up to 4 bytes
MATH_OP_C = SRAM_CORE + $0008 ; Up to 4 bytes
MATH_OP_D = SRAM_CORE + $000C ; Up to 4 bytes
MATH_RES = SRAM_CORE + $0010 ; Up to 8? bytes

PTR_OP_A = SRAM_CORE + $0200 ; 2 bytes
LEN_OP_A = SRAM_CORE + $0202 ; 2 bytes
PTR_OP_B = SRAM_CORE + $0204 ; 2 bytes
LEN_OP_B = SRAM_CORE + $0206 ; 2 bytes
PTR_RES = SRAM_CORE + $0210 ; 2 bytes
LEN_RES = SRAM_CORE + $0212 ; 2 bytes
