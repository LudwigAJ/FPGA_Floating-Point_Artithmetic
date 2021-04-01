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
output reg [21:0] cos_out;
output reg done;

reg state = 1'b0;
reg d;
reg [4:0] i;  //iterator
reg signed [21:0] e_i; //Amount to rotate by
reg signed [21:0] x, y, z; // different values of cos,sin,angle for each iteration.
reg signed [21:0] x_shifted, y_shifted; //shifted values
//reg signed [21:0] cos_out; //the output at the end

reg [7:0] counter;

    always @ (posedge clk) begin

        if (reset) begin // if the reset is asserted.
            i = 5'd0;
            x = 22'b10011011011101001110;
            y = 22'd0;
            z = angle[20:0];
            state = 1'b0;
        end
        else if (clk_en && !state) begin   //initial values. consumes 1 clk cycle.
            i = 5'd0;
            x = 22'b10011011011101001110;
            y = 22'd0;
            z = angle[20:0];
            state = 1'b1;
            done = 1'b0;
        end

        ////////////////////////////////////////////
        //             Ludwig magic               //
        ////////////////////////////////////////////

        else if (state) begin
            if (i >= 16) begin // we are now done.
                cos_out = x; // this is the output.
                done = 1'b1; // done signal.
                state = 1'b0; // set state to 0 so we dont repeat ops.
            end
            else begin
                counter = 8'd0; // init a counter to 0 to keep track of iters.
                done = 1'b0;
                while (counter < 4 && i < 16) begin // i.e. 16 iterations.

                    d = z[21]; // check if pos/neg value of angle.
                    x_shifted = x >>> i; // multiply (signed) by 2^i.
                    y_shifted = y >>> i; // multiply (signed) by 2^i.

                    case(i) // find the correct current angle value.
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
						  
					if (d) begin
                        x = x + y_shifted;
                        y = y - x_shifted;
                        z = z + e_i;
					end
					else begin
                        x = x - y_shifted;
                        y = y + x_shifted;
                        z = z - e_i;
				    end

                    //x = x + (d ? y_shifted : -y_shifted); // shift x by y-shifted.
                    //y = y + (d ? -x_shifted : x_shifted); // shift y by x-shifted.
                    //z = z + (d ? e_i : -e_i); // determine if pos/neg angle now.
                    i = i + 1'b1; //increment step  

                    counter = counter + 1'b1;
                end
            end
        end
        else begin
            done = 1'b0;
        end
    end
endmodule
