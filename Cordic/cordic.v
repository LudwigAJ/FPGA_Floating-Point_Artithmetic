module cordic(
    clk,
    reset, //active-high
    start, //high to begin calc
    angle,
    cos_out,
	 state
);

input clk, reset, start;
input [31:0] angle;
output [31:0] cos_out;
output state;

reg state, state_next;
reg [3:0] i, i_next;  //iterator
reg [31:0] e_i, x, y, z, x_next, y_next, z_next; //angle of iteration plus others...

wire [31:0] cos_out = x;

wire d = angle[31];
wire [31:0] x_shifted = x << i;
wire [31:0] y_shifted = y << i;

always @(i) begin //angle to be used in calc
    case(i)
        4'd0 : e_i <= 32'h3243f6a9;
        4'd1 : e_i <= 32'h1dac6705;
        4'd2 : e_i <= 32'h0fadbafd;
        4'd3 : e_i <= 32'h07f56ea7;
        4'd4 : e_i <= 32'h03feab77;
        4'd5 : e_i <= 32'h01ffd55c;
        4'd6 : e_i <= 32'h00fffaab;
        4'd7 : e_i <= 32'h007fff55;
        4'd8 : e_i <= 32'h003fffeb;
        4'd9 : e_i <= 32'h001ffffd;
        4'd10 : e_i <= 32'h00100000;
        4'd11 : e_i <= 32'h00080000;
        4'd12 : e_i <= 32'h00040000;
        4'd13 : e_i <= 32'h00020000;
        4'd14 : e_i <= 32'h00010000;
        4'd15 : e_i <= 32'h00008000;
    endcase
end

always@(posedge clk) begin
    if (reset | start) begin
        i <= 4'd0;
        x <= 32'h26dd3b6a;
        y <= 32'd0;
        z <= angle;
        state <= 1'b1;
    end
    else begin
        x <= x_next;
        y <= y_next;
        z <= z_next;
        state <= state_next;
    end
end

always @* begin
    x_next = x;
    y_next = y;
    z_next = z;
    i_next = i;
    state_next = state;
    if(state)begin
        x_next = x + (d ? y_shifted : -y_shifted);
        y_next = y + (d ? -x_shifted : x_shifted);
        z_next = z + (d ? e_i : -e_i);
        i_next = i + 1;

        if(i == 4'd15) begin
            state_next = 1'b0; 
        end
    end
end


endmodule


