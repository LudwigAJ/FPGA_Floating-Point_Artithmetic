`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [31:0] data;
	reg clk;
	//Output from DUT is wire type
	wire [31:0] result;
	
	wire [31:0] result1;
	wire [31:0] result2;
	wire [31:0] result3;
	wire [31:0] result4;
	wire [21:0] result5;
	wire [21:0] result6;
	wire [31:0] result7;
	wire [31:0] result8;

	//Instantiate the DUT
	//mul refers to the verilog module defined by the LPM_MULT ip
	Task7_Cordic_top unit(
		.clk(clk),
		.data(data), 
		.result(result),
		.result1(result1),
		.result2(result2),
		.result3(result3),
		.result4(result4),
		.result5(result5),
	   .result6(result6),
		.result7(result7),
		.result8(result8)
	);

	// ---- If a clock is required, see below ----
	// //Create a 50MHz clock
	always
			#10 clk = ~clk;
	// -----------------------

	//Initial Block
	initial
	begin
		$display($time, " << Starting Simulation >> ");
		
		// intialise/set input
		 clk = 1'b0;
		
		// If using a clock
		@(posedge clk); 
		
		// Wait 10 cycles (corresponds to timescale at the top) 
		#10
		
		// set dataa and datab
		data <= 32'b01000001001000000000000000000000;  // 10.0
		//datab <= 32'b0; 											// 0
		
		#1000
		
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
