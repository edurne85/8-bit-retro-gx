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

The module includes several leds to provide visual feedback on its operation: 8 LEDs (3mm THT) help keep track of the mode selected, and a few more (5mm THT) track the RC and manual clock sources, the power status, and the halt status. The color of the LEDs is generally a matter of choice, but that choice can condition the value of the current-limiting resistors used. Also, it's not necessary to drive the LEDs at their full rated current, as long as it's enough to be clearly visible. Here is a table of the LEDs and resistors used in my implementation, and the calculated minimum resistor values for their rated current (20 mA for each of them) and forward voltage (assuming a 5V supply):

| LED key | Color | Description | Resistor used | Forward voltage | Min. resistor |
|---------|-------|-------------|---------------|-----------------|---------------|
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

## Potential changes

Due to the experimental nature of the project, this module priorizes observability over power efficiency. Here are a few changes that could be made to substantially reduce power consumption:

- Remove all the signaling leds and possibly the decoder IC. Typically, between 2 and 5 leds are on at any given time, each consuming around 6mA at the current brightness level. Removing them would save a significant amount of power. The decoder IC should have a much lower power consumption, but removing it may still be a reasonable cost reduction once the leds are removed. If power efficiency is a priority, but cost and board size are not, keeping the decoder would still allow for some observability by hooking up the outputs with a multimeter or logic analyzer when needed.

- Use CMOS logic ICs instead of TTL. The current implementation was built with what I had available. Specifically, the multiplexer (74LS151) could be replaced with a CMOS equivalent (e.g., 74HC151), which would also allow larger pull-down resistors on the mode-selection inputs (like 10kΩ instead of 2.2kΩ), substantially reducing the current drawn through them when the switches are on.

Also, by bridging together some pins on the socket for the crystal oscillator, it should easily support DIP-8 packages in addition to DIP-14. The pins to bridge would be (based on the DIP-14 socket pinout): 4-5-6-7 and 8-9-10-11. Adding additional bridges for 1-2-3 and 12-13-14 would make the positioning of DIP-8 packages more flexible, but this is merely a convenience.

## Troubleshooting and fixes

After a few revisions, the PCB build is working as intended, and the circuit files in this repository reflect the final design. However, no new boards have been fabricated after some of these changes, so the pictures and videos may look slightly different from the actual final design (placements and component values differing slightly from what's printed on the silkscreen and external wires connecting to some components).

The first issue detected was the button for the manual button being wired incorrectly, permanently jumping that signal. On the files, the fix was as simply as swapping the connections to the button and updating the PCB layout, but on the existing build it took a bit of desoldering and resoldering, in addition to bending some leads to reach the desired pads.

Another fix was related to the orientation of the transistor used as a level shifter for the crystal oscillator output, which was reversed in the first PCB version due to an incorrect footprint mapping (it was correct on the circuit schematic), so the files only required re-mapping those pins and updating the PCB layout. Again, for fixing the build the component had to be desoldered and resoldered in the correct orientation, so on pictures it can be seen as "reversed" from the silkscreen marking.

Finally, the pull-down resistors on the mode selection inputs were changed from 10kΩ to 2.2kΩ to improve signal integrity, as the voltages when the switches were off were often too high (around 1.12V) for TTL logic (by spec, should be below 0.8V): with this change, the voltages when the switches are off are now around 0.4V, which is safer and more reliable. The changes on the files were as simple as changing the resistor values, which only changed the silkscreen markings on the PCB layout (footprints and connections remained the same). On my build, the desoldering and resoldering ended up damaging the pads around one of the resistors, so I had to use the resistor's lead itself and some wire to reconnect along the damaged traces.