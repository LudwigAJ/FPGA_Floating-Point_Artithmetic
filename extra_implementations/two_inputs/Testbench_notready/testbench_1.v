`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [31:0] data;
	reg clk;
	
	reg start;
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
	
	wire enable1;
	wire enable2;
	wire enable3;
	wire enable4;
	wire enable5;
	wire enable6;
	wire enable7;
	wire enable8;
	wire enable9;

	//Instantiate the DUT
	//mul refers to the verilog module defined by the LPM_MULT ip
	Task7_Cordic_top unit(
		.clk(clk),
		.data(data),
		.start(start),
		.result(result),
		.result1(result1),
		.result2(result2),
		.result3(result3),
		.result4(result4),
		.result5(result5),
	   .result6(result6),
		.result7(result7),
		.result8(result8),
		.enable1(enable1),
	   .enable2(enable2),
	   .enable3(enable3),
	   .enable4(enable4),
	   .enable5(enable5),
	   .enable6(enable6),
	   .enable7(enable7),
	   .enable8(enable8),
	   .enable9(enable9)
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
	
		data <= 32'b01000011011111110000000000000000;  // 10.0
		
		#20
		
		start <= 1'b1;
		
		#20
		
		start <= 1'b0;
		
		// Wait 10 cycles (corresponds to timescale at the top) 
		
		// set dataa and datab
		
		//datab <= 32'b0; 											// 0
		
		#1000
		
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule
