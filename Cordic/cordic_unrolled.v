module cordic_unrolled(
    clk,
    reset, //active-high
	 start, //high at begg
    angle,
    cos_out
);

input clk, reset, start;
input [21:0] angle;
output [21:0] cos_out;

reg [3:0] i;  //iterator
reg signed [21:0] e_i, x, y, z, x_shifted, y_shifted, cos_out; //angle of iteration plus others...
reg d;

wire [3:0] iteration;



always@(posedge clk) begin
    if (start) begin   //initial values
        i = 4'd0;
        x = 22'b10011011011101001110;
        y = 22'd0;
        z = angle;
		
        //0 iteration
        
        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b11001001000011111101;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
		  
        //1 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b01110110101100011001;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //2 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00111110101101101110;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //3 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00011111110101011011;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
	 
        //4 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00001111111110101010;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //5 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000111111111110101;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //6 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000011111111111110;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //7 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000001111111111111;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //8 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000000111111111111;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //9 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000000011111111111;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //10 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000000010000000000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //11 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000000001000000000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //12 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000000000100000000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //13 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000000000010000000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //14 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000000000001000000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //15 iteration

        d = z[21];
        y_shifted = y >>> i;
        x_shifted = x >>> i;
        e_i = 22'b00000000000000100000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
		  
		  cos_out <= x;
	 end
	 else if (reset) begin
        i <= 4'd0;
        x <= 22'b10011011011101001110;
        y <= 22'd0;
		  z <= angle;
	 end
end

endmodule