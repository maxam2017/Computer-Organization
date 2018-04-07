`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name:    alu_top 
//////////////////////////////////////////////////////////////////////////////////

module alu(
           clk,           // system clock              (input)
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           clk;
input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

wire [31:0] p_result;
wire [31:0] p_cout;
wire set_less;

//cin == 1 only for a_invert=0 b_invert=1 (sub or less) because a-b = a+~b+1
alu_top b0(src1[0],src2[0],set_less,ALU_control[3],ALU_control[2],ALU_control[3]^ALU_control[2],ALU_control[1:0],p_result[0],p_cout[0]);
alu_top b1 (src1[1],src2[1],1'b0,ALU_control[3],ALU_control[2],p_cout[0],ALU_control[1:0],p_result[1],p_cout[1]);
alu_top b2 (src1[2],src2[2],1'b0,ALU_control[3],ALU_control[2],p_cout[1],ALU_control[1:0],p_result[2],p_cout[2]);
alu_top b3 (src1[3],src2[3],1'b0,ALU_control[3],ALU_control[2],p_cout[2],ALU_control[1:0],p_result[3],p_cout[3]);
alu_top b4 (src1[4],src2[4],1'b0,ALU_control[3],ALU_control[2],p_cout[3],ALU_control[1:0],p_result[4],p_cout[4]);
alu_top b5 (src1[5],src2[5],1'b0,ALU_control[3],ALU_control[2],p_cout[4],ALU_control[1:0],p_result[5],p_cout[5]);
alu_top b6 (src1[6],src2[6],1'b0,ALU_control[3],ALU_control[2],p_cout[5],ALU_control[1:0],p_result[6],p_cout[6]);
alu_top b7 (src1[7],src2[7],1'b0,ALU_control[3],ALU_control[2],p_cout[6],ALU_control[1:0],p_result[7],p_cout[7]);
alu_top b8 (src1[8],src2[8],1'b0,ALU_control[3],ALU_control[2],p_cout[7],ALU_control[1:0],p_result[8],p_cout[8]);
alu_top b9 (src1[9],src2[9],1'b0,ALU_control[3],ALU_control[2],p_cout[8],ALU_control[1:0],p_result[9],p_cout[9]);
alu_top b10 (src1[10],src2[10],1'b0,ALU_control[3],ALU_control[2],p_cout[9],ALU_control[1:0],p_result[10],p_cout[10]);
alu_top b11 (src1[11],src2[11],1'b0,ALU_control[3],ALU_control[2],p_cout[10],ALU_control[1:0],p_result[11],p_cout[11]);
alu_top b12 (src1[12],src2[12],1'b0,ALU_control[3],ALU_control[2],p_cout[11],ALU_control[1:0],p_result[12],p_cout[12]);
alu_top b13 (src1[13],src2[13],1'b0,ALU_control[3],ALU_control[2],p_cout[12],ALU_control[1:0],p_result[13],p_cout[13]);
alu_top b14 (src1[14],src2[14],1'b0,ALU_control[3],ALU_control[2],p_cout[13],ALU_control[1:0],p_result[14],p_cout[14]);
alu_top b15 (src1[15],src2[15],1'b0,ALU_control[3],ALU_control[2],p_cout[14],ALU_control[1:0],p_result[15],p_cout[15]);
alu_top b16 (src1[16],src2[16],1'b0,ALU_control[3],ALU_control[2],p_cout[15],ALU_control[1:0],p_result[16],p_cout[16]);
alu_top b17 (src1[17],src2[17],1'b0,ALU_control[3],ALU_control[2],p_cout[16],ALU_control[1:0],p_result[17],p_cout[17]);
alu_top b18 (src1[18],src2[18],1'b0,ALU_control[3],ALU_control[2],p_cout[17],ALU_control[1:0],p_result[18],p_cout[18]);
alu_top b19 (src1[19],src2[19],1'b0,ALU_control[3],ALU_control[2],p_cout[18],ALU_control[1:0],p_result[19],p_cout[19]);
alu_top b20 (src1[20],src2[20],1'b0,ALU_control[3],ALU_control[2],p_cout[19],ALU_control[1:0],p_result[20],p_cout[20]);
alu_top b21 (src1[21],src2[21],1'b0,ALU_control[3],ALU_control[2],p_cout[20],ALU_control[1:0],p_result[21],p_cout[21]);
alu_top b22 (src1[22],src2[22],1'b0,ALU_control[3],ALU_control[2],p_cout[21],ALU_control[1:0],p_result[22],p_cout[22]);
alu_top b23 (src1[23],src2[23],1'b0,ALU_control[3],ALU_control[2],p_cout[22],ALU_control[1:0],p_result[23],p_cout[23]);
alu_top b24 (src1[24],src2[24],1'b0,ALU_control[3],ALU_control[2],p_cout[23],ALU_control[1:0],p_result[24],p_cout[24]);
alu_top b25 (src1[25],src2[25],1'b0,ALU_control[3],ALU_control[2],p_cout[24],ALU_control[1:0],p_result[25],p_cout[25]);
alu_top b26 (src1[26],src2[26],1'b0,ALU_control[3],ALU_control[2],p_cout[25],ALU_control[1:0],p_result[26],p_cout[26]);
alu_top b27 (src1[27],src2[27],1'b0,ALU_control[3],ALU_control[2],p_cout[26],ALU_control[1:0],p_result[27],p_cout[27]);
alu_top b28 (src1[28],src2[28],1'b0,ALU_control[3],ALU_control[2],p_cout[27],ALU_control[1:0],p_result[28],p_cout[28]);
alu_top b29 (src1[29],src2[29],1'b0,ALU_control[3],ALU_control[2],p_cout[28],ALU_control[1:0],p_result[29],p_cout[29]);
alu_top b30 (src1[30],src2[30],1'b0,ALU_control[3],ALU_control[2],p_cout[29],ALU_control[1:0],p_result[30],p_cout[30]);
alu_top b31 (src1[31],src2[31],1'b0,ALU_control[3],ALU_control[2],p_cout[30],ALU_control[1:0],p_result[31],p_cout[31]);


assign set_less = src1[31]^~src2[31]^p_cout[30]; //a-b<0[MSB=1] -> a<b

always@( posedge clk or negedge rst_n )
begin
	if(!rst_n) begin
        //do nothing, wait for posedge
	end
	else begin
        result = p_result;
        zero = (result == 0)? 1 : 0;
        if(ALU_control[1:0] == 2'b11)begin
            //ignore carryout flag and overflow flag when doing slt
            cout = 0;
            overflow = 0;
        end
        else begin
            cout = p_cout[31];
            //overflow only when sub and add -> ALU_control[1:0] == 2'b10 and a^b=0 a^result=1 
            overflow = (ALU_control[1]&~ALU_control[0]) & ~((src1[31]^ALU_control[3])^(src2[31]^ALU_control[2])) & ((src1[31]^ALU_control[3])^(result[31]));
        end
    end
end

endmodule
