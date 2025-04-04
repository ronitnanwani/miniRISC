module instruction_decode(
   input [31:0] instruction,
   output reg[4:0] opcode,
   output reg[3:0] func_opcode,
   output reg[4:0] rs,rt,rd,
   output reg signed [31:0] imm,
   output reg signed [25:0] imm1
   );
   always@(*)begin
               //  $display("the instruction decode is called \n");
        imm[31:16] = 16'd0;
       imm[15:0] = instruction[15:0];

       if(imm[15]==1'b1) begin
         imm[31:16]=16'b1111111111111111;
       end

      //  $display("Immediate value = %d",imm);


       imm1<=instruction[25:0];
       rs<=instruction[26:22];
       rt<= instruction[21:17];
       rd<= instruction[16:12];
       func_opcode <= instruction[3:0];
       opcode<= instruction[31:27];
   end
   
endmodule