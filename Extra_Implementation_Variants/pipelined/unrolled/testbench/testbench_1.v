`timescale 1 ns / 100 ps
module tb ();

	//Inputs to DUT are reg type
	reg [21:0] data;
	reg clk;
	reg enable;
	reg reset;
	

	//Output from DUT is wire type
	wire [21:0] result;
	
	wire [21:0] stage_1;
	wire [21:0] stage_2;
	wire [21:0] stage_3;
	wire [21:0] stage_4;
	wire [21:0] stage_5;
	wire [21:0] stage_6;
	wire [21:0] stage_7;
	wire [21:0] stage_8;
	wire [21:0] stage_9;
	wire [21:0] stage_10;
	wire [21:0] stage_11;
	wire [21:0] stage_12;
	wire [21:0] stage_13;
	wire [21:0] stage_14;
	wire [21:0] stage_15;
	wire [21:0] stage_16;
	wire [21:0] stage_17;
	
	//Instantiate the DUT
	//mul refers to the verilog module defined by the LPM_MULT ip
	Cordic_unrolled_two_pipeline unit(
    .clk(clk), 
    .enable(enable), 
    .reset(reset), 
    .angle_in(data),
    .cos_out(result), 
	 .stage_1(stage_1),
	 .stage_2(stage_2),
	 .stage_3(stage_3),
	 .stage_4(stage_4),
	 .stage_5(stage_5),
	 .stage_6(stage_6),
	 .stage_7(stage_7),
	 .stage_8(stage_8),
	 .stage_9(stage_9),
	 .stage_10(stage_10),
	 .stage_11(stage_11),
	 .stage_12(stage_12),
	 .stage_13(stage_13),
	 .stage_14(stage_14),
	 .stage_15(stage_15),
	 .stage_16(stage_16),
	 .stage_17(stage_17)
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
		 reset = 1'b0;
		// If using a clock
		
		@(posedge clk);
		
		#20
		
		enable <= 1'b1;
		
		data <= 22'b0010000000000000000000; // 1
		
		#20
		
		
		
		#20
		
	
		
		#20
		

		
		#20
		
		data <= 22'b0011110000000000000000;
		
		#20
		
		
		#20
		
		
		#20
		
		
		#20
		
		
		#20
		
		
		#20
		
		
		#20
		
		
		#20
		

		
		#20
		

		
		#20
		
		
		
		#20
		
		
		// Wait 10 cycles (corresponds to timescale at the top) 
		
		#1000
		
		$display($time, "<< Simulation Complete >>");
		$stop;
	end

endmodule