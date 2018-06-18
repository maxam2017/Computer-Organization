
//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name:    ALU
//////////////////////////////////////////////////////////////////////////////////

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
reg             zero_o;

//Parameter
wire [31:0] result;
wire [31:0] cout;
wire set_less;
//Main function
alu_top b0 (src1_i[0],src2_i[0],set_less,ctrl_i[3],ctrl_i[2],ctrl_i[3]^ctrl_i[2],ctrl_i[1:0],result[0],cout[0]);
alu_top b1 (src1_i[1],src2_i[1],1'b0,ctrl_i[3],ctrl_i[2],cout[0],ctrl_i[1:0],result[1],cout[1]);
alu_top b2 (src1_i[2],src2_i[2],1'b0,ctrl_i[3],ctrl_i[2],cout[1],ctrl_i[1:0],result[2],cout[2]);
alu_top b3 (src1_i[3],src2_i[3],1'b0,ctrl_i[3],ctrl_i[2],cout[2],ctrl_i[1:0],result[3],cout[3]);
alu_top b4 (src1_i[4],src2_i[4],1'b0,ctrl_i[3],ctrl_i[2],cout[3],ctrl_i[1:0],result[4],cout[4]);
alu_top b5 (src1_i[5],src2_i[5],1'b0,ctrl_i[3],ctrl_i[2],cout[4],ctrl_i[1:0],result[5],cout[5]);
alu_top b6 (src1_i[6],src2_i[6],1'b0,ctrl_i[3],ctrl_i[2],cout[5],ctrl_i[1:0],result[6],cout[6]);
alu_top b7 (src1_i[7],src2_i[7],1'b0,ctrl_i[3],ctrl_i[2],cout[6],ctrl_i[1:0],result[7],cout[7]);
alu_top b8 (src1_i[8],src2_i[8],1'b0,ctrl_i[3],ctrl_i[2],cout[7],ctrl_i[1:0],result[8],cout[8]);
alu_top b9 (src1_i[9],src2_i[9],1'b0,ctrl_i[3],ctrl_i[2],cout[8],ctrl_i[1:0],result[9],cout[9]);
alu_top b10 (src1_i[10],src2_i[10],1'b0,ctrl_i[3],ctrl_i[2],cout[9],ctrl_i[1:0],result[10],cout[10]);
alu_top b11 (src1_i[11],src2_i[11],1'b0,ctrl_i[3],ctrl_i[2],cout[10],ctrl_i[1:0],result[11],cout[11]);
alu_top b12 (src1_i[12],src2_i[12],1'b0,ctrl_i[3],ctrl_i[2],cout[11],ctrl_i[1:0],result[12],cout[12]);
alu_top b13 (src1_i[13],src2_i[13],1'b0,ctrl_i[3],ctrl_i[2],cout[12],ctrl_i[1:0],result[13],cout[13]);
alu_top b14 (src1_i[14],src2_i[14],1'b0,ctrl_i[3],ctrl_i[2],cout[13],ctrl_i[1:0],result[14],cout[14]);
alu_top b15 (src1_i[15],src2_i[15],1'b0,ctrl_i[3],ctrl_i[2],cout[14],ctrl_i[1:0],result[15],cout[15]);
alu_top b16 (src1_i[16],src2_i[16],1'b0,ctrl_i[3],ctrl_i[2],cout[15],ctrl_i[1:0],result[16],cout[16]);
alu_top b17 (src1_i[17],src2_i[17],1'b0,ctrl_i[3],ctrl_i[2],cout[16],ctrl_i[1:0],result[17],cout[17]);
alu_top b18 (src1_i[18],src2_i[18],1'b0,ctrl_i[3],ctrl_i[2],cout[17],ctrl_i[1:0],result[18],cout[18]);
alu_top b19 (src1_i[19],src2_i[19],1'b0,ctrl_i[3],ctrl_i[2],cout[18],ctrl_i[1:0],result[19],cout[19]);
alu_top b20 (src1_i[20],src2_i[20],1'b0,ctrl_i[3],ctrl_i[2],cout[19],ctrl_i[1:0],result[20],cout[20]);
alu_top b21 (src1_i[21],src2_i[21],1'b0,ctrl_i[3],ctrl_i[2],cout[20],ctrl_i[1:0],result[21],cout[21]);
alu_top b22 (src1_i[22],src2_i[22],1'b0,ctrl_i[3],ctrl_i[2],cout[21],ctrl_i[1:0],result[22],cout[22]);
alu_top b23 (src1_i[23],src2_i[23],1'b0,ctrl_i[3],ctrl_i[2],cout[22],ctrl_i[1:0],result[23],cout[23]);
alu_top b24 (src1_i[24],src2_i[24],1'b0,ctrl_i[3],ctrl_i[2],cout[23],ctrl_i[1:0],result[24],cout[24]);
alu_top b25 (src1_i[25],src2_i[25],1'b0,ctrl_i[3],ctrl_i[2],cout[24],ctrl_i[1:0],result[25],cout[25]);
alu_top b26 (src1_i[26],src2_i[26],1'b0,ctrl_i[3],ctrl_i[2],cout[25],ctrl_i[1:0],result[26],cout[26]);
alu_top b27 (src1_i[27],src2_i[27],1'b0,ctrl_i[3],ctrl_i[2],cout[26],ctrl_i[1:0],result[27],cout[27]);
alu_top b28 (src1_i[28],src2_i[28],1'b0,ctrl_i[3],ctrl_i[2],cout[27],ctrl_i[1:0],result[28],cout[28]);
alu_top b29 (src1_i[29],src2_i[29],1'b0,ctrl_i[3],ctrl_i[2],cout[28],ctrl_i[1:0],result[29],cout[29]);
alu_top b30 (src1_i[30],src2_i[30],1'b0,ctrl_i[3],ctrl_i[2],cout[29],ctrl_i[1:0],result[30],cout[30]);
alu_top b31 (src1_i[31],src2_i[31],1'b0,ctrl_i[3],ctrl_i[2],cout[30],ctrl_i[1:0],result[31],cout[31]);

assign set_less = src1_i[31]^~src2_i[31]^cout[30];

always@(*)
begin
	if(ctrl_i == 4'b1000)
		result_o = src1_i * src2_i[31:0];
	else
		result_o = result;
	zero_o = (result_o == 0)? 1 : 0;
end
endmodule