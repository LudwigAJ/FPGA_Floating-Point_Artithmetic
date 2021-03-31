`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [31:0] dataa;
	reg [31:0] datab;
	reg clk;
	
	reg start;
	//Output from DUT is wire type
	wire [31:0] result;
	
	wire [31:0] result_dataa;
	wire [31:0] result_datab;

	
	wire enable_dataa;
	wire enable_datab;
	wire enable_add;

	//Instantiate the DUT
	//mul refers to the verilog module defined by the LPM_MULT ip
	Task7_Cordic_top unit(
		.clk(clk),
		.dataa(dataa),
		.datab(datab),
		.result(result),
		.start(start),
		// for the testbench //
		.test_result_dataa(result_dataa),
		.test_result_datab(result_datab),
		.test_enable_dataa(enable_dataa),
		.test_enable_datab(enable_datab),
		.test_enable_add(enable_add)
		// for the testbench - end //
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
	
		dataa <= 32'b01000011011111110000000000000000;  // 255.0
		datab <= 32'b01000011000000000000000000000000; // 128.0
		
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
