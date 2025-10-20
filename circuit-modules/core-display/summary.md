# Core Display module

This module provides a basic text output capability through a 16x2 character LCD display. It uses a stand-alone HD44780 + LCD module, and interfaces through a dedicated `VIA` (65C22) chip with the rest of the system.

## Connections

- Main power needs to be provided to the `VIA` chip (pin 1 `VSS` for ground and pin 20 `VDD` for +5V), the main LCD driver (pin 1 `VSS` for ground and pin 2 `VDD` for +5V), and the backlight (pin 15 `A` for +5V and pin 16 `K` for ground). In addition, a potentiometer (20kΩ in this design) is used to adjust the contrast of the LCD. It should be connected between +5V and ground, with the wiper (middle pin) connected to pin 3 (`VO`) of the LCD module.
- Decoupling capacitors (typically 100nF) should be placed as close as possible to the power pins of the `VIA` chip (pins 1 and 20) and the LCD driver (pins 1 and 2) to ensure stable operation.
- The 8 bits of the `B` port of the `VIA` (pins 10 to 17) are connected to the data pins of the LCD (pins 7 to 14). This design uses 8-bit mode for simplicity, although 4-bit mode could be used to save some pins at the cost of added complexity.
- The remaining control pins of the LCD are connected to the `A` port of the `VIA`: pin 4 (`RS`) to bit 5 of the port (pin 7 `PA5`), pin 5 (`RW`) to bit 6 of the port (pin 8 `PA6`), and pin 6 (`E`) to bit 7 of the port (pin 9 `PA7`). The rest of the bits of port `A` (pins 2 to 6, corresponding to bits 0 to 4) are left unconnected in this design.
- The `VIA`s `CA1` (pin 40) and `CB1` (pin 18) pins are pulled high through 220Ω resistors, and the `CA2` (pin 39) and `CB2` (pin 19) pins are left unconnected. These pins are not used in this design, but pulling `CA1` and `CB1` high helps ensure stable operation.
- The remaining pins of the `VIA` chip need to be connected to either the global bus board or the address decoder module:
  - The Register Select pins (`RS0` through `RS3`, pins 38 to 35) are connected to address lines `A0` through `A3` respectively.
  - The chip select pins (`CS1` and `CS2B`, pins 24 and 23) should connect to the address decoder module (exact logic depends on the version of the address map being used).
  - The `IRQB`, `RESB`, `RWB`, and `PHI2` pins (pins 21, 34, 22, and 25, respectively), as well as the eight data pins (`D0` through `D7`, pins 33 to 26), should connect to the global bus board.

## Board design

The top side of the `VIA` chip (pins 21 to 40) is connected mainly through a custom dupont cable. On breadboard builds (either soldered or solderless), dupont cables also work well for the connection between the `VIA` and the LCD module; but a custom PCB could simply have traces for these and reduce the amount of wires used.

On the soldered breadboard, a pin header is used to connect the LCD module to allow easy replacement if needed. Due to this, an extra header is added just to help support the weight of the module and avoid excess stress on the actual header pins. This shouldn't be necessary if the LCD module is directly soldered, but that would reduce the flexibility of this module.