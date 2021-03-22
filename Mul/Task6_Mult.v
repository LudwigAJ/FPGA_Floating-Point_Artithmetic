module Task6_Mult(
	dataa,
	datab,
	result,
	enable,
	done,
	clk);
	
	input enable;
	input clk;
	input [31:0] dataa, datab;
	output reg done;
	output reg [31:0] result;
	
	wire sign_a;
	wire sign_b;
	
	wire [7:0] exp_a;
	wire [7:0] exp_b;
	
	wire [22:0] mant_a; 
	wire [22:0] mant_b;
	
	reg sign_sum;
	reg [7:0] exp_sum;
	reg [23:0] tmp_mant_a;
	reg [23:0] tmp_mant_b;
	reg [47:0] tmp_mant_sum;
	reg [22:0] mant_sum;
	
	assign {sign_a, exp_a, mant_a} = dataa[31:0];
	assign {sign_b, exp_b, mant_b} = datab[31:0];
	
	//reg [7:0] counter;
	
	
	always @ (posedge clk) begin
		if (enable) begin
			if ({exp_a, mant_a} == 30'b0 || {exp_b, mant_b} == 30'b0) begin
				result <= 32'b0;
				done <= 1'b1;
			end
			else begin
				
				sign_sum = sign_a ^ sign_b;
				exp_sum = exp_a + exp_b - 8'd127;
				
				tmp_mant_a = {1'b1, mant_a[22:0]};
				tmp_mant_b = {1'b1, mant_b[22:0]};
				
				tmp_mant_sum = tmp_mant_a * tmp_mant_b; // omg this expression is gonna cost a lot lol.
				
				
				if (tmp_mant_sum[47]) begin
					tmp_mant_sum = tmp_mant_sum >> 1'b1;
					exp_sum = exp_sum + 1'b1;
				end
				
				mant_sum = tmp_mant_sum[45:23];
				
				result = {sign_sum, exp_sum, mant_sum};
				done <= 1'b1;
			end
		end
	end
endmodule
