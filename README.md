# Pocket-Calculator
This project implements a simple pocket calculator capable of performing the four fundamental arithmetic operations: addition, subtraction, multiplication, and division. The calculator is designed to work with 8-bit signed operands and is implemented on an FPGA board, using 7-segment displays to show the results.

Project Description
The goal of this project is to design and implement a digital calculator that performs:Addition, Subtraction, Multiplication, Division

The multiplication and division operations are implemented using specific arithmetic algorithms rather than the built-in operators of the language. Operands and operators are entered sequentially in decimal format, and results are displayed on the FPGA’s 7-segment display modules.

This project demonstrates the use of digital logic design, arithmetic algorithms, and FPGA programming to create a functional embedded system component.

Technologies and Tools
VHDL / Verilog (HDL for FPGA programming)
Xilinx Vivado / Quartus Prime (for synthesis and simulation)
FPGA development board (e.g., Basys 3 or similar)

Features
Supports signed 8-bit operands
Sequential input of operands and operator
Result displayed on 7-segment displays
Hardware-level implementation of multiplication and division algorithms
Error handling (division by zero)

Future Improvements
Add support for negative result display
Extend to multi-digit input
