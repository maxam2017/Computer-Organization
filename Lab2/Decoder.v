
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
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

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
        end
		6'b001000:begin
			// ADDI
			ALU_op_o = 3'b001;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			RegDst_o = 1'b0;
			Branch_o = 1'b0;
        end
		6'b001010:begin
			// SLTI
			ALU_op_o = 3'b010;
			ALUSrc_o = 1'b1;
			RegWrite_o = 1'b1;
			RegDst_o = 1'b0;
			Branch_o = 1'b0;
        end
		6'b000100:begin
			// BEQ
			ALU_op_o = 3'b011;
			ALUSrc_o = 1'b0;
			RegWrite_o = 1'b0;
			RegDst_o = 1'b0;
			Branch_o = 1'b1;
        end        
    endcase
end
endmodule
