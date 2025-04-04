module toplevel (
    input clk,
    input reset,
	output signed [15:0] result
    );
	 
	reg [31:0] program_output;
	
	wire [9:0] PC;    //handles 2^10 = 1024 instructions
	wire [9:0] PCN;  
    wire [31:0] instruction;
	wire signed [31:0] output_data_from_stack;

    // Parts of instructions obtained from the instruction array
	wire [4:0] opcode;
    wire [3:0] func_opcode;
    wire [4:0] rs,rt,rd; 
    wire signed [31:0] imm;
    wire signed [25:0] imm1;
	wire isstackpush;
	wire isstackpop;
	
    // Control Signals output from the controller
	wire [3:0] alu_operation;
	wire reg_dst, mem_read, mem_to_reg, mem_write, is_branch, reg_write, ALU_src;

	// Data to be written to the register file
	wire signed [31:0] reg_write_data;

	// Address to be written to
	wire [4:0] reg_write_addr;

	// Data read from the register file
	wire signed [31:0] reg_read_data_1, reg_read_data_2;
	
    // Flags from the ALU
	wire zeroFlag, carryFlag, signFlag;
	wire signed [31:0] alu_result;

	// Output from the Data memory block
	wire signed [31:0] mem_data_out;
    reg [3:0] step;
	
    //Sets NPC to PC+1; if reset then sets NPC to 0;
	program_counter pc (
      .clk(clk), 
		.reset(reset),
		.PCN(PCN),
		.PC(PC)
    );	

    //Given PC gives us the instruction at index PC in the instruction memory array													
	instruction_mem IF (
      .clk(clk), 
		.reset(reset),
		.pc(PC), 
	   .instr(instruction)
    );
	
	instruction_decode ID (
        .instruction(instruction),
        .opcode(opcode),
		.func_opcode(func_opcode),
		.rs(rs),
		.rt(rt),
        .rd(rd),
		.imm(imm),
        .imm1(imm1)
    );

	stack stackop (
		.data(reg_read_data_1),
		.isstackpush(isstackpush),
		.isstackpop(isstackpop),
		.reset_stack(reset),
		.output_data(output_data_from_stack)
	);
	
	controller CU (
		.reset(reset),
		.opcode(opcode),
		.func_opcode(func_opcode),
		.reg_dst(reg_dst),
		.mem_read(mem_read),
        .mem_to_reg(mem_to_reg),
		.mem_write(mem_write),
		.is_branch(is_branch),
		.operation(alu_operation),
		.ALU_src(ALU_src),
		.reg_write(reg_write),
		.isstackpop(isstackpop),
		.isstackpush(isstackpush)
    );

	data_mem DM (
        .clk(clk), 
		.reset(reset), 
		.mem_wr(mem_write), 
		.mem_rd(mem_read), 
		.addr(alu_result[9:0]),
		.input_data(reg_read_data_2), 
		.output_data(mem_data_out)
    );
	 
	mux21_32bi write_to_reg_mux (
		.in1(mem_data_out),
		.in0(alu_result),
		.select(mem_to_reg),
		.out(reg_write_data)
	);

	mux21_5bit reg_dst_mux (
		.in1(rd),
		.in0(rt),
		.select(reg_dst),
		.out(reg_write_addr)
	);
	
	registerfile RB (
        .clk(clk),
		.reset(reset),
		.reg_write(reg_write),
		.wrAddr(reg_write_addr), 
		.wrData(reg_write_data),
		.rdAddrA(rs),
		.rdAddrB(rt),
		.rdDataA(reg_read_data_1),
		.rdDataB(reg_read_data_2),
		.write_temp_from_stack(output_data_from_stack)
    );
					  
	wire [31:0] alu_input_2;
	mux21_32bit alu_input_mux (
		.in0(reg_read_data_2),
		.in1(imm),
		.select(ALU_src),
		.out(alu_input_2)
	);		 			  

	ALU ALU (
        .inp1(reg_read_data_1),
		.inp2(alu_input_2),
		.operation(alu_operation),
		.clk(clk),
		.reset(reset),
		.out(alu_result),
		.carryFlag(carryFlag),
		.zeroFlag(zeroFlag), 
		.signFlag(signFlag)
	
    );
	
	branch_logic BL (
		 .is_branch(is_branch),
	    .opcode(opcode),
	    
	    
        // .address(reg_read_data_1),
        .imm(imm),
		.rs(reg_read_data_1),
		
    
    

    

    
    
        .PC(PCN),
        .PCN(PC)
    );
	 
	 assign result = reg_read_data_2;
     always @(posedge clk)begin
        // $display(
        //     "the result is is sis iisiisi %d \n",result
        // );

        // $display("Load Write data = %d Write addr = %d",reg_write_data,reg_write_addr);
		// $display("Store Write data = %d Write addr = %d ",reg_read_data_2,alu_result[9:0]);
        // $display("ALU result is = %d",alu_result);
		// $display("Reg read data 2 = %d",reg_read_data_2);
     end

endmodule