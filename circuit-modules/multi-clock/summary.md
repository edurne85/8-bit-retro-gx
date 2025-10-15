# Multi-Clock Module

This module provides several clock signals and a few switches to select between them. The circuit has one primary output signal, one halt input, and some built-in controls:
    - DIP switches to select the clock source / mode.
    - A button to manually step the clock when in manual mode.
    - A potentiometer to adjust the frequency of the RC oscillator.
    - A bunch of leds to easily identify the current mode and some of the signals.

## Primary clock sources

These are the main clock sources built into this module:
- **RC Oscillator**: A 555 timer configured as an astable multivibrator. The frequency can be adjusted using the potentiometer. With the values used in this design, the frequency range is approximately `ToDo: measure and calculate the range`. The design is based on, and almost identical to, Ben Eater's design in [this video](https://www.youtube.com/watch?v=kRlSFm519Bo).
- **Manual trigger**: A push-button that generates a clock pulse when pressed, using a 555 timer in monostable mode as a debouncer. The design is based on, and almost identical to, Ben Eater's design in [this video](https://www.youtube.com/watch?v=81BgFhm2vz8).
- **Crystal oscillator**: A crystal oscillator package (e.g., 1 MHz), that can be used directly or divided through a binary counter, providing faster and smoother signals than the RC oscillator. Because the output voltage of the crystal oscillator can vary between models and manufacturers (and the ones I used were too low to directly drive TTL logic), a NPN BJT transistor is used as a level shifter to ensure a clean 5V(ish) output. This module chains both 4-bit counters on a 74HC393 to get binary fractions of the main frequency from 1/2 to 1/256. Note that only some of these are directly available due to the goal of sticking to only 3 swtiches and 3-to-8 decoder logic for mode control, but it shouldn't be difficult to adapt the circuit to use different counters, decoders, or even simply take some of the other signals.

## Detailed output modes

The clock module has 8 different modes, selected using a 3-bit binary input (DIP switches). The modes are as follows:
- `%000` (0): Stand by / off: The clock output is held low (0V).
- `%001` (1): RC Oscillator: The clock output is driven by the RC oscillator.
- `%010` (2): Manual trigger: The clock output is driven by the manual trigger button.
- `%011` (3): Crystal oscillator: The clock output is driven directly by the crystal oscillator (1 MHz).
- `%100` (4): Crystal oscillator / 2: The clock output is driven by the crystal oscillator divided by 2 (500 kHz).
- `%101` (5): Crystal oscillator / 4: The clock output is driven by the crystal oscillator divided by 4 (250 kHz).
- `%110` (6): Crystal oscillator / 16: The clock output is driven by the crystal oscillator divided by 16 (62.5 kHz).
- `%111` (7): Crystal oscillator / 256: The clock output is driven by the crystal oscillator divided by 256 (3.90625 kHz).

The relevant control signals are also connected to a 3-to-8 decoder (74HC238) controlling 8 signaling leds. These are only a visual aid and can be cut off (including the decoder IC) to achieve much lower power consumption without changing the main functionality of the module. The version of the IC I used can drive enough current for the leds, but if using a different model or type, it may be convenient to feed the outputs through a transistor or a dedicated led driver. In any case, current-limiting resistors should be used, and different led colors may require different resistor values. Full details on the leds used are given later in this document.

## Halt input

As long as the halt input is held high (5V), the clock output is forced low (0V), regardless of the selected mode or the state of the internal clock sources. The module includes a pull-down (10kΩ) resistor at this input, so it can be safely floated when not needed. Internal clock sources continue to operate normally while halted, so when the halt signal is released, the clock output resumes normal operation according to the selected mode and the state of the internal sources.

## Monitoring LEDs

The module includes several leds to provide visual feedback on its operation: 8 LEDs (3mm THT) help keep track of the mode selected, and a few more (5mm THT) track the RC and manual clock sources, the power status, and the halt status. The color of the LEDs is generally a matter of choice, but that choice can condition the value of the current-limiting resistors used. Also, it's not necessary to drive the LEDs at their full rated current, as long as it's enough to be clearly visible. Here is a table of the LEDs and resistors used in my implementation, and the calculated minium resistor values for their rated current (20 mA for each of them) and forward voltage (assuming a 5V supply):

| LED key | Color | Description | Resistor used  | Forward voltage | Min. resistor |
|---------|-------|-------------|----------------|---------------- |---------------|
| OFF | Orange | Mode 0: Stand by | 470Ω | 2.0V - 2.2V | 150Ω |
| RC | Green | Mode 1: RC Oscillator | 330Ω | 3.0V - 3.2V | 100Ω |
| MAN | Yellow | Mode 2: Manual | 470Ω | 2.0V - 2.2V | 150Ω |
| C/1 | White | Mode 3: Crystal (direct) | 330Ω | 3.0V - 3.2V | 100Ω |
| C/2 | Blue | Mode 4: Crystal / 2 | 330Ω | 3.0V - 3.2V | 100Ω |
| C/4 | Blue | Mode 5: Crystal / 4 | 330Ω | 3.0V - 3.2V | 100Ω |
| C/16 | Blue | Mode 6: Crystal / 16 | 330Ω | 3.0V - 3.2V | 100Ω |
| C/256 | Blue | Mode 7: Crystal / 256 | 330Ω | 3.0V - 3.2V | 100Ω |
| LPWR | Green | Power indicator | 330Ω | 3.0V - 3.2V | 100Ω |
| LHALT | Red | Halt indicator | 470Ω | 2.0V - 2.2V | 150Ω |
| LP-RC | Green | RC oscillator high | 330Ω | 3.0V - 3.2V | 100Ω |
| LP-M | Yellow | Manual trigger high | 470Ω | 2.0V - 2.2V | 150Ω |

Even at the reduced brightness used in my implementation, the LEDs take over 6mA each, and between 2 and 5 of them are on at any given time; so if power and cost efficiency are priorities, omitting them (as well as the decoder IC) is a valid option: this should reduce the power usage as well as the amount of components and the PCB size.

## Known issues

- 🤯 **Fatal**: As of this version, the PCB implementation is not working as expected. Some issues have identified and addressed (see below), but the main output seems to stay permanently high (or blinking rapidly, so far it has been only tested by feeding a led off it). Further debugging is needed to identify and fix the remaining issues.

- ℹ️ **Fixed**: The signal for the manual trigger stayed on (high) all the time, regardless of the button state. The button element was incorrectly placed in the schematic and the PCB, in a way that it was bridging the corresponding input at all times. Current schematic and PCB files have been corrected; but the boards already made still have this issue. A bit of bending on the legs of the push button is needed to make it fit in the fixed orientation on these boards.

- ℹ️ **Fixed**: The transistor driving the crystal oscillator output was reversed (the schematic is correct, but the PCB silkscreen swaps the collector and emitter). The footprint used to generate the PCB was incorrect. By remapping the pins, the current version of the PCB files is corrected; but for boards already made, the position of the transistor is swapped from the shape suggested by the silkscreen. The most reliable way to identify the correct pinout is to check continuity between PCB pads: the collector must be connected to +5V and the emitter must go to the counter's first clock and the decoder's D4 input (pin 1 on the 74HC393 and pin 1 on the 74LS151).