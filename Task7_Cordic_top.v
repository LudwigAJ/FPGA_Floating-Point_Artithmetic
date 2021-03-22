// y = 0.5*x + x^2*cos((x-128)/128)
// 0.5*x : FIRST
// x^2 : SECOND
// x - 128 : THIRD
// THIRD/128 : FOURTH
// FLOAT TO FIXED : FOURTHFIXED
// COS(FOURTH) : FIFTH
// FIXED TO FLOAT : FIFTHFLOAT
// SECOND * FIFTH : SIXTH
// FIRST + SIXTH : SEVENTH
// 4 MULT, 1 ADD, 1 SUB, 1 CORDIC 

module Task7_Cordic_top(
    clk,
    data,
    result,
    );

    input clk;
    input [31:0] data;
    output reg [31:0] result;
	 
    // Constants //
    //wire [31:0] point_five;
    //wire [31:0] one_twenty_eight;
    //wire [31:0] one_over_one_twenty_eight;
    parameter point_five = 32'b00111111000000000000000000000000; // 0.5
    parameter one_twenty_eight = 32'b01000011000000000000000000000000; //128.0
    parameter one_over_one_twenty_eight = 32'b00111100000000000000000000000000; // 1.0/128.0 = 0.0078125
    // Constants - end //

    wire [31:0] result_first;
    wire [31:0] result_second;
    wire [31:0] result_third;
    wire [31:0] result_fourth;
    wire [21:0] result_fourth_fixed;
    wire [21:0] result_fifth;
    wire [31:0] result_fifth_fixed;
    wire [31:0] result_sixth;
    wire [31:0] result_seventh;

    wire enable_1, enable_2, enable_3, enable_4, enable_5, enable_6, enable_7, enable_8, enable_9;

    reg start_1 = 1'b1;
    reg start_2 = 1'b1;
    reg start_3 = 1'b1;

    Task6_Mult_top first_mult(
        .dataa(point_five),
        .datab(data),
        .result(result_first),
        .enable(start_1),
        .done(enable_1),
        .clk(clk)
        );

    Task6_Mult_top second_mult(
        .dataa(data),
        .datab(data),
        .result(result_second),
        .enable(start_2),
        .done(enable_2),
        .clk(clk)
        );

    Task6_Sub_top first_sub(
        .dataa(data),
        .datab(one_twenty_eight),
        .result(result_third),
        .enable(start_3),
        .done(enable_3),
        .clk(clk)
        );

    Task6_Mult_top third_mult(
        .dataa(result_third),
        .datab(one_over_one_twenty_eight),
        .result(result_fourth),
        .enable(enable_3),
        .done(enable_4),
        .clk(clk)
        );

    Float_Fixed_Conversion floatToFixed(
        .data(result_fourth),
        .result(result_fourth_fixed),
        .enable(enable_4),
        .done(enable_5),
        .clk(clk)
    );

    reg geoff_reset = 1'b0;

    cordic geoff(
        .clk(clk),
        .clk_en(enable_5),
        .reset(geoff_reset), //active-high
        .angle(result_fourth_fixed),
        .cos_out(result_fifth),
	    .done(enable_6)
    );

    Fixed_Float_Conversion fixedToFloat(
        .data(result_fifth),
        .result(result_fifth_fixed),
        .enable(enable_6),
        .done(enable_7),
        .clk(clk)
    );

    Task6_Mult_top fourth_mult(
        .dataa(result_second),
        .datab(result_fifth_fixed),
        .result(result_sixth),
        .enable(enable_7),
        .done(enable_8),
        .clk(clk)
        );

    Task6_Addr_top second_addr(
        .dataa(result_first),
        .datab(result_sixth),
        .result(result_seventh),
        .enable(enable_8),
        .done(enable_9),
        .clk(clk)
        );

    always @ (posedge clk) begin
        if (enable_9) begin
            result[31:0] <= result_seventh[31:0];
        end
    end
    
    //assign result[31:0] = result_seventh[31:0];

endmodule
