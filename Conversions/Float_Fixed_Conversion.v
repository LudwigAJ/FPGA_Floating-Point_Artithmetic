// single precision 32 bit (IEEE-754) to fixed point 22 bit. 
// 22-bit fixed point : 1 sign bit + 1 integer bit + 20 fractional bits.

module Float_Fixed_Conversion(
    data,
    result,
    enable,
    done,
    clk
    );

    input clk;
    input enable;
    input [31:0] data;
    output reg done;
    output reg [21:0] result;

    wire sign_float;
    wire [7:0] exp_float;
    wire [22:0] mant_float;

    reg sign_fixed;
    reg [20:0] fixed_val;
    reg [7:0] shifts;
    reg [23:0] full_mant;
	 
	 reg complete;

    assign {sign_float, exp_float, mant_float[22:0]} = data;

    always @ (posedge clk) begin
		  //if (complete) begin
		//		done = 1'b1;
		 // end
        if (enable) begin
            full_mant = {1'b1, mant_float};
            sign_fixed = sign_float;

            if (exp_float == 8'b0 || exp_float > 8'd127) begin
                result = 22'b0;
                done = 1'b1;
            end
            else begin
                shifts = 8'd127 - exp_float;
                full_mant = full_mant >> shifts;
                fixed_val[20:0] = full_mant[23:3];
                result = {sign_fixed, fixed_val[20:0]};
                done = 1'b1;
            end
        end
		  else begin
				done = 1'b0;
		  end
    end
endmodule
