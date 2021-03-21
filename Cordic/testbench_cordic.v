`timescale 1 ns / 100 ps
module tb ();

	//Inputs
	reg [21:0] angle;
	reg clk, reset, start;

	//Output(s)
	wire [21:0] cos_out;
	wire done;
	
	//module testing
	cordic_unrolled_four unit(
		.clk(clk),
		.reset(reset), 
		.start(start),
		.angle(angle),
		.cos_out(cos_out),
		.done(done)
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
		angle <= 22'h80000; //0.5
		#2
		start = 1'b0;
		#797
		
		start = 1'b1;
		angle <= 32'h100000;  //-1
		#4
		start = 1'b0;
		#800
//		
//		start = 1'b1;
//		angle <= 32'h60000000;  //1
//		#2
//		start = 1'b0;
//		#18
//		
//		start = 1'b1;
//		angle <= 32'h00000000;  //0
//		#2
//		start = 1'b0;
//		#18
			
		$stop; //end of sim
	end

endmodule
