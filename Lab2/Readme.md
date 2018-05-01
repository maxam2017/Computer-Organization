## Decode table
instruction|ALU_op[3]|ALUSrc[1]|RegWrite[1]|RegDst[1]|Branch[1]|funct[6]|ALU_ctrl[4]
:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:
ADD|0|0|1|1|0|32|0010
SUB|0|0|1|1|0|34|0110
AND|0|0|1|1|0|36|0000
OR|0|0|1|1|0|37|0001
SLT|0|0|1|1|0|42|0111
ADDI|8|1|1|0|0|x|0010
SLTI|10|1|1|0|0|x|0111
BEQ|4|0|0|0|1|x|0110

## Test
There are 2 test patterns, CO_P2_test_data1.txt, CO_P2_test_data2.txt.

Please change the column 39 in the file `Instr_Memory.v` if you want to test another case.

`$readmemb("CO_P2_test_data1.txt", Instr_Mem)` or `$readmemb("CO_P2_test_data2.txt", Instr_Mem)`
