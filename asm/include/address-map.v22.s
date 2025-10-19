;; Version 2.2
; Evolution of 2.1, reorganizing the I/O section to better fit a reasonable
;   amount of VIA and ACIA chips (12 of each) and leave space for future use.

; Pre-defined 65c02 addresses:
ZERO_PAGE = $0000 ; Zero page start
STACK = $0100 ; Stack start

; Pre-defined vectors for 65c02 and 65c816
; Each vector is 2 bytes (little-endian)
; It is recommended to initialize the reserved areas to zero
; For 65c02, this would be 10 bytes starting at $FFF0 (up to $FFF9)
; For 65c816, this would be a few addresses in pages 00FE and 00FF

; __RESERVED__ = $FFF0 ;
; __RESERVED__ = $FFF2 ;
VECTOR_816_E_COP = $FFF4 ; COP vector (65c816, 8-bit mode)
; __RESERVED__ = $FFF6 ;
VECTOR_816_E_ABORT = $FFF8 ; Abort vector (65c816, 8-bit mode)
VECTOR_NMI = $FFFA ; NMI vector
VECTOR_RESET = $FFFC ; Reset vector
VECTOR_IRQ = $FFFE ; IRQ/BRK vector
; __RESERVED__ = $FFE0 ;
; __RESERVED__ = $FFE2 ;
VECTOR_816_N_COP = $FFE4 ; COP vector (65c816, 16-bit mode)
VECTOR_816_N_BRK = $FFE6 ; BRK vector (65c816, 16-bit mode)
VECTOR_816_N_ABORT = $FFE8 ; Abort vector (65c816, 16-bit mode)
VECTOR_816_N_NMI = $FFEA ; NMI vector (65c816, 16-bit mode)
; __RESERVED__ = $FFEC ; No reset vector for 16-bit mode, reset always goes to 8-bit mode
VECTOR_816_N_IRQ = $FFEE ; IRQ vector (65c816, 16-bit mode)

; Addressable chip positions (64 Ki@ layout, v2.1)
SRAM = $0000 ; Main RAM chip (32 KiB): $0000 - $7FFF
; These ranges are defined by the 6502 architecture:
; Zero page: $0000 - $00FF (256 bytes)
; Stack: $0100 - $01FF (256 bytes)
SRAM_CORE = SRAM + $0200 ; Reserved for core routines $0200 - $1FFF (7KiB)
SRAM_USER = SRAM + $2000 ; general-purpose RAM $2000 - $7FFF (24KiB)

; I/O address space (from $8000 to $9FFF)
; VIA chips (W65C22), up to 12 chips, 16 addresses each (192 addresses total)
IO_VIA_0 = $8000 ; (16 bytes): $8000-$800F
IO_VIA_1 = $8010 ; (16 bytes): $8010-$801F
IO_VIA_2 = $8020 ; (16 bytes): $8020-$802F
IO_VIA_3 = $8030 ; (16 bytes): $8030-$803F
IO_VIA_4 = $8040 ; (16 bytes): $8040-$804F
IO_VIA_5 = $8050 ; (16 bytes): $8050-$805F
IO_VIA_6 = $8060 ; (16 bytes): $8060-$806F
IO_VIA_7 = $8070 ; (16 bytes): $8070-$807F
IO_VIA_8 = $8080 ; (16 bytes): $8080-$808F
IO_VIA_9 = $8090 ; (16 bytes): $8090-$809F
IO_VIA_10 = $80A0 ; (16 bytes): $80A0-$80AF
IO_VIA_11 = $80B0 ; (16 bytes): $80B0-$80BF
; VIA address offsets for internal registers
OFFSET_VIA_PORTB = $00 ; I/O port B
OFFSET_VIA_PORTA = $01 ; I/O port A
OFFSET_VIA_DDRB = $02 ; Data direction register for port B
OFFSET_VIA_DDRA = $03 ; Data direction register for port A
OFFSET_VIA_T1C_L = $04 ; Timer 1 counter low byte
OFFSET_VIA_T1C_H = $05 ; Timer 1 counter high byte
OFFSET_VIA_T1L_L = $06 ; Timer 1 latch low byte
OFFSET_VIA_T1L_H = $07 ; Timer 1 latch high byte
OFFSET_VIA_T2C_L = $08 ; Timer 2 counter low byte
OFFSET_VIA_T2C_H = $09 ; Timer 2 counter high byte
OFFSET_VIA_SR = $0A ; Shift register
OFFSET_VIA_ACR = $0B ; Auxiliary control register
OFFSET_VIA_PCR = $0C ; Peripheral control register
OFFSET_VIA_IFR = $0D ; Interrupt flag register
OFFSET_VIA_IER = $0E ; Interrupt enable register
OFFSET_VIA_PORTA_NO_HSK = $0F ; Port A no handshake

; ACIA chips (W65C51), up to 12 chips, 4 addresses each (48 addresses total)
IO_ACIA_0 = $80C0 ; (4 bytes): $80C0-$80C3
IO_ACIA_1 = $80C4 ; (4 bytes): $80C4-$80C7
IO_ACIA_2 = $80C8 ; (4 bytes): $80C8-$80CB
IO_ACIA_3 = $80CC ; (4 bytes): $80CC-$80CF
IO_ACIA_4 = $80D0 ; (4 bytes): $80D0-$80D3
IO_ACIA_5 = $80D4 ; (4 bytes): $80D4-$80D7
IO_ACIA_6 = $80D8 ; (4 bytes): $80D8-$80DB
IO_ACIA_7 = $80DC ; (4 bytes): $80DC-$80DF
IO_ACIA_8 = $80E0 ; (4 bytes): $80E0-$80E3
IO_ACIA_9 = $80E4 ; (4 bytes): $80E4-$80E7
IO_ACIA_10 = $80E8 ; (4 bytes): $80E8-$80EB
IO_ACIA_11 = $80EC ; (4 bytes): $80EC-$80EF
; ACIA address offsets for internal registers
OFFSET_ACIA_DATA = $00 ; Data register
OFFSET_ACIA_STATUS = $01 ; Status register
OFFSET_ACIA_CMD = $02 ; Command register
OFFSET_ACIA_CTRL = $03 ; Control register

; reserved for config / setup of the VIA and ACIA chips:
UNUSED_IO_CONFIG = $80F0 ; $80F0-$80FF (16 bytes)

ROM0 = $E000 ; Main ROM chip: $E000-$FFFF (8KiB)
ROM1 = $C000 ; Second ROM chip (if present): $C000-$DFFF (8KiB)
ROM2 = $A000 ; Third ROM chip (if present): $A000-$BFFF (8KiB)
