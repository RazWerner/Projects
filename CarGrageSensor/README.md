# Car Garage Sensor
This project simulates a car garage sensor system using a Basys 3 FPGA board and was developed in Vivado 2024.2. It uses two buttons to simulate vehicle entry and exit sensors, with LEDs for vehicle guidance and a 7-segment display to show the current car count.

## Set Up the Vivado Project

Open Vivado 2024.2 and create a new RTL Project (do not add IP at this stage).

Add the source files from the Sources/ folder.

Add the constraints file from the Constraints/ folder.

## Configure the Project

Set the correct top-level module in the sources hierarchy.

Ensure the constraints are correctly applied to match your board's I/O.
## Generate the Bitstream and Test

Synthesize, implement, and generate the bitstream.

Program your Basys 3 board with the generated bitstream.

Use the push buttons to simulate car entry and exit.

Verify that the 7-segment display and LEDs behave as expected.
