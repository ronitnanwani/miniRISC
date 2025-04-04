module branch_logic(
    input is_branch,
    input signed [31:0] imm,
    
    input [9:0] PC,
    input [4:0] opcode,

    input signed [31:0] rs,
    output reg [9:0] PCN
);

always @(*) begin

    if(is_branch) begin
        if(opcode == 5'b10001) begin 
            if(rs==0)begin
                PCN = PC+imm;
            end 
            else begin
                PCN=PC +1;
            end        
        end
       

        else if(opcode==5'b01110) begin       // bcy L
            
                PCN = PC+imm;
        
            
        end

        else if(opcode==5'b01111) begin       // bncy L
            if(rs<0) begin
                PCN = PC+imm;
            end
            else begin 
                PCN = PC+1;
            end
        end

        

        else if(opcode==5'b10000) begin       // bltz rs, L
            if(rs>0) begin
                PCN = PC+imm;
            end
            else begin 
                PCN = PC+1;
            end
        end
        
       
        
        else begin                                                  // Normal Flow
            PCN = PC+1;
        end  
    end
    else begin

        if(PC!=13) begin         //set the value of parameter in if statement to the number of instructions in the instruction array
        PCN = PC+1;
        end
        if(PC==14) begin
            $finish;
        end                      //for GCD

        
        
        // if(PC!=59) begin         //set the value of parameter in if statement to the number of instructions in the instruction array
        // PCN = PC+1;
        // end
        // if(PC==59) begin
        //     $finish;
        // end                      //for sorting

    end
end
endmodule 

