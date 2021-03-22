// Fixed point 22 bit to single precision 32 bit (IEEE-754)
// 22-bit fixed point : 1 sign bit + 1 integer bit + 20 fractional bits.

module Fixed_Float_Conversion(
    data,
    result,
    enable,
    done,
    clk
    );

    input clk;
    input enable;
    input [21:0] data;
    output reg done;
    output reg [31:0] result;

    wire sign_fixed;
    wire [20:0] fixed_val;

    reg sign_float;
    reg [7:0] exp_float;
    reg [23:0] mant_float;
    reg [4:0] counter;

    assign {sign_fixed, fixed_val[20:0]} = data;

    always @ (posedge clk) begin
        if (enable) begin
            if (fixed_val == 21'd0) begin
                result = 32'b0;
                done <= 1'b1;
            end
            else begin
                sign_float = sign_fixed;
                exp_float = 8'd127; // i.e. set to 0 + bias = 127.
                mant_float[23:3] = fixed_val[20:0];
                mant_float[2:0] = 3'b0;

                counter = 5'b0;

                while (~mant_float[23] && counter < 5'd21) begin
                    mant_float = mant_float << 1'b1;
                    counter = counter + 1'b1;
                end
                exp_float = exp_float - counter;
                result = {sign_float, exp_float, mant_float[22:0]};
                done <= 1'b1;
            end
        end
    end

endmodule
