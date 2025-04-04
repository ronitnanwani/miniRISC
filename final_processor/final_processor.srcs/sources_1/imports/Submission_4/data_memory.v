module data_mem(
    input clk,
    input reset,
    input mem_wr,
    input mem_rd,
    input [9:0]addr,
    input signed [31:0] input_data,
    output reg signed [31:0] output_data
);
    reg signed [31:0] dataMem[1023:0];

    always@(reset or mem_wr or mem_rd)begin

        if(reset && !mem_wr && !mem_rd)begin
                // $display("the data memory is called bcz of reset \n");
            dataMem[0]=0;
            dataMem[1]=1;
            dataMem[2]=2;
            dataMem[3]=3;
            dataMem[4]=10;
            dataMem[5]=5;
            dataMem[11]=15;
        end
        else if(mem_wr) begin
                // $display("the data memory is called bcz of mem_wr \n");
                $display("Data to write = %d at address = %d",input_data,addr);
                // $display("")
            dataMem[addr]=input_data;
        end
        else if(mem_rd) begin
                // $display("the data memory is called bcz of mem_rd \n");
            output_data= dataMem[addr];
                $display("Address to read from  = %d Value read = %d",addr,output_data);
        end
    end
endmodule