
//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name:  Decoder
//////////////////////////////////////////////////////////////////////////////////

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	Branch_o,
	Jump_o,
	MemRead_o,
	MemWrite_o,
	MemtoReg_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
output         Jump_o;
output         MemRead_o;
output         MemWrite_o;
output [2-1:0] MemtoReg_o;
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;
reg            Jump_o;
reg            MemRead_o;
reg            MemWrite_o;
reg    [2-1:0] MemtoReg_o;

//Parameter


//Main function
always@(*)
begin
    case(instr_op_i)
        6'b000000:begin
			// R-format
			ALU_op_o = 3'b000;
			ALUSrc_o = 1'b0;
			RegWrite_o = 1'b1;
			RegDst_o = 1'b1;
			Branch_o = 1'b0;
			Jump_o = 1'b0;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
        end
		6'b001000:begin
			// ADDI
			ALU_op_o = 3'b001;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			RegDst_o = 1'b0;
			Branch_o = 1'b0;
			Jump_o = 1'b0;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
        end
		6'b001010:begin
			// SLTI
			ALU_op_o = 3'b010;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			RegDst_o = 1'b0;
			Branch_o = 1'b0;
			Jump_o = 1'b0;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
        end
		6'b000100:begin
			// BEQ
			ALU_op_o = 3'b011;
			ALUSrc_o = 1'b0;
			RegWrite_o = 1'b0;
			RegDst_o = 1'b0;
			Branch_o = 1'b1;
			Jump_o = 1'b0;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
        end        
		6'b100011:begin
			//lw
			ALU_op_o = 3'b001;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			RegDst_o = 1'b0;
			Branch_o = 1'b0;
			Jump_o = 1'b0;
			MemRead_o = 1'b1;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b01;
		end
		6'b101011:begin
			//sw
			ALU_op_o = 3'b001;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b0;
			RegDst_o = 1'b0;
			Branch_o = 1'b0;
			Jump_o = 1'b0;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b1;
			MemtoReg_o = 2'b00;
		end
		6'b000010:begin
			//jump
			ALU_op_o = 3'b011; // not important
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b0;
			RegDst_o = 1'b0;
			Branch_o = 1'b0;
			Jump_o = 1'b1;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b00;
		end
		6'b000011:begin
			//jal
			ALU_op_o = 3'b011; // not important
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			RegDst_o = 1'b0;
			Branch_o = 1'b0;
			Jump_o = 1'b1;
			MemRead_o = 1'b0;
			MemWrite_o = 1'b0;
			MemtoReg_o = 2'b10;
		end
    endcase
end
endmodule