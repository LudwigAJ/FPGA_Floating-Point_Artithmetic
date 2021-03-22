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
    result
    );

    input clk;
    input [31:0] data;
    output [31:0] result;

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

    Task6_Mult_top first_mult(
        .dataa(point_five),
        .datab(data),
        .result(result_first),
        .clk(clk)
        );
    Task6_Mult_top second_mult(
        .dataa(data),
        .datab(data),
        .result(result_second),
        .clk(clk)
        );
    Task6_Sub_top first_sub(
        .dataa(data),
        .datab(one_twenty_eight),
        .result(result_third),
        .clk(clk)
        );
    Task6_Mult_top third_mult(
        .dataa(result_third),
        .datab(one_over_one_twenty_eight),
        .result(result_fourth),
        .clk(clk)
        );
    Float_Fixed_Conversion floatToFixed(
        .data(result_fourth),
        .result(result_fourth_fixed),
        .clk(clk)
    );

    reg geoff_reset = 1'b0;
    //reg geoff_start = 1'b1;
    wire geoff_done;

    
    cordic geoff(
        .clk(clk),
        .reset(geoff_reset), //active-high
        .angle(result_fourth_fixed),
        .cos_out(result_fifth),
	     .done(geoff_done)
    );

    Fixed_Float_Conversion fixedToFloat(
        .data(result_fifth),
        .result(result_fifth_fixed),
        .clk(clk)
    );

    Task6_Mult_top fourth_mult(
        .dataa(result_second),
        .datab(result_fifth_fixed),
        .result(result_sixth),
        .clk(clk)
        );
    
    Task6_Addr_top second_addr(
        .dataa(result_first),
        .datab(result_sixth),
        .result(result_seventh),
        .clk(clk)
        );
    
    assign result[31:0] = result_seventh[31:0];

endmodule
