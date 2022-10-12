The current setup maps the 65536 available addresses as follows:

- `$0000` - `$7FFF`: 256Kib (32Ki x8-bit) SRAM
  - `$0000` - `$1FFF`: System reserved memory
  - `$2000` - `$7FFF`: General purpose memory
- `$8000` - `$BBFF`: _(Currently unused)_
- `$BC00` - `$BC0F`: W65C22 VIA chip
  - Driving a 1602 LCD display
- `$BC10` - `$BFFF`: _(Currently unused)_
- `$C000` - `$DFFF`: Reserved for 2nd ROM chip
- `$E000` - `$FFFF`: 64Kib (8Ki x8-bit) EEPROM (main ROM)