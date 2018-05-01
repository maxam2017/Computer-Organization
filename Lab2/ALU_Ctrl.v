
//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name:    ALU_Ctrl
//////////////////////////////////////////////////////////////////////////////////

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
       
//Select exact operation
always@(*)
begin
    case(ALUOp_i)
        3'b000:begin//R-format
            case(funct_i)
                6'b100000: ALUCtrl_o = 4'b0010; // ADD
                6'b100010: ALUCtrl_o = 4'b0110; // SUB
                6'b100100: ALUCtrl_o = 4'b0000; // AND
                6'b100101: ALUCtrl_o = 4'b0001; // OR
                6'b101010: ALUCtrl_o = 4'b0111; // SLT
            endcase
        end
        3'b001:begin
            ALUCtrl_o = 4'b0010; // ADDI
        end
        3'b010:begin
            ALUCtrl_o = 4'b0111; // SLTI
        end
        3'b011:begin
            ALUCtrl_o = 4'b0110; // BEQ
        end
    endcase
end

endmodule     
