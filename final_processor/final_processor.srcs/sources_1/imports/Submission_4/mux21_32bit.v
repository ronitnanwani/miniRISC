module mux21_32bit(
    input [31:0] in0,
    input [31:0] in1,
    input select,
    output reg [31:0] out
);

always @(*) begin
            // $display("the B or Imm mux is called \n");

    if(select)
    begin
        out = in1;
    end 
    else 
    begin
        out = in0;
    end
    // $display("the result of this mux is = %d",out);

end
endmodule

module mux21_32bi(
    input [31:0] in0,
    input [31:0] in1,
    input select,
    output reg [31:0] out
);

always @(*) begin
            // $display("the data to be written mux is called \n");

    if(select)
    begin
        out = in1;
    end 
    else 
    begin
        out = in0;
    end
    // $display("data to be written in the register = %d",out);

end
endmodule