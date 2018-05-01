
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
wire [31:0]pc_next;
wire [31:0]pc_add4;
wire [31:0]pc_branch;
wire [31:0]instruct;

//reg
wire [31:0]RSdata;
wire [31:0]RTdata;
wire [4:0]RDaddr;

// for decode
wire [2:0]ALU_op;
wire ALUSrc;
wire RegWrite;
wire RegDst;
wire Branch;
wire [3:0]ALU_Ctrl;

// I-format
wire [31:0]extend_16bit;
wire [31:0]extend_16bit_s;

// ALU
wire [31:0]alu_src2;
wire [31:0]result;
wire zero;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	.rst_i (rst_i),     
	.pc_in_i(pc_next),
	.pc_out_o(pc_now)
	);
	
Adder Adder1(
        .src1_i(pc_now),  
	.src2_i(32'd4),
	.sum_o(pc_add4)
	);
	
Instr_Memory IM(
        .pc_addr_i(pc_now),  
	.instr_o(instruct)    
	);

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instruct[20:16]),
        .data1_i(instruct[15:11]),
        .select_i(RegDst),
        .data_o(RDaddr)
        );
		
Reg_File RF(
        .clk_i(clk_i),   
	.rst_i(rst_i) ,  
        .RSaddr_i(instruct[25:21]) ,  
        .RTaddr_i(instruct[20:16]) ,  
        .RDaddr_i(RDaddr) ,  
        .RDdata_i(result)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(RSdata) ,  
        .RTdata_o(RTdata)   
        );
	
Decoder Decoder(
        .instr_op_i(instruct[31:26]), 
	.RegWrite_o(RegWrite), 
	.ALU_op_o(ALU_op),   
	.ALUSrc_o(ALUSrc),   
	.RegDst_o(RegDst),   
        .Branch_o(Branch)   
	);

ALU_Ctrl AC(
        .funct_i(instruct[5:0]),
        .ALUOp_i(ALU_op),
        .ALUCtrl_o(ALU_Ctrl)
        );
	
Sign_Extend SE(
        .data_i(instruct[15:0]),
        .data_o(extend_16bit)
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
		
Adder Adder2(
        .src1_i(pc_add4),   
	.src2_i(extend_16bit_s),    
	.sum_o(pc_branch)     
	);
		
Shift_Left_Two_32 Shifter(
        .data_i(extend_16bit),
        .data_o(extend_16bit_s)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(pc_add4),
        .data1_i(pc_branch),
        .select_i(Branch & zero),
        .data_o(pc_next)
        );

endmodule
		  


