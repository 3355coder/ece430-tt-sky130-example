<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

# Timed Traffic Light Controller

## How it works
This project is a hardware-implemented Traffic Light Finite State Machine (FSM). It cycles through three states (Green, Yellow, and Red) based on an internal 4-bit counter. 
- **Green Phase:** 5 clock cycles
- **Yellow Phase:** 2 clock cycles
- **Red Phase:** 4 clock cycles

The design handles the Tiny Tapeout active-low reset (`rst_n`) by inverting it internally to reset the FSM to the initial Green state. A `done` signal pulses high at the very end of the Red phase to signify a full cycle completion.

## How to test
1. Ensure the clock is running.
2. Pulse `rst_n` low to reset the system.
3. Observe `uo_out[0]` (Green) for 5 cycles.
4. Observe `uo_out[1]` (Yellow) for 2 cycles.
5. Observe `uo_out[2]` (Red) for 4 cycles.
6. `uo_out[3]` (Done) will pulse high on the final cycle of Red.

## External hardware
No external hardware is required for simulation. For physical testing, three LEDs (Green, Yellow, Red) can be connected to the first three output pins.

## Timeings
0-20ns: Reset active (rst_n=0). Outputs = 0.
20ns: rst_n goes high.
30ns (First posedge): uo_out[0] (Green) becomes 1.
80ns (After 5 cycles): uo_out[1] (Yellow) becomes 1.
100ns (After 2 cycles): uo_out[2] (Red) becomes 1.



