`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name:  Pipe_CPU_1
//////////////////////////////////////////////////////////////////////////////////

module Pipe_CPU_1(
    clk_i,
    rst_i
    );
    
/****************************************
I/O ports
****************************************/
input clk_i;
input rst_i;

/****************************************
Internal signal
****************************************/
/**** IF stage ****/
wire [31:0]pc_now,pc_next,pc_add4,instruct;

/**** ID stage ****/
wire [31:0]pc_ifid,instr_ifid,RSdata,RTdata,extend_16bit;
//control signal
wire  RegWrite,ALU_src,RegDst,Branch,MemRead,MemWrite,MemReg;
wire [2:0] ALU_op;

/**** EX stage ****/
wire [31:0] pc_idex,RSdata_idex,RTdata_idex,extend_16bit_idex,extend_16bit_s;
wire [9:0] instr_idex;
wire [4:0] Write_addr;
wire [5:0] instr_idex2;
wire [31:0] alu_src2,result,pc_branch;
//control signal
wire RegWrite_idex,ALUsrc_idex,RegDst_idex,Branch_idex,MemRead_idex,MemWrite_idex,MemReg_idex;
wire zero;
wire [2:0] ALU_op_idex;
wire [3:0] alu_ctrl;

/**** MEM stage ****/
wire [31:0] pc_branch_exmem,result_exmem,RTdata_exmem;
wire [31:0] mem_data;
wire [4:0] Write_addr_exmem;
//control signal
wire RegWrite_exmem,Branch_exmem,MemRead_exmem,MemWrite_exmem,MemReg_exmem,zero_exmem;

/**** WB stage ****/
wire [31:0] mem_data_memwb,result_memwb,write_data;
wire [4:0]  Write_addr_memwb;
//control signal
wire RegWrite_memwb,MemReg_memwb;

/****************************************
Instantiate modules
****************************************/
//Instantiate the components in IF stage
MUX_2to1 #(.size(32)) Mux0(
    .data0_i(pc_add4),
    .data1_i(pc_branch_exmem),
    .select_i(Branch_exmem & zero_exmem),
    .data_o(pc_next)
);

ProgramCounter PC(
    .clk_i(clk_i),
	.rst_i (rst_i),     
	.pc_in_i(pc_next),
	.pc_out_o(pc_now)
);

Instruction_Memory IM(
    .addr_i(pc_now),  
	.instr_o(instruct)
);
			
Adder Add_pc(
    .src1_i(pc_now),
	.src2_i(32'd4),
	.sum_o(pc_add4)
);

Pipe_Reg #(.size(64)) IF_ID(       //N is the total length of input/output
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i({pc_add4,instruct}),
    .data_o({pc_ifid,instr_ifid})
);

//Instantiate the components in ID stage
Reg_File RF(
    .clk_i(clk_i),
	.rst_i(rst_i),
    .RSaddr_i(instr_ifid[25:21]),
    .RTaddr_i(instr_ifid[20:16]),
    .RDaddr_i(Write_addr_memwb),
    .RDdata_i(write_data),
    .RegWrite_i (RegWrite_memwb),
    .RSdata_o(RSdata),
    .RTdata_o(RTdata)
);

Decoder Control(
    .instr_op_i(instr_ifid[31:26]), 
	.RegWrite_o(RegWrite), 
	.ALU_op_o(ALU_op),
	.ALUSrc_o(ALU_src), 
	.RegDst_o(RegDst),
    .Branch_o(Branch),
	.MemRead_o(MemRead),
	.MemWrite_o(MemWrite),
	.MemtoReg_o(MemReg) 
);

Sign_Extend Sign_Extend(
    .data_i(instr_ifid[15:0]),
    .data_o(extend_16bit)
);

Pipe_Reg #(.size(154)) ID_EX(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i({RegWrite,ALU_op,ALU_src,RegDst,Branch,MemRead,MemWrite,MemReg,pc_ifid,RSdata,RTdata,extend_16bit,instr_ifid[20:11],instr_ifid[5:0]}),
    .data_o({RegWrite_idex,ALU_op_idex,ALUsrc_idex,RegDst_idex,Branch_idex,MemRead_idex,MemWrite_idex,MemReg_idex,pc_idex,RSdata_idex,RTdata_idex,extend_16bit_idex,instr_idex,instr_idex2})
);

//Instantiate the components in EX stage	   
Shift_Left_Two_32 Shifter(
    .data_i(extend_16bit_idex),
    .data_o(extend_16bit_s)
);

ALU ALU(
    .src1_i(RSdata_idex),
	.src2_i(alu_src2),
	.ctrl_i(alu_ctrl),
	.result_o(result),
	.zero_o(zero)
);
		
ALU_Ctrl Controler(
    .funct_i(instr_idex2),
    .ALUOp_i(ALU_op_idex),
    .ALUCtrl_o(alu_ctrl)
);

MUX_2to1 #(.size(32)) Mux1(
    .data0_i(RTdata_idex),
    .data1_i(extend_16bit_idex),
    .select_i(ALUsrc_idex),
    .data_o(alu_src2)
);
		
MUX_2to1 #(.size(5)) Mux2(
    .data0_i(instr_idex[9:5]),
    .data1_i(instr_idex[4:0]),
    .select_i(RegDst_idex),
    .data_o(Write_addr)
);

Adder Add_pc_branch(
    .src1_i(pc_idex),
	.src2_i(extend_16bit_s),
	.sum_o(pc_branch)
);

Pipe_Reg #(.size(107)) EX_MEM(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i({RegWrite_idex,Branch_idex,MemRead_idex,MemWrite_idex,MemReg_idex,zero,pc_branch,result,RTdata_idex,Write_addr}),
    .data_o({RegWrite_exmem,Branch_exmem,MemRead_exmem,MemWrite_exmem,MemReg_exmem,zero_exmem,pc_branch_exmem,result_exmem,RTdata_exmem,Write_addr_exmem})
);

//Instantiate the components in MEM stage
Data_Memory DM(
    .clk_i(clk_i),
    .addr_i(result_exmem),
    .data_i(RTdata_exmem),
    .MemRead_i(MemRead_exmem),
    .MemWrite_i(MemWrite_exmem),
    .data_o(mem_data)
);

Pipe_Reg #(.size(71)) MEM_WB(
    .clk_i(clk_i),
    .rst_i(rst_i),
    .data_i({RegWrite_exmem,Write_addr_exmem,MemReg_exmem,result_exmem,mem_data}),
    .data_o({RegWrite_memwb,Write_addr_memwb,MemReg_memwb,result_memwb,mem_data_memwb})
);

//Instantiate the components in WB stage
MUX_2to1 #(.size(32)) Mux3(
    .data0_i(result_memwb),
    .data1_i(mem_data_memwb),
    .select_i(MemReg_memwb),
    .data_o(write_data)
);

/****************************************
signal assignment
****************************************/

endmodule

