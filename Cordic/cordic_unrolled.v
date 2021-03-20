module cordic_unrolled(
    clk,
    reset, //active-high
	 start, //high at begg
    angle,
    cos_out,
);

input clk, reset, start;
input [31:0] angle;
output [31:0] cos_out;

reg [3:0] i;  //iterator
reg [31:0] e_i, x, y, z, x_shifted, y_shifted; //angle of iteration plus others...
reg d;

wire [31:0] cos_out;
wire [3:0] iteration;

assign cos_out = x;

always@(posedge clk) begin
    if (start) begin   //initial values
        i = 4'd0;
        x = 32'h26dd3b6a;
        y = 32'd0;
        z = angle;
		
        //0 iteration
        
        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h3243f6a9;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
		  
        //1 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h1dac6705;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //2 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h0fadbafd;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //3 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h07f56ea7;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
	 
        //4 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h03feab77;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //5 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h01ffd55c;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //6 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h00fffaab;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //7 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h007fff55;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //8 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h003fffeb;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //9 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h001ffffd;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //10 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h00100000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //11 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h00080000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //12 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h00040000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //13 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h00020000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //14 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h00010000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;

        //15 iteration

        d = z[31];
        y_shifted = y >> i;
        x_shifted = x >> i;
        e_i = 32'h00008000;
        x = x + (d ? y_shifted : -y_shifted);
        y = y + (d ? -x_shifted : x_shifted);
        z = z + (d ? e_i : -e_i);
        i = i + 4'd1;
	 end
	 else if (reset) begin
        i <= 4'd0;
        x <= 32'h26dd3b6a;
        y <= 32'd0;
		  z <= angle;
	 end
end

endmodule