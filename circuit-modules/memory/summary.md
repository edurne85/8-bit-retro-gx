# Memory module

This module holds some SRAM and ROM chips to provide the main memory for the system. Data and address pins are shared between the different chips and connected directly to the global bus board, while control signals are generated through the address decoder module according to the memory map version being implemented.

Most versions should include at least the main SRAM (32KiB) and the Core ROM (8KiB). Future versions are likely to include additional ROM chips, for which space is already allocated on the address map starting with version 2.1.

## Board design

On breadboards, a substantial amount of wires is needed to connect all the address and data pins for each chip. Even with custom dupont cables, this starts to get messy even with only the two main chips.

The PCB design addresses this by using traces instead of wires. This board is technically not a circuit, since it only contains traces, sockets, and headers, but it is highly convenient.

The PCB has a 20-pin header to connect to the address bus, an 8-pin header to connect to the data bus, a 2-pin header for power, and then separate headers (3-pin) and sockets for each chip. Current design has 4 DIP-28 sockets (which can accommodate many 8 to 32 KiB chips) and 2 DIP-32 sockets (for future use of up to 512 KiB chips). The higher address bits are only connected to the larger sockets, and some chips (mainly the 8KiB ROMs) have `NC` pins where some address lines would connect. See below for details on known chip compatibility.

On the 3-pin headers, pin 1 of each header goes to `CE#` pin (chip enable, active-low) pin of each chip (pin 20 on DIP-28 and pin 22 on DIP-32); pin 2 goes to `OE#` (output enable, active-low) pin of each chip (pin 22 on DIP-28 and pin 24 on DIP-32); and pin 3 goes to `WE#` (write enable, active-low) pin of each chip (pin 27 on DIP-28 and pin 29 on DIP-32).

Note: the `WE#` signal for each chip shouldn't be connected directly to the global bus `RWB` signal: ROM chips should have this line permanently held high (inactive) and be programmed externally; and RAM chips usually need additional logic to meet timing requirements. The address decoder module is responsible for generating the proper control signals for each chip, and it is assumed to use the main clock in addition to the global address lines as a input.

## Chip compatibility on the PCB

The PCB was designed with flexibility in mind, allowing many different memory configurations. The following table lists the chips for which the layout was designed, specifying which sockets they can fit into and how many address lines they use.

| Chip        | Summary      | Socket | Address lines |
|-------------|--------------|--------|---------------|
| AS6C62256   | 32KiB SRAM   | DIP-28 | A0 to A14     |
| AS6C40080   | 512KiB SRAM  | DIP-32 | A0 to A18     |
| AT28C256    | 32KiB EEPROM | DIP-28 | A0 to A14     |
| AT28C64B    |  8KiB EEPROM | DIP-28 | A0 to A12     |

Any chip with the same pinout and voltages as these should also work.

**⚠️ Important note:** 28-pin chips must not be placed in the 32-pin sockets. While the pinouts make damage unlikely, it's also impossible for such chips to work: power pins are on opposite corners of these chips, so a 28-pin chip placed in a 32-pin socket would never receive power. Trying to place a 32-pin chip in a 28-pin socket could be physically possible (leaving some pins unconnected), and is much more likely to cause damage on the chip (mainly by miswiring power or ground). Just because you can doesn't mean you should!