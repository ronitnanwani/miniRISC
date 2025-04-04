module controller(
    input reset,
    input [4:0] opcode,
    input [3:0] func_opcode,
    
    output reg reg_dst,
    output reg mem_read,
    output reg mem_to_reg,
    output reg mem_write,
    output reg is_branch,
    output reg [3:0] operation,
    output reg ALU_src,
    output reg reg_write,
    output reg isstackpop,
    output reg isstackpush
    );

    always@(*) begin

		if(reset) begin // reset all flags to zero
                // $display("the control unit is called bcz of reset \n");
            reg_dst = 0;
            
            mem_read = 0;
            mem_to_reg = 0;
            mem_write = 0;
            is_branch = 0;
            operation = 4'b0;
            ALU_src = 0;
            reg_write = 0;
		end
		// else begin
        //     case({opcode,func_opcode})
        //         7'b0000000: begin // R-Format - add
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0000; // addition operation
        //             ALU_src = 0;
        //             reg_write = 1;
        //         end

        //         7'b0000001: begin // R-Format - comp
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0011; // complement operation
        //             ALU_src = 0;
        //             reg_write = 1;
        //         end

        //         7'b0000010: begin // R-Format - and
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0001; // bitwise and operation
        //             ALU_src = 0;
        //             reg_write = 1;
        //         end

        //         7'b0000011: begin // R-Format - xor
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0010; // bitwise xor operation
        //             ALU_src = 0;
        //             reg_write = 1;
        //         end

        //         7'b0000100: begin // R-Format - shll
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0100; // left shift operation
        //             ALU_src = 1;
        //             reg_write = 1;
        //         end

        //         7'b0000101: begin // R-Format - shrl
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0101; // right shift operation
        //             ALU_src = 1;
        //             reg_write = 1;
        //         end

        //         7'b0000110: begin // R-Format - shllv
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0100; // left shift operation
        //             ALU_src = 0;
        //             reg_write = 1;
        //         end

        //         7'b0000111: begin // R-Format - shrlv
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0101; // right shift operation
        //             ALU_src = 0;
        //             reg_write = 1;
        //         end

        //         7'b0001000: begin // R-Format - shra
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0110; // right shift operation
        //             ALU_src = 1;
        //             reg_write = 1;
        //         end

        //         7'b0001001: begin // R-Format - shrav
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0110; // arithmetic right shift operation
        //             ALU_src = 0;
        //             reg_write = 1;
        //         end

        //         7'b0010000: begin // I-Format - addi
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0000; // add operation
        //             ALU_src = 1;
        //             reg_write = 1;
        //         end

        //         7'b0010001: begin // I-Format - compi
        //             reg_dst = 1;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0011; // comp operation
        //             ALU_src = 1;
        //             reg_write = 1;
        //         end

        //         7'b0100000: begin // Load/Store Format - load
        //             reg_dst = 0;
        //             mem_read = 1;
        //             mem_to_reg = 1;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 4'b0000; // add operation
        //             ALU_src = 1;
        //             reg_write = 1;
        //         end

        //         7'b0100001: begin // Load/Store Format - store
        //             reg_dst = 1'bx;
        //             mem_read = 0;
        //             mem_to_reg = 1'bx;
        //             mem_write = 1;
        //             is_branch = 0;
        //             operation = 4'b0000; // add operation
        //             ALU_src = 1;
        //             reg_write = 0;
        //         end

        //         7'b0110000: begin // B1 Format - b
        //             reg_dst = 1'bx;
        //             mem_read = 0;
        //             mem_to_reg = 1'bx;
        //             mem_write = 0;
        //             is_branch = 1;
        //             operation = 4'bx;
        //             ALU_src = 1'bx;
        //             reg_write = 1'b0;
        //         end

        //         7'b0110001: begin // B1 Format - bl
        //             reg_dst = 1'b0;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 1;
        //             operation = 4'b0000; // arithmetic right shift operation
        //             ALU_src = 1;
        //             reg_write = 1;
        //         end

        //         7'b0110010: begin // B1 Format - bcy
        //             reg_dst = 1'bx;
        //             mem_read = 0;
        //             mem_to_reg = 1'bx;
        //             mem_write = 0;
        //             is_branch = 1;
        //             operation = 4'bx;
        //             ALU_src = 1'bx;
        //             reg_write = 1'b0;
        //         end

        //         7'b0110011: begin // B1 Format - bncy
        //             reg_dst = 1'bx;
        //             mem_read = 0;
        //             mem_to_reg = 1'bx;
        //             mem_write = 0;
        //             is_branch = 1;
        //             operation = 4'bx;
        //             ALU_src = 1'bx;
        //             reg_write = 1'b0;

        //         end

        //         7'b1000000: begin // B2 Format - br
        //             reg_dst = 1'bx;
        //             mem_read = 0;
        //             mem_to_reg = 1'bx;
        //             mem_write = 0;
        //             is_branch = 1;
        //             operation = 4'bx;
        //             ALU_src = 1'bx;
        //             reg_write = 1'b0;
        //         end

        //         7'b1010000: begin // B3 Format - bltz
        //             reg_dst = 1'bx;
        //             mem_read = 0;
        //             mem_to_reg = 1'bx;
        //             mem_write = 0;
        //             is_branch = 1;
        //             operation = 4'b0111; // check if less than zero
        //             ALU_src = 0;
        //             reg_write = 0;
        //         end

        //         7'b1010001: begin // B3 Format - bz
        //             reg_dst = 1'bx;
        //             mem_read = 0;
        //             mem_to_reg = 1'bx;
        //             mem_write = 0;
        //             is_branch = 1;
        //             operation = 4'b1000; // check if zero
        //             ALU_src = 0;
        //             reg_write = 0;
        //         end

        //         7'b1010010: begin // B3 Format - bnz
        //             reg_dst = 1'bx;
        //             mem_read = 0;
        //             mem_to_reg = 1'bx;
        //             mem_write = 0;
        //             is_branch = 1;
        //             operation = 4'b1000; // check if zero
        //             ALU_src = 0;
        //             reg_write = 0;
        //         end
		// 			 default: begin
		// 				  reg_dst = 0;
        //             mem_read = 0;
        //             mem_to_reg = 0;
        //             mem_write = 0;
        //             is_branch = 0;
        //             operation = 0;
        //             ALU_src = 0;
        //             reg_write = 0;
		// 			 end
        //     endcase
        // end

        else begin
            case(opcode)
            5'b00000: begin
                case(func_opcode)
                    4'b0000: begin              // ADD R type R3=R1+R2
                        // $display("the control unit is called bcz of add \n");
                        isstackpop=0;
                        isstackpush=0;
                        reg_dst = 1;
                        mem_read = 0;
                        mem_to_reg = 0;
                        mem_write = 0;
                        is_branch = 0;
                        operation = 4'b0000; // addition operation
                        ALU_src = 0;
                        reg_write = 1;
                    end
                    4'b0001: begin
                        reg_dst = 1;
                        mem_read = 0;
                        mem_to_reg = 0;
                        mem_write = 0;
                        is_branch = 0;
                        operation = 4'b1010; // subtraction operation
                        ALU_src = 0;
                        reg_write = 1;
                    end
                    4'b0010: begin
                        reg_dst = 1;
                        mem_read = 0;
                        mem_to_reg = 0;
                        mem_write = 0;
                        is_branch = 0;
                        operation = 4'b0001; // bitwise and operation
                        ALU_src = 0;
                        reg_write = 1;
                    end
                    4'b0011: begin      //or
                        reg_dst = 1;
                        mem_read = 0;
                        mem_to_reg = 0;
                        mem_write = 0;
                        is_branch = 0;
                        operation = 4'b1001; // bitwise or operation
                        ALU_src = 0;
                        reg_write = 1;
                    end
                    4'b0100: begin
                         reg_dst = 1;
                        mem_read = 0;
                        mem_to_reg = 0;
                        mem_write = 0;
                        is_branch = 0;
                        operation = 4'b0010; // bitwise xor operation
                        ALU_src = 0;
                        reg_write = 1;
                    end
                    4'b0101: begin
                        // $display("Hello");
                        reg_dst = 1;
                        mem_read = 0;
                        mem_to_reg = 0;
                        mem_write = 0;
                        is_branch = 0;
                        operation = 4'b0011; // complement operation
                        ALU_src = 0;
                        reg_write = 1;
                    end
                    4'b0110: begin          //shift left arithmetic
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0100; // arithmetic left shift operation
                    ALU_src = 0;
                    reg_write = 1;
                    end
                    4'b0111: begin      //right shift arithmetic
                    reg_dst = 1;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0110; // arithmetic right shift operation
                    ALU_src = 0;
                    reg_write = 1;
                    end
                    4'b1000: begin          //right shift logical
                        reg_dst = 1;
                        mem_read = 0;
                        mem_to_reg = 0;
                        mem_write = 0;
                        is_branch = 0;
                        operation = 4'b0101; // right shift operation
                        ALU_src = 0;
                        reg_write = 1;
                    end
                    default: begin
                        reg_dst = 0;
                        mem_read = 0;
                        mem_to_reg = 0;
                        mem_write = 0;
                        is_branch = 0;
                        operation = 4'b0000;
                        ALU_src = 0;
                        reg_write = 0;
                        //all signals to zero
                    end


                endcase
            end
            5'b00001: begin                     //add immediate
                    reg_dst = 0;
                    isstackpush=0;
                    isstackpop=0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0000; // add operation
                    ALU_src = 1;
                    reg_write = 1;
            end
            5'b00010: begin                     //subtract immediate
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b1010; // subtract operation
                    ALU_src = 1;
                    reg_write = 1;
            end
            5'b00011: begin                 //and immediate
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0001; // and operation
                    ALU_src = 1;
                    reg_write = 1;
            end
            5'b00100: begin                 //or immediate
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b1001; // or operation
                    ALU_src = 1;
                    reg_write = 1;
            end
            5'b00101: begin             //xor immediate
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0010; // xor operation
                    ALU_src = 1;
                    reg_write = 1;

            end
            5'b00110: begin             //not immediate
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b1011; // not operation
                    ALU_src = 1;
                    reg_write = 1;
                
            end
            5'b00111: begin
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0100; // shift left arithmetic operation
                    ALU_src = 1;
                    reg_write = 1;
            end
            5'b01000: begin
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0110; // shift right arithmetic operation
                    ALU_src = 1;
                    reg_write = 1;   
            end
            5'b01001: begin
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0101; // shift right logical operation
                    ALU_src = 1;
                    reg_write = 1;     
            end
            5'b01010: begin                     //load
                    operation = 4'b0000;
                    isstackpop=0;
                    isstackpush=0;
                    mem_read <= 1;
                    reg_dst = 0;
                    mem_to_reg = 1;
                    mem_write = 0;
                    is_branch = 0;
                    ALU_src = 1;
                    reg_write = 1;
            end
            5'b01011: begin                     //store
                    reg_write = 0;
                    isstackpop=0;
                    isstackpush=0;
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write <= 1;
                    ALU_src = 1;
                    is_branch = 0;
                    operation = 4'b0000;
            end
            5'b01100: begin             //load SP
                    operation = 4'b0000;
                    mem_read <= 1;
                    reg_dst = 0;
                    mem_to_reg = 1;
                    mem_write = 0;
                    is_branch = 0;
                    ALU_src = 1;
                    reg_write = 1;
            end
            5'b01101: begin                     //store SP
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write <= 1;
                    ALU_src = 1;
                    is_branch = 0;
                    operation = 4'b0000;
                    reg_write = 0;
            end
            5'b01110: begin
                reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'b0111; // check if less than zero
                    ALU_src = 0;
                    reg_write = 0;
            end
            5'b01111: begin
                reg_dst = 1'bx;
                isstackpop=0;
                isstackpush=0;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'b0111; // check if less than zero
                    ALU_src = 0;
                    reg_write = 0;
            end
            5'b10000: begin
                reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'b0111; // check if less than zero
                    ALU_src = 0;
                    reg_write = 0;
            end
            5'b10001: begin
                reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    is_branch = 1;
                    operation = 4'b0111; // check if less than zero
                    ALU_src = 0;
                    reg_write = 0;
            end
            5'b10010: begin
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    ALU_src = 0;
                    is_branch = 0;
                    operation = 4'b0000;
                    reg_write = 0;
                    isstackpush <= 1;
                    isstackpop <= 0;
            end
            5'b10011: begin
                    reg_dst = 1'bx;
                    mem_read = 0;
                    mem_to_reg = 1'bx;
                    mem_write = 0;
                    ALU_src = 0;
                    is_branch = 0;
                    operation = 4'b0000;
                    reg_write = 0;
                    isstackpush <= 0;
                    isstackpop <= 1;
            end
            5'b10100: begin

            end
            5'b10101: begin

            end
            5'b10110: begin             //move
                    isstackpop=0;
                    isstackpush=0;
                    reg_dst = 0;
                    mem_read = 0;
                    mem_to_reg = 0;
                    mem_write = 0;
                    is_branch = 0;
                    operation = 4'b0000;
                    ALU_src = 1;
                    reg_write = 1;
            end
            5'b10111: begin

            end
            default: begin
                //All signal to 0;
            end

            

            endcase
        end

    end

endmodule