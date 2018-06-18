
//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name:    Adder
//////////////////////////////////////////////////////////////////////////////////

module Adder(
    src1_i,
	src2_i,
	sum_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
output [32-1:0]	 sum_o;

//Internal Signals
wire    [32-1:0]	 sum_o;

//Parameter
wire	[31:0]sum;
wire		zero;
//Main function
ALU alu(src1_i,src2_i,4'b0010,sum,zero);
assign sum_o = sum;
endmodule