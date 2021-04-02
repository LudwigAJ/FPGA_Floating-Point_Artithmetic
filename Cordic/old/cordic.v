module cordic(
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
reg state_next = 1'b0;
reg [3:0] i, i_next;  //iterator
reg signed [21:0] e_i, x, z, y, x_next, y_next, z_next, cos_out; //angle of iteration plus others...

wire signed [21:0] x_shifted, y_shifted;
wire d;

assign d = z[21];
assign x_shifted = x >>> i;
assign y_shifted = y >>> i;

always @(i) begin //angle to be used in calc
    case(i)
        4'd0 : e_i <= 22'hC90FD;
        4'd1 : e_i <= 22'h76B19;
        4'd2 : e_i <= 22'h3EB6E;
        4'd3 : e_i <= 22'h1FD5B;
        4'd4 : e_i <= 22'h0FFAA;
        4'd5 : e_i <= 22'h07FF5;
        4'd6 : e_i <= 22'h03FFE;
        4'd7 : e_i <= 22'h01FFF;
        4'd8 : e_i <= 22'h00FFF;
        4'd9 : e_i <= 22'h007FF;
        4'd10 : e_i <= 22'h003FF;
        4'd11 : e_i <= 22'h001FF;
        4'd12 : e_i <= 22'h000FF;
        4'd13 : e_i <= 22'h0007F;
        4'd14 : e_i <= 22'h0003F;
        4'd15 : e_i <= 22'h0001F;
    endcase
end

always@(posedge clk) begin
	 if (reset) begin
        i <= 4'd0;
        x <= 22'b10011011011101001110;
        y <= 22'd0;
		  z <= angle[20:0];
		  state <= 1'b0;
	 end
	 else if (clk_en && !state) begin   //initial values
        i <= 4'd0;
        x <= 22'b10011011011101001110;
        y <= 22'd0;
        z <= angle[20:0];
        state <= 1'b1;
    end
    else begin        //updateing values
        x <= x_next;
        y <= y_next;
        z <= z_next;
		  i <= i_next;
        state <= state_next;
    end
end

always @* begin
	 x_next = x;
	 y_next = y;
	 z_next = z;
	 i_next = i;
	 state_next = state;
    if(state)begin  //calculating section
        x_next = x + (d ? y_shifted : -y_shifted);
        y_next = y + (d ? -x_shifted : x_shifted);
        z_next = z + (d ? e_i : -e_i);
        i_next = i + 1;
        if(i == 4'd15) begin   //done 16 iterations
				done = 1'b1;
            state_next = 1'b0;
				cos_out <= x_next;
        end
    end
	 else begin
		done <= 1'b0;
	 end
end


endmodule



