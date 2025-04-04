module registerfile(
	input reset,
	input clk,
    input reg_write,			// control line for register writing
    input [4:0] wrAddr,		// Address to write in 
    input signed [31:0]  wrData,    // Write Data
    input [4:0] rdAddrA,    //Read Address 1
    output reg signed [31:0] rdDataA,  // Read Data 1
    input [4:0] rdAddrB,    //Read Address 2
    output reg signed [31:0] rdDataB, // Read Data 2
	input signed [31:0] write_temp_from_stack
  	);

	reg signed [31:0] registerBank[31:0]; 
    integer i;
				
   always @(*)
		begin
        // $display("the register file is called \n");
			if(rdAddrB>=32) 
				rdDataB=32'hxxxxxxxx;       //Not possible, kept just to prevent latch
			else
				rdDataB=registerBank[rdAddrB];          //Read Data
				
			if(rdAddrA>=32) 
				rdDataA=32'hxxxxxxxx;
			else
				rdDataA=registerBank[rdAddrA];          //Read Data
			
		end
		
   always @(posedge clk or posedge reset)            //Write Operation
		begin
			registerBank[31]=write_temp_from_stack;
		  if (reset) begin
			   for(i=0;i<32;i=i+1) begin	
					registerBank[i] = 32'b0;
				end
                // registerBank[0]=32'd1;
				registerBank[1]=32'd14;
                registerBank[2]=32'd2;
                registerBank[3]=32'd3;
				registerBank[5]=32'd5;
                registerBank[7]=32'd7;
				registerBank[16]=32'd16;


		  end
        else if (reg_write)  begin
                // $display("kjsdfkjsd %d %d",wrAddr,wrData);
				registerBank[wrAddr] <= wrData;
				$display("Value in register %d is %d",wrAddr,wrData);
		end
		end
		
endmodule