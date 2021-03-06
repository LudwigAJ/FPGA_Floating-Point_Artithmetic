module Cordic_rolled_pipeline(
    clk, // our clock signal
    enable, // enable our whole chip to start
    reset, // active high
    angle_in, // input
    cos_out // output
    );

    input clk, enable, reset;

    input [21:0] angle_in;
    output reg signed [21:0] cos_out;
	

    // make the 17 different stages of the pipeline for x, y, and z.
    reg signed [21:0] x_stage_1, x_stage_2, x_stage_3, x_stage_4, x_stage_5, x_stage_6, x_stage_7, x_stage_8; 
    reg signed [21:0] x_stage_9, x_stage_10, x_stage_11, x_stage_12, x_stage_13, x_stage_14, x_stage_15, x_stage_16, x_stage_17;

    reg signed [21:0] y_stage_1, y_stage_2, y_stage_3, y_stage_4, y_stage_5, y_stage_6, y_stage_7, y_stage_8; 
    reg signed [21:0] y_stage_9, y_stage_10, y_stage_11, y_stage_12, y_stage_13, y_stage_14, y_stage_15, y_stage_16, y_stage_17;

    reg signed [21:0] z_stage_1, z_stage_2, z_stage_3, z_stage_4, z_stage_5, z_stage_6, z_stage_7, z_stage_8; 
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


    always @ (posedge clk) begin
        if (reset) begin
            x_stage_1 <= 22'b0;
            y_stage_1 <= 22'b0;
            z_stage_1 <= 22'b0;

            x_stage_2 <= 22'b0;
            y_stage_2 <= 22'b0;
            z_stage_2 <= 22'b0;

            x_stage_3 <= 22'b0;
            y_stage_3 <= 22'b0;
            z_stage_3 <= 22'b0;

            x_stage_4 <= 22'b0;
            y_stage_4 <= 22'b0;
            z_stage_4 <= 22'b0;

            x_stage_5 <= 22'b0;
            y_stage_5 <= 22'b0;
            z_stage_5 <= 22'b0;

            x_stage_6 <= 22'b0;
            y_stage_6 <= 22'b0;
            z_stage_6 <= 22'b0;

            x_stage_7 <= 22'b0;
            y_stage_7 <= 22'b0;
            z_stage_7 <= 22'b0;

            x_stage_8 <= 22'b0;
            y_stage_8 <= 22'b0;
            z_stage_8 <= 22'b0;

            x_stage_9 <= 22'b0;
            y_stage_9 <= 22'b0;
            z_stage_9 <= 22'b0;

            x_stage_10 <= 22'b0;
            y_stage_10 <= 22'b0;
            z_stage_10 <= 22'b0;

            x_stage_11 <= 22'b0;
            y_stage_11 <= 22'b0;
            z_stage_11 <= 22'b0;

            x_stage_12 <= 22'b0;
            y_stage_12 <= 22'b0;
            z_stage_12 <= 22'b0;

            x_stage_13 <= 22'b0;
            y_stage_13 <= 22'b0;
            z_stage_13 <= 22'b0;

            x_stage_14 <= 22'b0;
            y_stage_14 <= 22'b0;
            z_stage_14 <= 22'b0;

            x_stage_15 <= 22'b0;
            y_stage_15 <= 22'b0;
            z_stage_15 <= 22'b0;

            x_stage_16 <= 22'b0;
            y_stage_16 <= 22'b0;
            z_stage_16 <= 22'b0;

            x_stage_17 <= 22'b0;
            y_stage_17 <= 22'b0;
            z_stage_17 <= 22'b0;
        end
        if (enable) begin

            // stage 1 //

            x_stage_1 <= 22'b10011011011101001110;
            y_stage_1 <= 22'd0;
            z_stage_1 <= angle_in;

            // stage 2 //

            if (d_1) begin
                x_stage_2 <= x_stage_1 + y_shifted_1;
                y_stage_2 <= y_stage_1 - x_shifted_1;
                z_stage_2 <= z_stage_1 + 22'hC90FD;
            end
            else begin
                x_stage_2 <= x_stage_1 - y_shifted_1;
                y_stage_2 <= y_stage_1 + x_shifted_1;
                z_stage_2 <= z_stage_1 - 22'hC90FD;
            end

            // stage 3 //

            if (d_2) begin
                x_stage_3 <= x_stage_2 + y_shifted_2;
                y_stage_3 <= y_stage_2 - x_shifted_2;
                z_stage_3 <= z_stage_2 + 22'h76B19;
            end
            else begin
                x_stage_3 <= x_stage_2 - y_shifted_2;
                y_stage_3 <= y_stage_2 + x_shifted_2;
                z_stage_3 <= z_stage_2 - 22'h76B19;
            end

            // stage 4 //

            if (d_3) begin
                x_stage_4 <= x_stage_3 + y_shifted_3;
                y_stage_4 <= y_stage_3 - x_shifted_3;
                z_stage_4 <= z_stage_3 + 22'h3EB6E;
            end
            else begin
                x_stage_4 <= x_stage_3 - y_shifted_3;
                y_stage_4 <= y_stage_3 + x_shifted_3;
                z_stage_4 <= z_stage_3 - 22'h3EB6E;
            end

            // stage 5 //

            if (d_4) begin
                x_stage_5 <= x_stage_4 + y_shifted_4;
                y_stage_5 <= y_stage_4 - x_shifted_4;
                z_stage_5 <= z_stage_4 + 22'h1FD5B;
            end
            else begin
                x_stage_5 <= x_stage_4 - y_shifted_4;
                y_stage_5 <= y_stage_4 + x_shifted_4;
                z_stage_5 <= z_stage_4 - 22'h1FD5B;
            end

            // stage 6 //

            if (d_5) begin
                x_stage_6 <= x_stage_5 + y_shifted_5;
                y_stage_6 <= y_stage_5 - x_shifted_5;
                z_stage_6 <= z_stage_5 + 22'h0FFAA;
            end
            else begin
                x_stage_6 <= x_stage_5 - y_shifted_5;
                y_stage_6 <= y_stage_5 + x_shifted_5;
                z_stage_6 <= z_stage_5 - 22'h0FFAA;
            end

            // stage 7 //

            if (d_6) begin
                x_stage_7 <= x_stage_6 + y_shifted_6;
                y_stage_7 <= y_stage_6 - x_shifted_6;
                z_stage_7 <= z_stage_6 + 22'h07FF5;
            end
            else begin
                x_stage_7 <= x_stage_6 - y_shifted_6;
                y_stage_7 <= y_stage_6 + x_shifted_6;
                z_stage_7 <= z_stage_6 - 22'h07FF5;
            end

            // stage 8 //

            if (d_7) begin
                x_stage_8 <= x_stage_7 + y_shifted_7;
                y_stage_8 <= y_stage_7 - x_shifted_7;
                z_stage_8 <= z_stage_7 + 22'h03FFE;
            end
            else begin
                x_stage_8 <= x_stage_7 - y_shifted_7;
                y_stage_8 <= y_stage_7 + x_shifted_7;
                z_stage_8 <= z_stage_7 - 22'h03FFE;
            end

            // stage 9 //

            if (d_8) begin
                x_stage_9 <= x_stage_8 + y_shifted_8;
                y_stage_9 <= y_stage_8 - x_shifted_8;
                z_stage_9 <= z_stage_8 + 22'h01FFF;
            end
            else begin
                x_stage_9 <= x_stage_8 - y_shifted_8;
                y_stage_9 <= y_stage_8 + x_shifted_8;
                z_stage_9 <= z_stage_8 - 22'h01FFF;
            end

            // stage 10 //

            if (d_9) begin
                x_stage_10 <= x_stage_9 + y_shifted_9;
                y_stage_10 <= y_stage_9 - x_shifted_9;
                z_stage_10 <= z_stage_9 + 22'h00FFF;
            end
            else begin
                x_stage_10 <= x_stage_9 - y_shifted_9;
                y_stage_10 <= y_stage_9 + x_shifted_9;
                z_stage_10 <= z_stage_9 - 22'h00FFF;
            end

            // stage 11 //

            if (d_10) begin
                x_stage_11 <= x_stage_10 + y_shifted_10;
                y_stage_11 <= y_stage_10 - x_shifted_10;
                z_stage_11 <= z_stage_10 + 22'h007FF;
            end
            else begin
                x_stage_11 <= x_stage_10 - y_shifted_10;
                y_stage_11 <= y_stage_10 + x_shifted_10;
                z_stage_11 <= z_stage_10 - 22'h007FF;
            end

            // stage 12 //

            if (d_11) begin
                x_stage_12 <= x_stage_11 + y_shifted_11;
                y_stage_12 <= y_stage_11 - x_shifted_11;
                z_stage_12 <= z_stage_11 + 22'h003FF;
            end
            else begin
                x_stage_12 <= x_stage_11 - y_shifted_11;
                y_stage_12 <= y_stage_11 + x_shifted_11;
                z_stage_12 <= z_stage_11 - 22'h003FF;
            end

            // stage 13 //

            if (d_12) begin
                x_stage_13 <= x_stage_12 + y_shifted_12;
                y_stage_13 <= y_stage_12 - x_shifted_12;
                z_stage_13 <= z_stage_12 + 22'h001FF;
            end
            else begin
                x_stage_13 <= x_stage_12 - y_shifted_12;
                y_stage_13 <= y_stage_12 + x_shifted_12;
                z_stage_13 <= z_stage_12 - 22'h001FF;
            end

            // stage 14 //

            if (d_13) begin
                x_stage_14 <= x_stage_13 + y_shifted_13;
                y_stage_14 <= y_stage_13 - x_shifted_13;
                z_stage_14 <= z_stage_13 + 22'h000FF;
            end
            else begin
                x_stage_14 <= x_stage_13 - y_shifted_13;
                y_stage_14 <= y_stage_13 + x_shifted_13;
                z_stage_14 <= z_stage_13 - 22'h000FF;
            end

            // stage 15 //

            if (d_14) begin
                x_stage_15 <= x_stage_14 + y_shifted_14;
                y_stage_15 <= y_stage_14 - x_shifted_14;
                z_stage_15 <= z_stage_14 + 22'h0007F;
            end
            else begin
                x_stage_15 <= x_stage_14 - y_shifted_14;
                y_stage_15 <= y_stage_14 + x_shifted_14;
                z_stage_15 <= z_stage_14 - 22'h0007F;
            end

            // stage 16 //

            if (d_15) begin
                x_stage_16 <= x_stage_15 + y_shifted_15;
                y_stage_16 <= y_stage_15 - x_shifted_15;
                z_stage_16 <= z_stage_15 + 22'h0003F;
            end
            else begin
                x_stage_16 <= x_stage_15 - y_shifted_15;
                y_stage_16 <= y_stage_15 + x_shifted_15;
                z_stage_16 <= z_stage_15 - 22'h0003F;
            end

            // stage 17 //

            if (d_16) begin
                x_stage_17 <= x_stage_16 + y_shifted_16;
                y_stage_17 <= y_stage_16 - x_shifted_16;
                z_stage_17 <= z_stage_16 + 22'h0001F;
            end
            else begin
                x_stage_17 <= x_stage_16 - y_shifted_16;
                y_stage_17 <= y_stage_16 + x_shifted_16;
                z_stage_17 <= z_stage_16 - 22'h0001F;
            end

            cos_out <= x_stage_17;
        end
    end
endmodule