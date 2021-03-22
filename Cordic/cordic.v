module cordic(
    clk,
    reset, //active-high //high at begg
    angle,
    cos_out,
	 done
);

input clk, reset;
input [21:0] angle;
output [21:0] cos_out;
output done;

reg state, state_next, done_reg, done_next;
reg [3:0] i, i_next;  //iterator
reg [21:0] e_i, x, y, z, x_next, y_next, z_next; //angle of iteration plus others...

wire [21:0] cos_out, x_shifted, y_shifted;
wire d, done;

reg start;
initial start = 1'b1;


assign cos_out = x;
assign d = z[21];
assign x_shifted = x >> i;
assign y_shifted = y >> i;
assign done = done_reg;

always @(i) begin //angle to be used in calc
    case(i)
        4'd0 : e_i <= 22'b11001001000011111101;
        4'd1 : e_i <= 22'b01110110101100011001;
        4'd2 : e_i <= 22'b00111110101101101110;
        4'd3 : e_i <= 22'b00011111110101011011;
        4'd4 : e_i <= 22'b00001111111110101010;
        4'd5 : e_i <= 22'b00000111111111110101;
        4'd6 : e_i <= 22'b00000011111111111110;
        4'd7 : e_i <= 22'b00000001111111111111;
        4'd8 : e_i <= 22'b00000000111111111111;
        4'd9 : e_i <= 22'b00000000011111111111;
        4'd10 : e_i <= 22'b00000000010000000000;
        4'd11 : e_i <= 22'b00000000001000000000;
        4'd12 : e_i <= 22'b00000000000100000000;
        4'd13 : e_i <= 22'b00000000000010000000;
        4'd14 : e_i <= 22'b00000000000001000000;
        4'd15 : e_i <= 22'b00000000000000100000;
    endcase
end

always@(posedge clk) begin
    if (start) begin   //initial values
        i <= 4'd0;
        x <= 22'b10011011011101001110;
        y <= 22'd0;
        z <= angle;
        state <= 1'b1;
		  done_reg <= 1'b0;
		  start <= 1'b0;
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
        x_next = x + (d ? y_shifted : -y_shifted);
        y_next = y + (d ? -x_shifted : x_shifted);
        z_next = z + (d ? e_i : -e_i);
        i_next = i + 1;
        if(i == 4'd15) begin   //done 16 iterations
				done_next = 1'b1;
            state_next = 1'b0; 
        end
    end
end


endmodule


