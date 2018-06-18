
//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name: ProgramCounter
//////////////////////////////////////////////////////////////////////////////////

module ProgramCounter(
    clk_i,
	rst_i,
	pc_in_i,
	PCWrite,
	pc_out_o
	);
     
//I/O ports
input           clk_i;
input	        rst_i;
input  [32-1:0] pc_in_i;
input 			PCWrite;
output [32-1:0] pc_out_o;
 
//Internal Signals
reg    [32-1:0] pc_out_o;
 
//Parameter

    
//Main function
always @(posedge clk_i) begin
    if(~rst_i)
	    pc_out_o <= 0;
	else
		if(PCWrite)
	    	pc_out_o <= pc_in_i;
		else
			pc_out_o <= pc_out_o;
end

endmodule



                    
                    