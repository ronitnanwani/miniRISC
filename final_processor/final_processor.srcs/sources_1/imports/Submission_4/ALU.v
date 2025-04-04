

module ADDER(op1,op2,cin,result,cout,clk);
    input signed [31:0] op1;
    input signed [31:0] op2;
    input clk;
    input cin;
    output reg signed [31:0] result;
    output reg cout;
    wire signed [31:0] op;
    
    assign op = op2;
    reg signed [32:0] c;  
    reg signed [31:0] G;     
    reg signed [31:0] P;     

    always@(*)begin
        G = op1&op;
        P = op1^op;
        c[0] = cin;
        c[1] = G[0] | (P[0] & c[0]);
        c[2] = G[1] | (P[1] & c[1]);
        c[3] = G[2] | (P[2] & c[2]);
        c[4] = G[3] | (P[3] & c[3]);
        c[5] = G[4] | (P[4] & c[4]);
        c[6] = G[5] | (P[5] & c[5]);
        c[7] = G[6] | (P[6] & c[6]);
        c[8] = G[7] | (P[7] & c[7]);
        c[9] = G[8] | (P[8] & c[8]);
        c[10] = G[9] | (P[9] & c[9]);
        c[11] = G[10] | (P[10] & c[10]);
        c[12] = G[11] | (P[11] & c[11]);
        c[13] = G[12] | (P[12] & c[12]);
        c[14] = G[13] | (P[13] & c[13]);
        c[15] = G[14] | (P[14] & c[14]);
        c[16] = G[15] | (P[15] & c[15]);
        c[17] = G[16] | (P[16] & c[16]);
        c[18] = G[17] | (P[17] & c[17]);
        c[19] = G[18] | (P[18] & c[18]);
        c[20] = G[19] | (P[19] & c[19]);
        c[21] = G[20] | (P[20] & c[20]);
        c[22] = G[21] | (P[21] & c[21]);
        c[23] = G[22] | (P[22] & c[22]);
        c[24] = G[23] | (P[23] & c[23]);
        c[25] = G[24] | (P[24] & c[24]);
        c[26] = G[25] | (P[25] & c[25]);
        c[27] = G[26] | (P[26] & c[26]);
        c[28] = G[27] | (P[27] & c[27]);
        c[29] = G[28] | (P[28] & c[28]);
        c[30] = G[29] | (P[29] & c[29]);
        c[31] = G[30] | (P[30] & c[30]);
        c[32] = G[31] | (P[31] & c[31]); 
        result = op1^op^c[31:0];
        cout = c[32];  
    end
endmodule



module SUB(op1,op2,result,Cout,clk);


    input clk;
    input signed[31:0] op1;
    input signed[31:0] op2;
    output reg signed [31:0] result;
    output reg Cout;

    reg signed [31:0] a;
    reg signed [31:0] op;
    reg signed [31:0] b_2comp;
    wire signed [31:0] temp_diff;
    wire cout;
    ADDER SUBTRACT(a,b_2comp,1'b0,temp_diff,cout,clk);


    always@(*) begin

        a = op1;
        op = op2;
        b_2comp = (~op)+ 32'b00000000000000000000000000000001;
        result = temp_diff;
    end

endmodule	







module ALU(
    input signed [31:0]  inp1,
    input signed [31:0]  inp2,
	input [3:0] operation,
	input clk,
	input reset,
    output reg signed [31:0] out,
    output reg carryFlag,
    output reg zeroFlag,
    output reg signFlag
    );

reg c31,c32;
wire signed [31:0] sum,diff;
wire c1,c2;
ADDER addd (inp1,inp2,1'b0,sum,c1,clk);
SUB subbb(inp1,inp2,diff,c2,clk);
// Sequential block for remembering carry
always @(posedge clk or posedge reset) begin
	 if(reset) begin
		  carryFlag <= 1'b0;
	 end
	 else if(operation == 4'b0000) begin
		  carryFlag <= c32;
	 end
end

// Combinational block for ALU Logic
always @(*)
    if(reset==0)begin
	begin
            // $display("the alu is called \n");
		c31 = 1'b0;
		c32 = 1'b0;
		case(operation) 
			4'b0000: 	begin		//add
                        // $display("%d %d %d \n", inp1,inp2,operation);
						//{c31,out[30:0]}=inp1[30:0]+inp2[30:0];
						//{c32,out[31]}=inp1[31]+inp2[31]+c31;
						out=sum;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end
			4'b0001:	begin 	//and
						out=inp1&inp2;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end 
			4'b0010:	begin 	//xor
						out=inp1^inp2;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end 
			4'b0011:	begin		//comp
						out=(~inp1); // 2's complement of rt
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end 
			4'b0100:	begin		//shla
						out=inp1<<<inp2[0];
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end
			4'b0101:	begin		//shrl
						out=(inp1>>(inp2[0]));
						// $display("Input 2 is %d",inp2);
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end
			4'b0110:	begin		//shra
						out=inp1>>>inp2[0];
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end
			4'b0111:    begin   // less than 0
						out = inp1;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end  
			4'b1000:    begin   // equal to 0
						out = inp1;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
						end  

			4'b1001:	begin			//or operation
						out=inp1|inp2;
						zeroFlag=(out==0)?1'b1:1'b0;
						signFlag=out[31];
			end

			4'b1010:	begin			//subtract operation
						//out=inp1-inp2;
						out= diff;
						// signFlag=out[31];
			end	

			4'b1011: begin
				out = (~inp2);			//not immediate
				zeroFlag=(out==0)?1'b1:1'b0;
				signFlag=out[31];
			end
			default:                
						begin
						out = 32'b0;
						zeroFlag = 1'b0;
						signFlag = 1'b0;
						end
		endcase
    end
    end			
endmodule