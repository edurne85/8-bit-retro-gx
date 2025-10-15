# Summary of circuit modules

Different parts of the main circuit are implemented in separate modules. This directory contains detailed descriptions of each such module.

## Structure of module directories

Each module has its own subdirectory, typically with this structure:

- `summary.md`: description of the module, including its purpose and major design and implementation choices.
- `schematic.png`: schematic diagram of the module (usually exported from EasyEDA).
- `schematic.json`: EasyEDA source file for the schematic diagram.
- `pcb.svg`: layout of the PCB (usually exported from EasyEDA).
- `pcb.json`: EasyEDA source file for the PCB layout.
- `gerber.zip`: Gerber files used to order / manufacture the PCB, when applicable.
  - Note: EasyEDA may include "`How-to-order-PCB`" or similar files in the Gerber archive. These may contain links to manufacturers, but are not endorsements.
- `media`: directory containing live pictures of the module implementation(s), and possibly short clips demonstrating its operation. Naming conventions for these files are as follows:
  - `breadboard.*`: prototype implementation on a solderless breadboard.
  - `pcb.*`: implementation on a printed circuit board (PCB). Unless stated otherwise, these boards are manufactured by JLCPCB.
  - `solderboard.*`: implementation on a perfboard, stripboard, soldered breadboard, or similar (components soldered directly to the board, but some or all traces are setup manually with wires and/or solder).
  - `*.jpg`: live picture (photo) of the implementation.

## Issues notation

During the project, different issues and challenges were spotted. In order to have some consistency, these have been grouping in a few categories:

  - **🤯 Fatal**: issues that prevent the module from working as intended, or at all. _Ex: incorrect wiring, missing components, etc._
  - **❌ Serious**: technically an error, but possible to work around during assembly and/or operation. _Ex: incorrect labeling on a PCB._
  - **⚠️ Minor**: not an error, but something that could be improved; or a detail that may lead to errors if overlooked. _Ex: non-ideal component values, suboptimal layout, ambiguous components, etc._
  - **💡 Info**: potential changes for slightly different use-cases, clarifications on choices, or highlights on issues in previous versions of the circuit that have already been addressed.