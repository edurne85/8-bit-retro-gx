;; Version 2.0
; Full redesign of the memory map (versions 1.x refer to the original Ben Eater's implementations)
; NOTE: This version was never used as presented here; this file has been put together for reference
;   based on the circuit schemas and old (markdown) documentation.
; The main goal when moving from 1.x to 2.0 was to expand RAM (at the expense of ROM), and add some
;   structure to the ROM and I/O areas. The main ROM was reduced from 32KiB to 8KiB, and only a small
;   space within the 0x8000-0xBFFF was really used (for I/O).


; Addressable chip positions (64 Ki@ layout, v2.0)
SRAM = $0000 ; Main RAM chip (32 KiB): $0000 - $7FFF
IO_VIA_0 = $BC00 ; VIA chip (W65C22) to drive the 1602 LCD output (16 bytes): $BC00-$BC0F
ROM0 = $E000 ; Main ROM chip: $E000-$FFFF (8KiB)
