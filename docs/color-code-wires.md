# Color coding for wires and connections

In order to make larger circuits manageable, this project uses a color-coding scheme for wires and connections. Wire colors that are widely available are used for the mostly used signals; a few other colors are used for more specific purposes.

## Summary table

| Color  | Main usage   |
|--------|--------------|
| Red    | Power (+5V)  |
| Black  | Ground       |
| Yellow | Address bus  |
| Green  | Data bus     |
| Blue   | Clock        |
| Purple | Control (CE) |
| Orange | Interrupts   |
| Brown  | R/W signals  |
| Pink   | Reset signal |

White is used sparingly as it may be difficult to spot on breadboards. Gray is also avoided because the shade of gray can vary a lot between providers, and it could easily be confused with either black or white.