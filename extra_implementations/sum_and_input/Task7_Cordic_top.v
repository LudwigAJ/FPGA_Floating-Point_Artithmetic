module Task8_Cordic_top(
    clk,
    dataa, // the value to be calculated
    datab, // the sum
    result,
    start
    );

		
    input clk;
    input start;
    input [31:0] dataa, datab;
    output reg [31:0] result;

    wire [31:0] result_wire;

    wire [31:0] result_dataa;
    wire enable_dataa, enable_add;
	 
	 reg done;

    reg [31:0] result_dataa_reg;
    reg enable_dataa_reg, enable_add_reg;


    always @ (posedge clk) begin
		  if (start) begin
			   result_dataa_reg <= 32'b0;
				enable_dataa_reg <= 1'b0;
				enable_add_reg <= 1'b0;
				done <= 1'b0;
		  end
        else if (enable_dataa & !enable_add_reg & !done) begin
            result_dataa_reg <= result_dataa;
            enable_add_reg <= 1'b1;
        end
		  else if (enable_add & !done) begin
				result <= result_wire;
			   enable_add_reg <= 1'b0;
				done <= 1'b1;
		  end
    end

    Task8_Cordic_top_sub geoff(
        .clk(clk),
        .data(dataa),
        .result(result_dataa),
        .start(start),
        .done(enable_dataa)
        );
       

    Task6_Addr_top Last_adder(
        .dataa(result_dataa_reg),
        .datab(datab),
        .result(result_wire),
        .enable(enable_add_reg),
        .done(enable_add),
        .clk(clk)
        );    

endmodule

