module cordic_unrolled(
    clk,
	 clk_en,
    reset, //active-high
    angle,
    cos_out,
	 done
);

input clk, clk_en, reset;
input [21:0] angle;
output [21:0] cos_out;
output reg done;

reg state = 1'b0;
reg [3:0] i;  //iterator
reg signed [21:0] e_i, x, y, z, x_shifted, y_shifted, cos_out; //angle of iteration plus others...
reg d;

always@(posedge clk) begin
    if (clk_en) begin   //initial values
        i = 4'd0;
        x = 22'b10011011011101001110;
        y = 22'd0;
        z = angle;
		
        //0 iteration
        
        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'hC90FD;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
		  
        //1 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h76B19;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //2 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h3EB6E;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //3 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h1FD5B;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
	 
        //4 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h0FFAA;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //5 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h07FF5;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //6 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h03FFE;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //7 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h01FFF;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //8 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h00FFF;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //9 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h007FF;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //10 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h003FF;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //11 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h001FF;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //12 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h000FF;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //13 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h0007F;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //14 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h0003F;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //15 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'h0001F;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
		  
		  cos_out = x;
		  done = 1'b1;
	 end
	 else if (reset) begin
        i <= 4'd0;
        x <= 22'b10011011011101001110;
        y <= 22'd0;
		  z <= angle;
	 end
	 else begin
		done = 1'b0;
	end
end

endmodule