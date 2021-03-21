module cordic_unrolled(
    clk,
    reset, //active-high
    start, //high at begg
    angle,
    cos_out,
	 done,
	 iteration
);

input clk, reset, start;
input [21:0] angle;
output [21:0] cos_out;
output done;
output [3:0] iteration;

reg state, state_next, done_reg, done_next;
reg [3:0] i, i_next;  //iterator
reg [21:0] e_i, x, y, z, x_next, y_next, z_next, x_shifted, y_shifted; //angle of iteration plus others...
reg d;
wire [21:0] cos_out;

assign iteration = i;
assign cos_out = x;
assign done = done_reg;

always@(posedge clk) begin
    if (start) begin   //initial values
        i <= 4'd0;
        x <= 22'b10011011011101001110;
        y <= 22'd0;
        z <= angle;
        state <= 1'b1;
		  done_reg <= 1'b0;
    end
	 else if (reset) begin
        i <= 4'd0;
        x <= 22'b10011011011101001110;
        y <= 22'd0;
		  z <= angle;
		  done_reg <= 1'b0;
	 end
    else begin        //updateing values
        x <= x_next;
        y <= y_next;
        z <= z_next;
		  i <= i_next;
        state <= state_next;
		  done_reg <= done_next;
    end
end

always @* begin
	x_next = x;
	y_next = y;
	z_next = z;
	i_next = i;
	state_next = state;
	done_next = done_reg;
    if(state)begin  //calculating section
        if(i_next == 4'd0) begin
            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b11001001000011111101;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+ 4'd1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b01110110101100011001;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+ 4'd1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00111110101101101110;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+ 4'd1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00011111110101011011;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+ 4'd1;
        end

        else if(i_next == 4'd4) begin
            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00001111111110101010;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000111111111110101;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000011111111111110;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000001111111111111;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;
        end

        else if(i_next == 4'd8) begin
            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000000111111111111;
            x_next = x + (d ? y_shifted : -y_shifted);
            y_next = y + (d ? -x_shifted : x_shifted);
            z_next = z + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000000011111111111;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000000010000000000;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000000001000000000;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;
        end

        else if(i_next == 4'd12) begin
            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000000000100000000;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000000000010000000;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000000000001000000;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            i_next = i_next+1;

            d = z_next[21];
            x_shifted = x_next >> i;
            y_shifted = y_next >> i;
            e_i = 22'b00000000000000100000;
            x_next = x_next + (d ? y_shifted : -y_shifted);
            y_next = y_next + (d ? -x_shifted : x_shifted);
            z_next = z_next + (d ? e_i : -e_i);
            
				state_next = 1'b0;
				done_next = 1'b1;
        end
    end
end


endmodule