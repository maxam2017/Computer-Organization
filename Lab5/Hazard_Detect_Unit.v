//////////////////////////////////////////////////////////////////////////////////
// student ID: 0516013
// Module Name:    Hazard_Detect_Unit
//////////////////////////////////////////////////////////////////////////////////
module Hazard_Detect_Unit(
    MemRead_idex,
    op,
    rs,
    rt,
    rt_idex,
    branch,
    PCWrite,
    write_ifid,
    flush_ifid,
    flush_idex,
    flush_exmem
    );

input MemRead_idex;
input [5:0] op;
input [4:0] rs,rt,rt_idex;
input branch;

output PCWrite,write_ifid,flush_ifid,flush_idex,flush_exmem;

reg PCWrite,write_ifid,flush_ifid,flush_idex,flush_exmem;

always@(*) begin
    if(branch)
        {PCWrite,write_ifid,flush_ifid,flush_idex,flush_exmem} = 5'b11111;
    else
    begin
        if(MemRead_idex == 1'b1 && (rs == rt_idex || (rt == rt_idex && op != 6'b001000))) // addi: rt is just a value for addition
            {PCWrite,write_ifid,flush_ifid,flush_idex,flush_exmem} = 5'b00010;
        else
            {PCWrite,write_ifid,flush_ifid,flush_idex,flush_exmem} = 5'b11000;
    end
end

endmodule