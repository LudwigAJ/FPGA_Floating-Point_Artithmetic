`timescale 1 ns / 100 ps
module tb ();

	//Inputs
	reg [31:0] angle;
	reg clk, reset, start;

	//Output(s)
	wire [31:0] cos_out;
	wire state;

	//module testing
	cordic unit(
		.clk(clk),
		.reset(reset), 
		.start(start),
		.angle(angle),
		.cos_out(cos_out),
		.state(state)
	);


	//Create a 50MHz clock
	always
		#10 clk = ~clk;

	//main testing
	initial
	begin
	
		$display($time, "4 << Starting Simulation >> ");
	
		clk = 1'b1;
		reset = 1'b0;
		
		@(posedge clk);
		
		#19
		start = 1'b1;
		angle <= 32'h20000000;
		#5
		start = 1'b0;
		#800
			
		$stop; //end of sim
	end

endmodule
