module program_counter(input clk,input reset,input [9:0] PC,output reg [9:0] PCN);
    always@(posedge clk) begin
                // $display("the program counter is called %d\n",PC);

        if(reset ) begin
            // $display("reset pcn \n");
            // PC=9'd0;
            PCN<=10'b0000000000;
        end
        else begin
            PCN<=PC;
        end


    end
endmodule