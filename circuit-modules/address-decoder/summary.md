# Address Decoder module

The main task of this module is to generate chip control (such as chip enable, output enable, and write enable) for the different memory and peripheral chips in the system implementing the memory map. In addition, it uses the main clock signal to better refine some of these control signals (primarily the write enable signals for RAM chips) when strict timing requirements are involved.

Note that versions 1.x of the address map do not correspond to an explicit decoder module, and are just documenting the address layout of the original builds in Ben Eater's 6502 series.

## Module design considerations

To help make the timing of the signals more predictable, this module aims to use restrict and homogenize the types of ICs involved. In all versions, the main logic is handled with some demux ICs and a few logical gates. Some versions used both AND and NAND gates, and even mixed CMOS and TTL logic families, but the aim is to move to using only 74HC series ICs for best consistency, and to use only NAND gates.

Below is a quick table of ICs that may be used in different versions of this module:

| IC       | Description                               |
|----------|-------------------------------------------|
| 74HC238  | 3-to-8 line demux                         |
| 74HC139  | (currently unused) Dual 2-to-4 line demux |
| 74HC4514 | (currently unused) 4-to-16 line demux     |
| 74HC00   | Quad 2-input NAND gates                   |
| 74LS08   | (obsolete) Quad 2-input AND gates (TTL)   |