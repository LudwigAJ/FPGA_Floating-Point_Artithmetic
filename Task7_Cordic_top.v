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
    start
    );

    input clk;
    input start;
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
	 
    reg [31:0] result_first_reg;
    reg [31:0] result_second_reg;
    reg [31:0] result_third_reg;
    reg [31:0] result_fourth_reg;
    reg [21:0] result_fourth_fixed_reg;
    reg [21:0] result_fifth_reg;
    reg [31:0] result_fifth_fixed_reg;
    reg [31:0] result_sixth_reg;
    reg [31:0] result_seventh_reg;

    reg enable_1, enable_2, enable_3, enable_4, enable_5, enable_6, enable_7, enable_8, enable_9;
	 
    wire enable_wire1, enable_wire2, enable_wire3, enable_wire4, enable_wire5, enable_wire6, enable_wire7, enable_wire8, enable_wire9;

    reg start_1, start_2, start_3;
	 
	always @ (posedge clk) begin
		if (start) begin
			start_1 <= 1'b1;
			start_2 <= 1'b1;
			start_3 <= 1'b1;
			
			enable_1 <= 1'b0;
			enable_2 <= 1'b0;
			enable_3 <= 1'b0;
			enable_4 <= 1'b0;
			enable_5 <= 1'b0;
			enable_6 <= 1'b0;
			enable_7 <= 1'b0;
			enable_8 <= 1'b0;
			enable_9 <= 1'b0;
			
			// NEW ADDED REMOVE IF IT BREAKS
			result_first_reg <= 32'b0;
			result_second_reg <= 32'b0;
			result_third_reg <= 32'b0;
			result_fourth_reg <= 32'b0;
			result_fourth_fixed_reg <= 22'b0;
			result_fifth_reg <= 22'b0;
			result_fifth_fixed_reg <= 32'b0;
			result_sixth_reg <= 32'b0;
			result_seventh_reg <= 32'b0;
			// NEW ADDED REMOVE IF IT BREAKS - END
	
		end
		else if (enable_wire3 & enable_wire2 & enable_wire1 & !enable_1 & !enable_2 & !enable_3) begin
			enable_1 <= enable_wire1;
			enable_2 <= enable_wire2;
			enable_3 <= enable_wire3;
		
			result_third_reg <= result_third;
			result_second_reg <= result_second;
			result_first_reg <= result_first;
			
			start_3 <= 1'b0;
			start_2 <= 1'b0;
			start_1 <= 1'b0;
		end
		else if (enable_wire4 & !enable_4) begin
			enable_4 <= enable_wire4;
			result_fourth_reg <= result_fourth;
			enable_3 <= 1'b0;
		end
		else if (enable_wire5 & !enable_5) begin
			enable_5 <= enable_wire5;
			result_fourth_fixed_reg <= result_fourth_fixed;
			enable_4 <= 1'b0;
		end
		else if (enable_wire6 & !enable_6) begin
			enable_6 <= enable_wire6;
			result_fifth_reg <= result_fifth;
			enable_5 <= 1'b0;
		end
		else if (enable_wire7 & !enable_7) begin
			enable_7 <= enable_wire7;
			result_fifth_fixed_reg <= result_fifth_fixed;
			enable_6 <= 1'b0;
		end
		else if (enable_wire8 & !enable_8) begin
			enable_8 <= enable_wire8;
			result_sixth_reg <= result_sixth;
			enable_7 <= 1'b0;
			enable_2 <= 1'b0;
		end
		else if (enable_wire9 & !enable_9) begin
			enable_9 <= enable_wire9;
			result_seventh_reg <= result_seventh[31:0];	
			enable_8 <= 1'b0;
			enable_1 <= 1'b0;
		end
		else if (enable_9) begin
			enable_9 <= 1'b0;
			result[31:0] <= result_seventh_reg[31:0];
        end
	end
	
	// checking //
	
	//assign result[31:0] = result_seventh_reg[31:0];
	
	// checking - end //
	
    Task6_Mult_top first_mult(
        .dataa(point_five),
        .datab(data),
        .result(result_first),
        .enable(start_1),
        .done(enable_wire1),
        .clk(clk)
        );
	 
    Task6_Mult_top second_mult(
        .dataa(data),
        .datab(data),
        .result(result_second),
        .enable(start_2),
        .done(enable_wire2),
        .clk(clk)
        );
	 
    Task6_Sub_top first_sub(
        .dataa(data),
        .datab(one_twenty_eight),
        .result(result_third),
        .enable(start_3),
        .done(enable_wire3),
        .clk(clk)
        );
	 
    Task6_Mult_top third_mult(
        .dataa(result_third_reg),
        .datab(one_over_one_twenty_eight),
        .result(result_fourth),
        .enable(enable_3),
        .done(enable_wire4),
        .clk(clk)
        );
	 
    Float_Fixed_Conversion floatToFixed(
        .data(result_fourth_reg),
        .result(result_fourth_fixed),
        .enable(enable_4),
        .done(enable_wire5),
        .clk(clk)
    );
	 
    reg geoff_reset = 1'b0;

    cordic_unrolled geoff(
        .clk(clk),
        .clk_en(enable_5),
        .reset(geoff_reset), //active-high
        .angle(result_fourth_fixed_reg),
        .cos_out(result_fifth),
	     .done(enable_wire6)
    );
	 
    Fixed_Float_Conversion fixedToFloat(
        .data(result_fifth_reg),
        .result(result_fifth_fixed),
        .enable(enable_6),
        .done(enable_wire7),
        .clk(clk)
    );
	 
    Task6_Mult_top fourth_mult(
        .dataa(result_second_reg),
        .datab(result_fifth_fixed_reg),
        .result(result_sixth),
        .enable(enable_7),
        .done(enable_wire8),
        .clk(clk)
        );
	 
    Task6_Addr_top second_addr(
        .dataa(result_first_reg),
        .datab(result_sixth_reg),
        .result(result_seventh),
        .enable(enable_8),
        .done(enable_wire9),
        .clk(clk)
        );

endmodule
