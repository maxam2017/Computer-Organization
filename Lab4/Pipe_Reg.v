`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name: Pipe_Reg
//////////////////////////////////////////////////////////////////////////////////

module Pipe_Reg(
    clk_i,
    rst_i,
    data_i,
    data_o
    );
					
parameter size = 0;

input   clk_i;		  
input   rst_i;
input   [size-1:0] data_i;
output reg  [size-1:0] data_o;
	  
always@(posedge clk_i) begin
    if(~rst_i)
        data_o <= 0;
    else
        data_o <= data_i;
end

endmodule	