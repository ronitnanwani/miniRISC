module stack(input signed [31:0] data,input isstackpush,input isstackpop,input reset_stack,output reg signed [31:0] output_data);

    reg signed [31:0] stack_mem[1023:0];
    integer cntr;

    always@(*) begin
        if(reset_stack) begin
            cntr=0;
        end
        if(isstackpush) begin
            // $display("Cntr = %d ",cntr);
            // $display("------- = %d",data);
            stack_mem[cntr]=data;
            cntr=cntr+1;
            // $display("Cntr = %d ",cntr);
        end
        else if(isstackpop) begin
            output_data = stack_mem[cntr-1];
            // $display("Output_data from stack = %d",output_data);
            // $display("Cntr = %d ----",cntr);
            cntr=cntr-1;
            // $display("Cntr = %d ----",cntr);
        end
    end
endmodule