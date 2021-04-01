module Cordic_unrolled_two_pipeline(
    clk, // our clock signal
    enable, // enable our whole chip to start
    reset, // active high
    angle_in, // input
    cos_out, // output
    // for the testbench //
	 stage_1,
	 stage_2,
	 stage_3,
	 stage_4,
	 stage_5,
	 stage_6,
	 stage_7,
	 stage_8,
	 stage_9,
	 stage_10,
	 stage_11,
	 stage_12,
	 stage_13,
	 stage_14,
	 stage_15,
	 stage_16,
	 stage_17
	 // for the testbench - end //
    );

    input clk, enable, reset;

    input [21:0] angle_in;
    output reg signed [21:0] cos_out;

    // for the testbench //
	 output [21:0] stage_1, stage_2, stage_3, stage_4, stage_5, stage_6, stage_7, stage_8, stage_9, stage_10;
	 output [21:0] stage_11, stage_12, stage_13, stage_14, stage_15, stage_16, stage_17;
	 // for the testbench - end //

    integer a, b, c, d, e, f, g, h;

    reg signed [21:0] x_stage_1, y_stage_1, z_stage_1;

    reg signed [21:0] x_stage_2, x_stage_3, x_stage_4, x_stage_5, x_stage_6, x_stage_7, x_stage_8; 
    reg signed [21:0] x_stage_9, x_stage_10, x_stage_11, x_stage_12, x_stage_13, x_stage_14, x_stage_15, x_stage_16, x_stage_17;

    reg signed [21:0] y_stage_2, y_stage_3, y_stage_4, y_stage_5, y_stage_6, y_stage_7, y_stage_8; 
    reg signed [21:0] y_stage_9, y_stage_10, y_stage_11, y_stage_12, y_stage_13, y_stage_14, y_stage_15, y_stage_16, y_stage_17;

    reg signed [21:0] z_stage_2, z_stage_3, z_stage_4, z_stage_5, z_stage_6, z_stage_7, z_stage_8; 
    reg signed [21:0] z_stage_9, z_stage_10, z_stage_11, z_stage_12, z_stage_13, z_stage_14, z_stage_15, z_stage_16, z_stage_17;

    // d_1, d_2, ... are the MSB (or the sign-bit) of each z_stage.
    wire d_1, d_2, d_3, d_4, d_5, d_6, d_7, d_8, d_9, d_10, d_11, d_12, d_13, d_14, d_15, d_16;

    // here was have some wire corresponding to arithmetic right shifts of resp. stage.
    wire [21:0] x_shifted_1, x_shifted_2, x_shifted_3, x_shifted_4, x_shifted_5, x_shifted_6, x_shifted_7, x_shifted_8;
    wire [21:0] x_shifted_9, x_shifted_10, x_shifted_11, x_shifted_12, x_shifted_13, x_shifted_14, x_shifted_15, x_shifted_16;

    wire [21:0] y_shifted_1, y_shifted_2, y_shifted_3, y_shifted_4, y_shifted_5, y_shifted_6, y_shifted_7, y_shifted_8;
    wire [21:0] y_shifted_9, y_shifted_10, y_shifted_11, y_shifted_12, y_shifted_13, y_shifted_14, y_shifted_15, y_shifted_16;

    // assign the values for the shift wires.
    assign x_shifted_1 = x_stage_1 >>> 1;
    assign y_shifted_1 = y_stage_1 >>> 1;

    assign x_shifted_2 = x_stage_2 >>> 2;
    assign y_shifted_2 = y_stage_2 >>> 2;

    assign x_shifted_3 = x_stage_3 >>> 3;
    assign y_shifted_3 = y_stage_3 >>> 3;

    assign x_shifted_4 = x_stage_4 >>> 4;
    assign y_shifted_4 = y_stage_4 >>> 4;

    assign x_shifted_5 = x_stage_5 >>> 5;
    assign y_shifted_5 = y_stage_5 >>> 5;

    assign x_shifted_6 = x_stage_6 >>> 6;
    assign y_shifted_6 = y_stage_6 >>> 6;

    assign x_shifted_7 = x_stage_7 >>> 7;
    assign y_shifted_7 = y_stage_7 >>> 7;

    assign x_shifted_8 = x_stage_8 >>> 8;
    assign y_shifted_8 = y_stage_8 >>> 8;

    assign x_shifted_9 = x_stage_9 >>> 9;
    assign y_shifted_9 = y_stage_9 >>> 9;

    assign x_shifted_10 = x_stage_10 >>> 10;
    assign y_shifted_10 = y_stage_10 >>> 10;

    assign x_shifted_11 = x_stage_11 >>> 11;
    assign y_shifted_11 = y_stage_11 >>> 11;

    assign x_shifted_12 = x_stage_12 >>> 12;
    assign y_shifted_12 = y_stage_12 >>> 12;

    assign x_shifted_13 = x_stage_13 >>> 13;
    assign y_shifted_13 = y_stage_13 >>> 13;

    assign x_shifted_14 = x_stage_14 >>> 14;
    assign y_shifted_14 = y_stage_14 >>> 14;

    assign x_shifted_15 = x_stage_15 >>> 15;
    assign y_shifted_15 = y_stage_15 >>> 15;

    assign x_shifted_16 = x_stage_16 >>> 16;
    assign y_shifted_16 = y_stage_16 >>> 16;

    // assign the MSB of z_stage (the sign bit) to each d.
    assign d_1 = z_stage_1[21];
    assign d_2 = z_stage_2[21];
    assign d_3 = z_stage_3[21];
    assign d_4 = z_stage_4[21];
    assign d_5 = z_stage_5[21];
    assign d_6 = z_stage_6[21];
    assign d_7 = z_stage_7[21];
    assign d_8 = z_stage_8[21];
    assign d_9 = z_stage_9[21];
    assign d_10 = z_stage_10[21];
    assign d_11 = z_stage_11[21];
    assign d_12 = z_stage_12[21];
    assign d_13 = z_stage_13[21];
    assign d_14 = z_stage_14[21];
    assign d_15 = z_stage_15[21];
    assign d_16 = z_stage_16[21];

    

    // for the testbench //
	 assign stage_1 = x_stage_1;
	 assign stage_2 = x_stage_2;
	 assign stage_3 = x_stage_3;
	 assign stage_4 = x_stage_4;
	 assign stage_5 = x_stage_5;
	 assign stage_6 = x_stage_6;
	 assign stage_7 = x_stage_7;
	 assign stage_8 = x_stage_8;
	 assign stage_9 = x_stage_9;
	 assign stage_10 = x_stage_10;
	 assign stage_11 = x_stage_11;
	 assign stage_12 = x_stage_12;
	 assign stage_13 = x_stage_13;
	 assign stage_14 = x_stage_14;
	 assign stage_15 = x_stage_15;
	 assign stage_16 = x_stage_16;
	 assign stage_17 = x_stage_17;
	 // for the testbench - end //

    always @ (posedge clk) begin
        if (reset) begin
            x_stage_1 = 22'b0;
            y_stage_1 = 22'b0;
            z_stage_1 = 22'b0;

            x_stage_2 = 22'b0;
            y_stage_2 = 22'b0;
            z_stage_2 = 22'b0;

            x_stage_3 = 22'b0;
            y_stage_3 = 22'b0;
            z_stage_3 = 22'b0;

            x_stage_4 = 22'b0;
            y_stage_4 = 22'b0;
            z_stage_4 = 22'b0;

            x_stage_5 = 22'b0;
            y_stage_5 = 22'b0;
            z_stage_5 = 22'b0;

            x_stage_6 = 22'b0;
            y_stage_6 = 22'b0;
            z_stage_6 = 22'b0;

            x_stage_7 = 22'b0;
            y_stage_7 = 22'b0;
            z_stage_7 = 22'b0;

            x_stage_8 = 22'b0;
            y_stage_8 = 22'b0;
            z_stage_8 = 22'b0;

            x_stage_9 = 22'b0;
            y_stage_9 = 22'b0;
            z_stage_9 = 22'b0;

            x_stage_10 = 22'b0;
            y_stage_10 = 22'b0;
            z_stage_10 = 22'b0;

            x_stage_11 = 22'b0;
            y_stage_11 = 22'b0;
            z_stage_11 = 22'b0;

            x_stage_12 = 22'b0;
            y_stage_12 = 22'b0;
            z_stage_12 = 22'b0;

            x_stage_13 = 22'b0;
            y_stage_13 = 22'b0;
            z_stage_13 = 22'b0;

            x_stage_14 = 22'b0;
            y_stage_14 = 22'b0;
            z_stage_14 = 22'b0;

            x_stage_15 = 22'b0;
            y_stage_15 = 22'b0;
            z_stage_15 = 22'b0;

            x_stage_16 = 22'b0;
            y_stage_16 = 22'b0;
            z_stage_16 = 22'b0;

            x_stage_17 = 22'b0;
            y_stage_17 = 22'b0;
            z_stage_17 = 22'b0;
        end
        if (enable) begin
            x_stage_1 = 22'b10011011011101001110;
            y_stage_1 = 22'd0;
            z_stage_1 = angle_in;
            
            for (a = 0; a < 2; a = a + 1) begin
                if (d_16) begin
                    x_stage_17 = x_stage_16 + y_shifted_16;
                    y_stage_17 = y_stage_16 - x_shifted_16;
                    z_stage_17 = z_stage_16 + 22'h0001F;
                end
                else begin
                    x_stage_17 = x_stage_16 - y_shifted_16;
                    y_stage_17 = y_stage_16 + x_shifted_16;
                    z_stage_17 = z_stage_16 - 22'h0001F;
                end

                if (d_15) begin
                    x_stage_16 = x_stage_15 + y_shifted_15;
                    y_stage_16 = y_stage_15 - x_shifted_15;
                    z_stage_16 = z_stage_15 + 22'h0003F;
                end
                else begin
                    x_stage_16 = x_stage_15 - y_shifted_15;
                    y_stage_16 = y_stage_15 + x_shifted_15;
                    z_stage_16 = z_stage_15 - 22'h0003F;
                end 
            end

            for (b = 0; b < 2; b = b + 1) begin
                if (d_14) begin
                    x_stage_15 = x_stage_14 + y_shifted_14;
                    y_stage_15 = y_stage_14 - x_shifted_14;
                    z_stage_15 = z_stage_14 + 22'h0007F;
                end
                else begin
                    x_stage_15 = x_stage_14 - y_shifted_14;
                    y_stage_15 = y_stage_14 + x_shifted_14;
                    z_stage_15 = z_stage_14 - 22'h0007F;
                end

                if (d_13) begin
                    x_stage_14 = x_stage_13 + y_shifted_13;
                    y_stage_14 = y_stage_13 - x_shifted_13;
                    z_stage_14 = z_stage_13 + 22'h000FF;
                end
                else begin
                    x_stage_14 = x_stage_13 - y_shifted_13;
                    y_stage_14 = y_stage_13 + x_shifted_13;
                    z_stage_14 = z_stage_13 - 22'h000FF;
                end  
            end

            for (c = 0; c < 2; c = c + 1) begin
                if (d_12) begin
                    x_stage_13 = x_stage_12 + y_shifted_12;
                    y_stage_13 = y_stage_12 - x_shifted_12;
                    z_stage_13 = z_stage_12 + 22'h001FF;
                end
                else begin
                    x_stage_13 = x_stage_12 - y_shifted_12;
                    y_stage_13 = y_stage_12 + x_shifted_12;
                    z_stage_13 = z_stage_12 - 22'h001FF;
                end

                if (d_11) begin
                    x_stage_12 = x_stage_11 + y_shifted_11;
                    y_stage_12 = y_stage_11 - x_shifted_11;
                    z_stage_12 = z_stage_11 + 22'h003FF;
                end
                else begin
                    x_stage_12 = x_stage_11 - y_shifted_11;
                    y_stage_12 = y_stage_11 + x_shifted_11;
                    z_stage_12 = z_stage_11 - 22'h003FF;
                end
            end 

            for (d = 0; d < 2; d = d + 1) begin
                if (d_10) begin
                    x_stage_11 = x_stage_10 + y_shifted_10;
                    y_stage_11 = y_stage_10 - x_shifted_10;
                    z_stage_11 = z_stage_10 + 22'h007FF;
                end
                else begin
                    x_stage_11 = x_stage_10 - y_shifted_10;
                    y_stage_11 = y_stage_10 + x_shifted_10;
                    z_stage_11 = z_stage_10 - 22'h007FF;
                end

                if (d_9) begin
                    x_stage_10 = x_stage_9 + y_shifted_9;
                    y_stage_10 = y_stage_9 - x_shifted_9;
                    z_stage_10 = z_stage_9 + 22'h00FFF;
                end
                else begin
                    x_stage_10 = x_stage_9 - y_shifted_9;
                    y_stage_10 = y_stage_9 + x_shifted_9;
                    z_stage_10 = z_stage_9 - 22'h00FFF;
                end
            end 

            for (e = 0; e < 2; e = e + 1) begin
                if (d_8) begin
                    x_stage_9 = x_stage_8 + y_shifted_8;
                    y_stage_9 = y_stage_8 - x_shifted_8;
                    z_stage_9 = z_stage_8 + 22'h01FFF;
                end
                else begin
                    x_stage_9 = x_stage_8 - y_shifted_8;
                    y_stage_9 = y_stage_8 + x_shifted_8;
                    z_stage_9 = z_stage_8 - 22'h01FFF;
                end

                if (d_7) begin
                    x_stage_8 = x_stage_7 + y_shifted_7;
                    y_stage_8 = y_stage_7 - x_shifted_7;
                    z_stage_8 = z_stage_7 + 22'h03FFE;
                end
                else begin
                    x_stage_8 = x_stage_7 - y_shifted_7;
                    y_stage_8 = y_stage_7 + x_shifted_7;
                    z_stage_8 = z_stage_7 - 22'h03FFE;
                end
            end 

            for (f = 0; f < 2; f = f + 1) begin
                if (d_6) begin
                    x_stage_7 = x_stage_6 + y_shifted_6;
                    y_stage_7 = y_stage_6 - x_shifted_6;
                    z_stage_7 = z_stage_6 + 22'h07FF5;
                end
                else begin
                    x_stage_7 = x_stage_6 - y_shifted_6;
                    y_stage_7 = y_stage_6 + x_shifted_6;
                    z_stage_7 = z_stage_6 - 22'h07FF5;
                end

                if (d_5) begin
                    x_stage_6 = x_stage_5 + y_shifted_5;
                    y_stage_6 = y_stage_5 - x_shifted_5;
                    z_stage_6 = z_stage_5 + 22'h0FFAA;
                end
                else begin
                    x_stage_6 = x_stage_5 - y_shifted_5;
                    y_stage_6 = y_stage_5 + x_shifted_5;
                    z_stage_6 = z_stage_5 - 22'h0FFAA;
                end
            end 

            for (g = 0; g < 2; g = g + 1) begin
                if (d_4) begin
                    x_stage_5 = x_stage_4 + y_shifted_4;
                    y_stage_5 = y_stage_4 - x_shifted_4;
                    z_stage_5 = z_stage_4 + 22'h1FD5B;
                end
                else begin
                    x_stage_5 = x_stage_4 - y_shifted_4;
                    y_stage_5 = y_stage_4 + x_shifted_4;
                    z_stage_5 = z_stage_4 - 22'h1FD5B;
                end

                if (d_3) begin
                    x_stage_4 = x_stage_3 + y_shifted_3;
                    y_stage_4 = y_stage_3 - x_shifted_3;
                    z_stage_4 = z_stage_3 + 22'h3EB6E;
                end
                else begin
                    x_stage_4 = x_stage_3 - y_shifted_3;
                    y_stage_4 = y_stage_3 + x_shifted_3;
                    z_stage_4 = z_stage_3 - 22'h3EB6E;
                end
            end 

            for (h = 0; h < 2; h = h + 1) begin
                if (d_2) begin
                    x_stage_3 = x_stage_2 + y_shifted_2;
                    y_stage_3 = y_stage_2 - x_shifted_2;
                    z_stage_3 = z_stage_2 + 22'h76B19;
                end
                else begin
                    x_stage_3 = x_stage_2 - y_shifted_2;
                    y_stage_3 = y_stage_2 + x_shifted_2;
                    z_stage_3 = z_stage_2 - 22'h76B19;
                end

                if (d_1) begin
                    x_stage_2 = x_stage_1 + y_shifted_1;
                    y_stage_2 = y_stage_1 - x_shifted_1;
                    z_stage_2 = z_stage_1 + 22'hC90FD;
                end
                else begin
                    x_stage_2 = x_stage_1 - y_shifted_1;
                    y_stage_2 = y_stage_1 + x_shifted_1;
                    z_stage_2 = z_stage_1 - 22'hC90FD;
                end             
            end
            cos_out = x_stage_17;
        end
    end
endmodule