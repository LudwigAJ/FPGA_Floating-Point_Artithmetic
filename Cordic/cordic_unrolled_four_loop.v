module cordic_unrolled_four_loop(
    clk,
	 clk_en,
    reset, //active-high
    angle,
    cos_out,
	 done
);

input clk, reset, clk_en;
input [21:0] angle;
output [21:0] cos_out;
output reg done;

reg state = 1'b0;
reg d;
reg [3:0] i;  //iterator
reg signed [21:0] e_i, x, y, z, x_shifted, y_shifted, cos_out; //angle of iteration plus others...

reg [7:0] counter = 0;

always @ (posedge clk) begin

    if (reset) begin
        i = 4'd0;
        x = 22'b10011011011101001110;
        y = 22'd0;
		  z = angle[20:0];
		  state = 1'b0;
	 end
    else if (clk_en && !state) begin   //initial values
        i = 4'd0;
        x = 22'b10011011011101001110;
        y = 22'd0;
        z = angle[20:0];
        state = 1'b1;
    end

    ////////////////////////////////////////////
    //             Ludwig magic               //
    ////////////////////////////////////////////

    else if (state) begin
		  counter = 8'b0;
        while (counter < 4) begin

            d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;

            case(i)
                4'd0 : e_i = 22'hC90FD;
                4'd1 : e_i = 22'h76B19;
                4'd2 : e_i = 22'h3EB6E;
                4'd3 : e_i = 22'h1FD5B;
                4'd4 : e_i = 22'h0FFAA;
                4'd5 : e_i = 22'h07FF5;
                4'd6 : e_i = 22'h03FFE;
                4'd7 : e_i = 22'h01FFF;
                4'd8 : e_i = 22'h00FFF;
                4'd9 : e_i = 22'h007FF;
                4'd10 : e_i = 22'h003FF;
                4'd11 : e_i = 22'h001FF;
                4'd12 : e_i = 22'h000FF;
                4'd13 : e_i = 22'h0007F;
                4'd14 : e_i = 22'h0003F;
                4'd15 : e_i = 22'h0001F;
            endcase

            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);

            i = i + 4'd1;

            if (i >= 15) begin
					state = 1'b0;
					done = 1'b1;
					cos_out = x;
            end
            counter = counter + 8'b1;
        end
	 end
    ////////////////////////////////////////////
	 else begin
		done = 1'b0;
	 end
end

endmodule
