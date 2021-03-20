// y = 0.5*x + x^2*cos((x-128)/128)
// 0.5*x : FIRST
// x^2 : SECOND
// x - 128 : THIRD
// THIRD/128 : FOURTH
// COS(FOURTH) : FIFTH
// SECOND * FIFTH : SIXTH
// FIRST + SIXTH : SEVENTH
// 4 MULT, 1 ADD, 1 SUB, 1 CORDIC 

module Task_7_top(
    clk,
    data,
    result
    );

    input clk;
    input [31:0] data;
    output [31:0] result

    // Constants //
    wire [31:0] point_five;
    wire [31:0] one_twenty_eight;
    wire [31:0] one_over_one_twenty_eight;
    assign pointfive = 32'b00111111000000000000000000000000; // 0.5
    assign onetwentyeight = 32'b01000011000000000000000000000000; //128.0
    assign one_over_one_twenty_eight = 32'b00111100000000000000000000000000; // 1.0/128.0 = 0.0078125
    // Constants - end //

    wire [31:0] result_first;
    wire [31:0] result_second;
    wire [31:0] result_third;
    wire [31:0] result_fourth;
    wire [31:0] result_fifth;
    wire [31:0] result_sixth;
    wire [31:0] result_seventh;

    Task6_Mult first_mult(
        .dataa(point_five),
        .datab(data),
        .result(result_first),
        .clk(clk)
        );
    )
    Task6_Mult second_mult(
        .dataa(data),
        .datab(data),
        .result(result_second),
        .clk(clk)
        );
    Task6_Sub first_sub(
        .dataa(data),
        .datab(one_twenty_eight),
        .result(result_third),
        .clk(clk)
        );
    Task6_Mult third_mult(
        .dataa(),
        .datab(),
        .result(),
        .clk(clk)
        );
    Task6_Mult fourth_mult(
        .dataa(),
        .datab(),
        .result(),
        .clk(clk)
        );
    //CORDIC
    //CORDIC
    //CORDIC
    Task6_Addr second_addr(
        .dataa(),
        .datab(),
        .result(),
        .clk(clk)
        );
    
  assign result = result_seventh;



endmodule
