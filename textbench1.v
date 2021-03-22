`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [31:0] data;
	reg clk;
	//Output from DUT is wire type
	wire [31:0] result;

	//Instantiate the DUT
	//mul refers to the verilog module defined by the LPM_MULT ip
	Task7_Cordic_top unit(
		.clk(clk),
		.data(data), 
		.result(result)
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