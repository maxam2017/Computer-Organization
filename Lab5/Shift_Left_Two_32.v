
//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name: Shift_Left_Two_32
//////////////////////////////////////////////////////////////////////////////////

module Shift_Left_Two_32(
    data_i,
    data_o
    );

//I/O ports                    
input [32-1:0] data_i;
output [32-1:0] data_o;

//shift left 2
assign data_o = data_i << 2;

endmodule