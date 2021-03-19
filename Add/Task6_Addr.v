// IEEE - 754 standard single point precision
// | 31 | 30 29 28 27 26 25 24 23 | 22 21 20 19 18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0 |
// |sign|        exponent         |                         Mantissa                           |

module Task6_Addr(
	dataa,
	datab,
	result,
	clk);
	
	input clk;
	input [31:0] dataa, datab;
	output reg [31:0] result;
	
	// Split up into regs so that we can retrieve sign, exp, & mantissa.
	
	wire sign_a;
	wire sign_b;
	reg sign_sum, sign_big, sign_small;
	
	wire [7:0] exp_a;
	wire [7:0] exp_b;
	reg [7:0] exp_sum, exp_big;
	reg [7:0] exp_diff;
	
	wire [22:0] mant_a; // 24th bit is implicit at first.
	wire [22:0] mant_b; // 24th bit is implicit at first.
	reg [22:0] mant_sum, mant_big, mant_small;
	
	reg [23:0] tmp_mant_big, tmp_mant_small;
	reg [24:0] tmp_mant_sum;
	reg [23:0] tmp_mant_done;
	
	reg [4:0] counter;
	

	// Split the different parts up for ease of use.

	assign {sign_a, exp_a, mant_a} = dataa[31:0];
	assign {sign_b, exp_b, mant_b} = datab[31:0];
	
	
	always @ (posedge clk) begin
	
		if ({exp_a, mant_a} == 31'b0 && {exp_b, mant_b} == 31'b0) begin
			result <= 32'b0;
		end
		else if ({exp_a, mant_a} == 31'b0 && {exp_b, mant_b} != 31'b0) begin
			result <= datab;
		end
		else if ({exp_a, mant_a} != 31'b0 && {exp_b, mant_b} == 31'b0) begin
			result <= dataa;
		end
		else begin
			if (exp_a > exp_b) begin
				exp_big = exp_a;
				sign_big = sign_a;
				sign_small = sign_b;
				mant_big = mant_a;
				mant_small = mant_b;
				exp_diff = exp_a - exp_b;
			end
			else if (exp_a == exp_b) begin
				if (mant_a > mant_b) begin
					exp_big = exp_a;
					sign_big = sign_a;
					sign_small = sign_b;
					mant_big = mant_a;
					mant_small = mant_b;
					exp_diff = exp_a - exp_b;
				end
				else begin
					exp_big = exp_b;
					sign_big = sign_b;
					sign_small = sign_a;
					mant_big = mant_b;
					mant_small = mant_a;
					exp_diff = exp_b - exp_a;
				end
			end
			else begin
				exp_big = exp_b;
				sign_big = sign_b;
				sign_small = sign_a;
				mant_big = mant_b;
				mant_small = mant_a;
				exp_diff = exp_b - exp_a;
			end
			
			tmp_mant_big = {1'b1, mant_big};
			tmp_mant_small = {1'b1, mant_small} >> exp_diff;
			
			if (sign_big == sign_small) begin
				tmp_mant_sum = tmp_mant_big + tmp_mant_small;
			end
			else if (sign_big != sign_small) begin
				tmp_mant_sum = tmp_mant_big - tmp_mant_small;
			end
			
			
			//if (tmp_mant_sum[23] && ~tmp_mant_sum[24] && sign_big != sign_small) begin
			//	tmp_mant_done = ~tmp_mant_sum[23:0] + 1'b1;
			//end
			//else begin
			tmp_mant_done = tmp_mant_sum[23:0];
			//end
			
			if (sign_big == sign_small && tmp_mant_sum[24]) begin
				counter = 5'b0;
				tmp_mant_done = tmp_mant_done >> 1;
				tmp_mant_done[23] = 1'b1;
				// Also remember to add one to exponent here. Forgot before. Do same in Sub :)
			end
			else begin
				counter = 5'b0;
				while (~tmp_mant_done[23] && counter < 5'd24) begin
					tmp_mant_done = tmp_mant_done << 1;
					counter = counter + 1'b1;
				end
			end
			
			if (counter >= 5'd24) begin
				exp_sum = 8'b0;
				sign_sum = sign_big;
			end
			else begin
				exp_sum = exp_big - counter;
				sign_sum = sign_big;
			end
			
			result = {sign_sum, exp_sum, tmp_mant_done[22:0]};
			
		end
	end
	
endmodule
	
