LCD_PORTB = $bc00
LCD_PORTA = $bc01
LCD_DDRB = $bc02
LCD_DDRA = $bc03

LCD_E  = %10000000
LCD_RW = %01000000
LCD_RS = %00100000

LCD_1602_8BIT = %00111000

lcd_init:
    ;; Initializes the LCD display with sensible defaults
    ;  Modified registers: P
    ;  Inputs: (none)
    ;  Max. stack depth: +7 (base call +2, lcd_instruction +5)
  pha
  lda #%11111111 ; Set all pins on port B to output
  sta LCD_DDRB
  lda #%11100000 ; Set top 3 pins on port A to output
  sta LCD_DDRA

  lda #LCD_1602_8BIT ; Set 8-bit mode; 2-line display; 5x8 font
  jsr lcd_instruction
  lda #%00001110 ; Display on; cursor on; blink off
  jsr lcd_instruction
  lda #%00000110 ; Increment and shift cursor; don't shift display
  jsr lcd_instruction
  lda #$00000001 ; Clear display
  jsr lcd_instruction

  pla
  rts

lcd_wait:
    ;; Waits for the LCD to be ready by activelly polling the busy flag
    ;  Modified registers: P
    ;  Inputs: (none)
    ;  Max. stack depth: +3 (base call +2, A register +1)
  pha
  lda #%00000000  ; Port B is input
  sta LCD_DDRB
_lcdbusy:
  lda #LCD_RW
  sta LCD_PORTA
  lda #(LCD_RW | LCD_E)
  sta LCD_PORTA
  lda LCD_PORTB
  and #%10000000
  bne _lcdbusy

  lda #LCD_RW
  sta LCD_PORTA
  lda #%11111111  ; Port B is output
  sta LCD_DDRB
  pla
  rts

lcd_instruction:
    ;; Sends an instruction to the LCD display
    ;  Modified registers: A, P
    ;  Inputs:
    ;       A: Instruction code to send to the LCD
    ;  Max. stack depth: +5 (base call +2, lcd_wait +3)
  jsr lcd_wait
  sta LCD_PORTB
  lda #0         ; Clear RS/RW/E bits
  sta LCD_PORTA
  lda #LCD_E     ; Set E bit to send instruction
  sta LCD_PORTA
  lda #0         ; Clear RS/RW/E bits
  sta LCD_PORTA
  rts

lcd_print_char:
    ;; Sends an character to the LCD display
    ;  Modified registers: A, P
    ;  Inputs:
    ;       A: Character (ascii code, or per custom font) to send to the LCD
    ;  Max. stack depth: +5 (base call +2, lcd_wait +3)
  jsr lcd_wait
  sta LCD_PORTB
  lda #LCD_RS           ; Set RS; Clear RW/E bits
  sta LCD_PORTA
  lda #(LCD_RS | LCD_E) ; Set E bit to send data
  sta LCD_PORTA
  lda #LCD_RS           ; Clear E bits
  sta LCD_PORTA
  rts
