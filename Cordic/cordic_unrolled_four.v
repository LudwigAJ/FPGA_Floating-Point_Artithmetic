module cordic_unrolled_four(
    clk,
    reset, //active-high
    start, //high at begg
    angle,
    cos_out,
	 done
);

input clk, reset, start;
input [21:0] angle;
output [21:0] cos_out;
output reg done;

reg state, done_reg, d;
reg [3:0] i;  //iterator
reg signed [21:0] e_i, x, y, z, x_shifted, y_shifted, cos_out; //angle of iteration plus others...

always@(posedge clk) begin
    if (start) begin   //initial values
        i = 4'd0;
		  x = 22'b10011011011101001110;
		  y = 22'd0;
        z = angle;
        state = 1'b1;
		  done = 1'b0;
    end
	 else if (reset) begin
        i = 4'd0;
        x = 22'b10011011011101001110;
        y = 22'd0;
		  z = angle;
		  done = 1'b0;
	 end
    if (state == 1'b1) begin        //updateing values
        if(i == 4'd0) begin
            d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b11001001000011111101;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b01110110101100011001;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00111110101101101110;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00011111110101011011;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
        end
		  
		  else if(i == 4'd4) begin
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00001111111110101010;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000111111111110101;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >> i;
            y_shifted = y >> i;
            e_i = 22'b00000011111111111110;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000001111111111111;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
        end
		  
		  else if(i == 4'd8) begin
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000000111111111111;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;

				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000000011111111111;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000000010000000000;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000000001000000000;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
		  end
		  
		  else if(i == 4'd12) begin
		  
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000000000100000000;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000000000010000000;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000000000001000000;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'b00000000000000100000;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            
				state = 1'b0;
				done = 1'b1;
				cos_out <= x;
        end
		  
		  
    end
end


endmodule