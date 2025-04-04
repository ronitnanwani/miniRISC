module testbench;
    reg clk;
    reg reset;
    wire [15:0] result;
    toplevel dut(clk,reset,result);

    initial begin
        clk=0;
    end
    always #5 clk= ~clk;

    initial begin
        reset =1;
        #20;
        reset=0;
        #20;
        // $display("the result is %d \n",result);
        // #2000;   //choose appropriate delay so that all instruction are executed.
        // $finish;
    end



endmodule