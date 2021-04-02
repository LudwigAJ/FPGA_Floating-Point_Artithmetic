## Hardware Acceleration using FPGA for Floating-Point Arithmetic
### Full design implemented on FPGA also included use of SDRAM, NIOS II/f soft processor, JTAG, as well as some other miscellaneous components.
### Design was implemented using Quartus II.
***

### 32-bit Addition, Subtraction, and Multiplication using IEEE-754 Floating-Point standard.
##### Note that it does not implement handling of +inf and -inf values.
***

### CORDIC Algorithm implemented in Verilog for use with 22-bit fixed-point (1 sign bit, 1 integer bit, followed by 20 fractional bits. Can be changed to be done in 16 to 1 iterations by modifying loop condition.
***

##### Note that less iterations might require slower clock or better FPGA.
### Conversions between 32-bit Floating-Point and 22-bit fixed-point included with custom made files made in Verilog.
##### Note that converting Floating-Point to Fixed-Point and vice versa incurs precision loss.
***

### All custom made Verilog modules could complete execution in 1 clock cycle using an Intel Altera Cyclone V 5CSEMA5F31C6N FPGA clocked @ 50 Mhz.
##### Note that the CORDIC module was discovered to only be able to complete execution in 4 clock cycles or more in order to not violate timing on the FPGA.
***

![alt text](https://github.com/LudwigAJ/FPGA-FloatingPointArtithmetic/blob/main/Gallery/DE1-Board.png "The Board")

#### Top file in main folder calculates 0.5 * X + X^2 * cos((X - 128) / 128) as a test of the overall function.

![alt text](https://github.com/LudwigAJ/FPGA-FloatingPointArtithmetic/blob/main/Gallery/whole_function_cordic_unrolled_four_loop_fixed.png "ModelSim of top file")

#### Gallery contains ModelSim screenshots of the different Verilog modules.

### In Extra_Implementations folder there can be found additional special implementations of CORDIC as well as the regular top file. e.g. Pipelined CORDIC and multi-input modules.

![alt text](https://github.com/LudwigAJ/FPGA-FloatingPointArtithmetic/blob/main/Gallery/2_cordic_rolled_pipeline_full.png "16-iteration Pipelined CORDIC")
