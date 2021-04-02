`timescale 1 ns / 100 ps
module tb ();

	//Inputs
	reg [21:0] angle;
	reg clk, clk_en, reset;

	//Output(s)
	wire [21:0] cos_out;
	wire done;
	
	//module testing
	cordic unit(
		.clk(clk),
		.clk_en(clk_en),
		.reset(reset), 
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
		
		#17
		clk_en = 1'b1;
		angle <= 22'b0010000000000000000000; //0.5
		#300
		clk_en = 1'b0;
		
		#40
		clk_en = 1'b1;
		angle <= 22'b0100000000000000000000;  //1
		#300
		clk_en = 1'b0;
		#80
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
