module Task6_Addr_top (
	dataa,
	datab,
	result,
	enable,
	done,
	clk);
	
	input clk;
	input [31:0]dataa;
	input [31:0]datab;
	output [31:0]result;
	input enable;
	output done;
	
	wire [31:0]jeff;
	wire completed;
	
	Task6_Addr bob(dataa[31:0], datab[31:0], jeff[31:0], enable, completed, clk);
	
	assign result[31:0] = jeff[31:0];
	assign done = completed;
endmodule
	
