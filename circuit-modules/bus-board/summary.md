# The bus board

While technically not a circuit by itself, the bus board can be regarded as another module (it has its own board and a very distinct purpose).

At the moment, it's a breadboard with a bunch of jumpers (color-coded) across the middle gap, as well as some printed labels for improved clarity.

While it'd be possible to set this up as a soldered board (just a bunch of headers on a stripboard), that would provide no benefit over the breadboard due to having no components at all (only connections). In the future, such a soldered board may make sense if many more connections are needed on the same line(s) (the breadboard layout can accommodate 8 connections per line).

This board allows a convenient way to connect the different modules to the 16-bit address bus, the 8-bit data bus, and a few other global signals:
 - Main system clock
 - R/W signal
 - Interrupt request line
 - Non-maskable interrupt line
 - Reset signal
These may be tweaked in future versions.

Note: the board shown in the picture was reused from an earlier version where multiple clock signals were available (allowing to manually change between them). Thanks to the multi-clock module, only one clock line is needed, and variations are handled directly from that module. Later versions will probably update the labels and remove unnecessary gaps. Additional gray wires are placed blocking the unused rows for enhanced clarity.

Note 2: omitting the spacing between groups of lines, it should be possible to fit everything on a 30-row breadboard (currently 29 lines are being used). At the moment, clarity is prioritized over compactness, so a full-size (830p) is used.