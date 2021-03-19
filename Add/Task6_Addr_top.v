module Task6_Addr_top (
	dataa,
	datab,
	result,
	clk);
	
	input clk;
	input [31:0]dataa;
	input [31:0]datab;
	output [31:0]result;
	
	wire [31:0]jeff;
	
	Task6_Addr bob(dataa[31:0], datab[31:0], jeff[31:0], clk);
	
	assign result[31:0] = jeff[31:0];
endmodule
	
