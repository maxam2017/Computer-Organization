//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name:    Forwarding_Unit
//////////////////////////////////////////////////////////////////////////////////
module Forwarding_Unit(
    RegWrite_exmem,
    RegWrite_memwb,
    rs_idex,
    rt_idex,
    rd_exmem,
    rd_memwb,
    forwardA,
    forwardB
);

input RegWrite_exmem;
input RegWrite_memwb;
input [4:0] rs_idex,rt_idex,rd_exmem,rd_memwb;
output [1:0] forwardA,forwardB;

reg [1:0] forwardA,forwardB;

// rs forwarding
always@(*) begin
    if(RegWrite_exmem == 1'b1 && rd_exmem != 5'b00000 && rs_idex == rd_exmem)
        forwardA <= 2'b01;
    else if(RegWrite_memwb == 1'b1 && rd_memwb != 5'b00000 && rs_idex == rd_memwb)
        forwardA <= 2'b10;
    else
        forwardA <= 2'b00;
end

// rt forwarding
always@(*) begin
    if(RegWrite_exmem == 1'b1 && rd_exmem != 5'b00000 && rt_idex == rd_exmem)
        forwardB <= 2'b01;
    else if(RegWrite_memwb == 1'b1 && rd_memwb != 5'b00000 && rt_idex == rd_memwb)
        forwardB <= 2'b10;
    else
        forwardB <= 2'b00;
end

endmodule