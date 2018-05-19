
//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name: Simple_Single_CPU
//////////////////////////////////////////////////////////////////////////////////

module Simple_Single_CPU(
        clk_i,
	rst_i
        );
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
// PC
wire [31:0]pc_now;
wire [31:0]pc_mid;
wire [31:0]pc_next;
wire [31:0]pc_add4;
wire [31:0]pc_branch;
wire [31:0]pc_jump;
wire [31:0]instruct;

//reg
wire [31:0]RSdata;
wire [31:0]RTdata;
wire [4:0]RDaddr;
wire [31:0]write_data;

// for decode
wire [2:0]ALU_op;
wire ALUSrc;
wire RegWrite1;
wire RegWrite2;
wire RegWrite;
wire RegDst;
wire Branch;
wire Jump;
wire MemRead;
wire MemWrite;
wire [1:0]MemtoReg;
wire [3:0]ALU_Ctrl;

// I-format
wire [31:0]extend_16bit;
wire [31:0]extend_16bit_s;

// ALU
wire [31:0]alu_src2;
wire [31:0]result;
wire zero;

// data memory
wire [31:0]mem_data;
wire [31:0]mem_out;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),     
	.rst_i (rst_i),     
	.pc_in_i(pc_next),
	.pc_out_o(pc_now)
);

Instr_Memory IM(
        .pc_addr_i(pc_now),  
	.instr_o(instruct)    
);

/**********************************************
        choose reg_write_dest
     >RegDst is to choose rs or rt
     >mem_to_reg[1]==1 if jal ,so write to $31
**********************************************/
MUX_4to1 #(.size(5)) Mux_Reg_Dest(
        .data0_i(instruct[20:16]),
        .data1_i(instruct[15:11]),
        .data2_i(5'b11111),
        .data3_i(5'b11111),
        .select_i({MemtoReg[1],RegDst}),
        .data_o(RDaddr)
);

Reg_File Registers(
        .clk_i(clk_i), 
	.rst_i(rst_i) ,  
        .RSaddr_i(instruct[25:21]) ,  
        .RTaddr_i(instruct[20:16]) ,  
        .RDaddr_i(RDaddr) ,  
        .RDdata_i(write_data) ,
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata) ,
        .RTdata_o(RTdata)   
);

Decoder Decoder(
        .instr_op_i(instruct[31:26]), 
	.RegWrite_o(RegWrite1), 
	.ALU_op_o(ALU_op),   
	.ALUSrc_o(ALUSrc),   
	.RegDst_o(RegDst),   
        .Branch_o(Branch),
        .Jump_o(Jump),
	.MemRead_o(MemRead),
	.MemWrite_o(MemWrite),
	.MemtoReg_o(MemtoReg) 
);
/**********************************************
                alu
**********************************************/
ALU_Ctrl AC(
        .funct_i(instruct[5:0]),
        .ALUOp_i(ALU_op),
        .ALUCtrl_o(ALU_Ctrl)
);

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RTdata),
        .data1_i(extend_16bit),
        .select_i(ALUSrc),
        .data_o(alu_src2)
);
		
ALU ALU(
        .src1_i(RSdata),
	.src2_i(alu_src2),
	.ctrl_i(ALU_Ctrl),
	.result_o(result),
	.zero_o(zero)
	);

Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(result),
	.data_i(RTdata),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(mem_data)
	);
/**********************************************
                address to 32
**********************************************/
// branch	
Sign_Extend SE(
        .data_i(instruct[15:0]),
        .data_o(extend_16bit)
);

Shift_Left_Two_32 Shifter(
        .data_i(extend_16bit),
        .data_o(extend_16bit_s)
); 

Adder Adder2(
        .src1_i(pc_add4),
	.src2_i(extend_16bit_s),
	.sum_o(pc_branch)     
);

/**********************************************
                pc choice
**********************************************/
// +4 or branch
Adder Adder1(
        .src1_i(pc_now),  
	.src2_i(32'd4),
	.sum_o(pc_add4)
);
	
MUX_2to1 #(.size(32)) Mux_PC_Source1(
        .data0_i(pc_add4),
        .data1_i(pc_branch),
        .select_i(Branch & zero),
        .data_o(pc_mid)
        );
// or jump / jal
MUX_2to1 #(.size(32)) Mux_PC_Source2(
        .data0_i(pc_mid),
        .data1_i({pc_now[31:28],instruct[25:0],2'b00}),
        .select_i(Jump),
        .data_o(pc_jump)
);

// or jr
MUX_2to1 #(.size(32)) Mux_PC_Source3(
        .data0_i(pc_jump),
        .data1_i(RSdata),
        .select_i(instruct[31:26]==6'b000000 & instruct[5:0]==6'b001000),
        .data_o(pc_next)
);

/**********************************************
        no_op and jr is not allow reg_write
**********************************************/
MUX_2to1 #(.size(1)) Mux_Reg_Write(
        .data0_i(RegWrite1),
        .data1_i(1'b0),
        .select_i((instruct[31:26]==6'b000000 & instruct[5:0]==6'b001000) | (instruct[31:0]==32'b0)),
        .data_o(RegWrite)
);

/**********************************************
                write to reg
**********************************************/
// alu result or memory data or pc+4[jal]
MUX_4to1 #(.size(32)) Mux_Reg_Source(
        .data0_i(result),
        .data1_i(mem_data),
        .data2_i(pc_add4),
        .data3_i(32'b0),
        .select_i(MemtoReg),
        .data_o(write_data)
);

endmodule
		  


