MATH_OP_A = $0200 ; Up to 4 bytes
MATH_OP_B = $0204 ; Up to 4 bytes
MATH_OP_C = $0208 ; Up to 4 bytes
MATH_OP_D = $020C ; Up to 4 bytes
MATH_RES = $0210 ; Up to 8? bytes

math_add32:
    ;; 32-bit addition: 32-bit + 32-bit = 32-bit w/C
    ; Modified registers: P[0] (carry)
    ; Inputs: Operands in MATH_OP_A and MATH_OP_B (32-bit each)
    ; Outputs: Result in MATH_RES (32-bit)
    ; Max stack depth: +3 (base call +2, registers +1)
    ; Execution time:
    ;   Setup: 5 cycles
    ;   Main: 48 cycles (12 cycles per byte)
    ;   Cleanup: 10 cycles
    ;   Total: 63 cycles (constant)

    pha ; 3t
    clc ; 2t

    lda MATH_OP_A ; 4t
    adc MATH_OP_B ; 4t
    sta MATH_RES ; 4t
    lda MATH_OP_A + 1 ; 4t
    adc MATH_OP_B + 1 ; 4t
    sta MATH_RES + 1 ; 4t
    lda MATH_OP_A + 2 ; 4t
    adc MATH_OP_B + 2 ; 4t
    sta MATH_RES + 2 ; 4t
    lda MATH_OP_A + 3 ; 4t
    adc MATH_OP_B + 3 ; 4t
    sta MATH_RES + 3 ; 4t

    pla ; 4t
    rts ; 6t

math_mult16:
    ;; 16-bit multiplication: 16-bit x 16-bit -> 16-bit
    ; Modified registers: none (pre-saved)
    ; Inputs: Operands in MATH_OP_A and MATH_OP_B (16 bits each)
    ; Outputs: Result in MATH_RES (16 bits)
    ; Max stack depth: +5 (base call +2, registers +3)
    ; Execution time:
    ;   Setup: 13 cycles
    ;   Main loop: 795 cycles
    ;   Cleanup: 18 cycles
    ;   Total: 826 cycles (maximum)

    pha ; 3t
    phx ; 3t
    phy ; 3t

    ; Storing high byte of result in X, low byte in Y
    ldx #0 ; 2t
    ldy #0 ; 2t

_mult16_1:
    lda MATH_OP_A     ; 4t
    ora MATH_OP_A + 1 ; 4t
    beq _mult16_done  ; 2t/3t (2t for worst case)
    lsr MATH_OP_A + 1 ; 4t
    ror MATH_OP_A     ; 4t
    bcc _mult16_2     ; 2t/3t (2t for worst case)
    clc               ; 2t
    tya               ; 2t
    adc MATH_OP_B     ; 4t
    tay               ; 2t
    txa               ; 2t
    adc MATH_OP_B + 1 ; 4t
    tax               ; 2t
_mult16_2:
    asl MATH_OP_B     ; 4t
    rol MATH_OP_B + 1 ; 4t
    jmp _mult16_1     ; 3t
    ; Full _mult16_1 execution time: 49 cycles
    ; Cleanup: 4+4+3 = 11 cycles
    ; Full loop: 49 cycles * 16 it + 11= 795 cycles

_mult16_done:
    ; Restore registers
    ply ; 4t
    plx ; 4t
    pla ; 4t
    rts ; 6t

_itoh_table: .asciiz "0123456789ABCDEF"

math_lowToHex:
    ;; Computes the hexadecimal-ascii representation of the low nibble of a value
    ;  Modified registers: A, P
    ;  Inputs:
    ;       A: Value to compute (only low nibble is used)
    ;  Outputs:
    ;       A: hexadecimal ascii representation of the low nibble of the input value
    ;  Max. stack depth: +2 (base call +2)
    ; Execution time: 14 cycles (constant)
    and #%00001111    ; 2t
    tax               ; 2t
    lda _itoh_table,x ; 4t
    rts               ; 6t

math_highToHex:
    ;; Computes the hexadecimal-ascii representation of the high nibble of a value
    ;  Modified registers: A, P
    ;  Inputs:
    ;       A: Value to compute (only high nibble is used)
    ;  Outputs:
    ;       A: hexadecimal ascii representation of the high nibble of the input value
    ;  Max. stack depth: +2 (base call +2)
    ;  Execution time: 20 cycles (constant)
    lsr               ; 2t
    lsr               ; 2t
    lsr               ; 2t
    lsr               ; 2t
    tax               ; 2t
    lda _itoh_table,x ; 4t
    rts               ; 6t
