module Task7_Cordic_top(
    clk,
    dataa,
    datab,
    result,
    start
    );


    input clk;
    input start;
    input [31:0] dataa, datab;
    output reg [31:0] result;
    

    wire [31:0] result_wire;

    wire [31:0] result_dataa, result_datab;
    wire enable_dataa, enable_datab, enable_add;

    reg [31:0] result_dataa_reg, result_datab_reg;
    reg enable_dataa_reg, enable_datab_reg, enable_add_reg;

    assign result <= result_wire;


    always @ (posedge clk) begin
        if (enable_dataa && enable_datab) begin
            result_dataa_reg <= result_dataa;
            result_datab_reg <= result_datab;

            enable_add_reg <= 1'b1;
        end
    end

    Task7_Cordic_sub geoff_dataa(
        .clk(clk),
        .data(dataa),
        .result(result_dataa),
        .start(start),
        .done(enable_dataa)
        );
       
    Task7_Cordic_sub geoff_datab(
        .clk(clk),
        .data(datab),
        .result(result_datab),
        .start(start),
        .done(enable_datab)
        );

    Task6_Addr_top Last_adder(
        .dataa(result_dataa_reg),
        .datab(result_datab_reg),
        .result(result_wire),
        .enable(enable_add_reg),
        .done(enable_add),
        .clk(clk)
        );
        

endmodule
