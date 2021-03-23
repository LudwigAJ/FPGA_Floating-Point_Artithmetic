module cordic_unrolled_four(
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

always@(posedge clk) begin
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
    else if (state) begin        //updateing values
        if(i == 4'd0) begin
            d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'hC90FD;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h76B19;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h3EB6E;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h1FD5B;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
        end
		  
		  else if(i == 4'd4) begin
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h0FFAA;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h07FF5;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >> i;
            y_shifted = y >> i;
            e_i = 22'h03FFE;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h01FFF;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
        end
		  
		  else if(i == 4'd8) begin
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h00FFF;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;

				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h007FF;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h003FF;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h001FF;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
		  end
		  
		  else if(i == 4'd12) begin
		  
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h000FF;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h0007F;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h0003F;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            i = i + 4'd1;
				
				d = z[21];
            x_shifted = x >>> i;
            y_shifted = y >>> i;
            e_i = 22'h0001F;
            x = x + (d ? y_shifted : -y_shifted);
            y = y + (d ? -x_shifted : x_shifted);
            z = z + (d ? e_i : -e_i);
            
				state = 1'b0;
				done = 1'b1;
				cos_out <= x;
        end
		  
    end
	 else begin
		done = 1'b0;
	end
end


endmodule