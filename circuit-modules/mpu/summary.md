# Processor Module

This module includes the MPU (a 65C02 chip), the reset subcircuit, and, in the case of the soldered build, a few headers to connect to the rest of the system.

In addition, a set of cables with custom dupont connectors was made to help connect this module.

## Connections

The soldered board has some connections already fixed; these need to be manually set up when setting this module up on a solderless breadboard.

- The reset subcircuit output must be connected to the MPU's `RESB` pin (pin 40). In addition, the signal should also connect to the global bus board so it can be used by other chips if needed (mainly VIA 65C22 chips).
- Main power to the MPU chip is provided through pins 8 (`VDD`, +5V on this design) and 21 (`VSS`, ground).
- As per datasheet recommendations, pin 38 (`SOB`) should be tied to a fixed value. In this design, it's directly bridged to ground, which should help minimize power waste.
- At least one decoupling capacitor (typically 100nF) should be placed in the power rails, as close as possible to either of the power pins (8 or 21). This design of the board sets it up adjacent to pin 8.
- The data and address buses, as well as some of the control signals (`PHI2`, `RWB`, `IRQB`, `NMI`) are connected to the global bus board.
- Remaining control signals (mainly `RDY` and `BE`) should be connected as needed, and the custom dupont cables provide wires for each.
- As of this version, the additional output signals (`PHI1O`, `PHI2O`, `MLB`, and `SYNC`) are not used and not even included in the dupont connectors. They may be connected in future versions if needed.

## Reset subcircuit

The reset subcircuit is essentially a button pulled high through a 100Ω resistor that bridges into ground when pressed. While a higher resistance could help save some power, the 100Ω value ensures that the pin is solidly kept high when the button is not pressed. In addition, a led (with its current-limiting resistor) is wired to be grounded through the button, so it lights up when the button is pressed, providing visual feedback that the reset signal is being sent to the system.