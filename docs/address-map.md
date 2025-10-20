`v2.0 2022-10-12`

The current setup maps the 65536 available addresses as follows:

- `$0000` - `$7FFF`: 256Kib (32Ki x8-bit) SRAM
  - `$0000` - `$1FFF`: System reserved memory
    - `$0000` - `$00FF`: Zero-Page space
    - `$0100` - `$01FF`: 6502 stack space
    - `$0200` - `$0217`: Operators and results for built-in (Core ROM) operations
    - `$0218` - `$1FFF`: _(Currently unused)_
  - `$2000` - `$7FFF`: General purpose memory
- `$8000` - `$BBFF`: _(Currently unused)_
- `$BC00` - `$BC0F`: W65C22 VIA chip
  - Driving a 1602 LCD display
- `$BC10` - `$BFFF`: _(Currently unused)_
- `$C000` - `$DFFF`: Reserved for 2nd ROM chip
- `$E000` - `$FFFF`: 64Kib (8Ki x8-bit) EEPROM (Core ROM).
  - `$E000`: The 65C02's reset vector is forced to point here, so this is the start of the boot code that runs upon system reset.
  - `$FFFA` - `$FFFF`: System vectors. Currently the reset vector points to `$E000` and the `IRQ` and `NMI` vectors point to `$0000`.