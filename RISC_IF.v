`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/23/2024 04:32:55 PM
// Design Name: 
// Module Name: HW5_RISC_IF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module HW5_RISC_IF(
clk,
reset,
EX_WB_Z,
EX_WB_PS,
EX_WB_BS,
EX_WB_BrA,
EX_WB_RAA,
//Instruction_Mem,
IF_DOF_NPC,
IF_DOF_PC,
IF_DOF_IR);

input clk;
input reset;
input EX_WB_Z;
input EX_WB_PS;
input [1:0] EX_WB_BS;
input [31:0] EX_WB_BrA;
input [31:0] EX_WB_RAA;

reg [31:0] Instruction_Mem [0:255];
reg [ 8:0] i;
reg [1:0] MUXC_signal_select;
output reg [31:0] IF_DOF_NPC;
output reg [31:0] IF_DOF_PC;
output reg [31:0] IF_DOF_IR;

initial
    begin
    for(i=0;i<=255;i=i+1)
        Instruction_Mem[i] = 32'h00000000;
// below instruction list is to be enabled onl when HW_RISC_IF is tested        
//Instruction_Mem[0] =32'b0000000_00000_00000_00000_0000000000;        //NOP    NOP
//Instruction_Mem[1] =32'b0000010_00011_00010_00001_0000000000;        //ADD R3,R2,R1    ADD R[DR] <= R[SA] + R[SB]
//Instruction_Mem[2] =32'b0000101_00100_00011_00010_0000000000;        //SUB R4,R3,R2    SUB R[DR] <= R[SA] + R[SB]' +1
//Instruction_Mem[3] =32'b1100101_00101_00100_00011_0000000000;        //SLT R5,R4,R3    SLT If R[SA] < R[SB] then R[DR] = 1
//Instruction_Mem[4] =32'b0001000_00110_00101_00100_0000000000;        //AND R6,R5,R4    AND R[DR] <= R[SA] & R[SB]
//Instruction_Mem[5] =32'b0001010_00111_00110_00101_0000000000;        //OR R7,R6,R5    OR R[DR] <= R[SA]  | R[SB]
//Instruction_Mem[6] =32'b0001100_01000_00111_00110_0000000000;        //XOR R8,R7,R6    XOR R[DR] <= R[SA] ^ R[SB]
//Instruction_Mem[7] =32'b0000001_00000_01001_01000_0000000000;        //ST R9,R8    ST M[R[SA]] <= R[SB]
//Instruction_Mem[8] =32'b0100001_01010_01001_01000_0000000000;        //LD R10,R9     LD R[DR] <= M[R[SA]]
//Instruction_Mem[9] =32'b0100010_01011_01010_00000_0000001010;        //ADI R11,R10,#10    ADI R[DR] <= R[SA] + se IM
//Instruction_Mem[10]=32'b0100101_01100_01011_00000_0000000100;        //SUBI R12,R11,#5    SUBI R[DR] <= R[SA] + se IM' + 1
//Instruction_Mem[11]=32'b0101110_01101_01100_00000_0000000000;        //NOT R13,R12    NOT R[DR] <= R[SA]'
//Instruction_Mem[12]=32'b0101000_01110_01101_00011_1111111111;        //ANI R14,R13,#4095    ANI R[DR] <= R[SA] & (0 || IM)
//Instruction_Mem[13]=32'b0101010_01111_01110_00000_0011111111;        //ORI R15,R14,#255    ORI R[DR] <= R[SA] | (0 || IM)
//Instruction_Mem[14]=32'b0101100_10000_01111_00000_0000001111;        //XRI R16,R15,#15    XRI R[DR] <= R[SA] ^ (0 || IM)
//Instruction_Mem[15]=32'b1100010_10001_10000_11111_1111111111;        //AIU R17,R16,#16383    AIU R[DR] <= R[SA] + (0 || IM)
//Instruction_Mem[16]=32'b1000101_10010_10001_10000_0000001111;        //SIU R18,R17,#2807    SIU R[DR] R[SA] + (0 || IM)' + 1
//Instruction_Mem[17]=32'b1000000_10011_10010_00000_0000000000;        //MOV R19,R18    MOV R[DR] <= R[SA]
//Instruction_Mem[18]=32'b0110000_10100_10011_00000_00000_00100;        //LSL R20,R19,#5(IRbit4 tobit0)    LSL R[DR] <= lsl R[SA] by SH
//Instruction_Mem[19]=32'b0110001_10101_10100_00000_00000_00100;        //LSL R21,R20,#5(IRbit4 tobit0)    LSR R[DR] lsr R[SA] by SH
//Instruction_Mem[20]=32'b1100001_00000_10101_00000_0000000000;        //JMR R21     JMR PC<= R[SA]
//Instruction_Mem[21]=32'b0100000_00000_10110_00000_0000000001;        //BZ R22,#1    BZ If R[SA] = 0, then PC <= PC + 1 + se IM
//Instruction_Mem[22]=32'b1100000_00000_10111_00000_0000000010;        //BNZ R23,#2    BNZ If R[SA] != 0, then PC <= PC + 1 + se IM
//Instruction_Mem[23]=32'b1000100_00000_00000_00000_0000000011;        //JMP #3    JMP PC<= PC + 1 + se IM
//Instruction_Mem[24]=32'b0000111_11000_00000_00000_0000000111;        //JML R24 #4    JML PC ? PC + 1 + se IM, R[DR] ? PC +1

// below instructions are enabled when testing the parent module or top module
Instruction_Mem[1]  = 32'b0100010_00001_00000_00000_0011111111;//ADI R1,R0,#FF    ADI R[DR] <= R[SA] + se IM
Instruction_Mem[2]  = 32'b0100010_00010_00000_00000_0010101010;//ADI R2,R0,#AA    ADI R[DR] <= R[SA] + se IM 
Instruction_Mem[3]  = 32'b00000000000000000000000000000000;    //NOP   
Instruction_Mem[4]  = 32'b0000010_00011_00010_00001_0000000000;//ADD R3,R2,R1    ADI R[DR] <= R[SA] + R[SB]
Instruction_Mem[5]  = 32'b00000000000000000000000000000000;    //NOP   
Instruction_Mem[6]  = 32'b0000101_00100_00011_00010_0000000000;//SUB R4,R3,R2    SUB R[DR] <= R[SA] + R[SB]' +1
Instruction_Mem[7]  = 32'b1100101_00101_00100_00011_0000000000;//SLT R5,R4,R3    SLT If R[SA] < R[SB], then R[DR]=1,else R[DR]=0 expected result R5=1
Instruction_Mem[8]  = 32'b1100101_00110_00011_00100_0000000000;//SLT R6,R3,R4    SLT If R[SA] < R[SB], then R[DR]=1,else R[DR]=0 expected result R6=0
Instruction_Mem[9]  = 32'b0001000_00111_00001_00010_0000000000;//AND R7,R1,R2
Instruction_Mem[10] = 32'b0001010_01000_00001_00010_0000000000;//OR R8,R1,R2  
Instruction_Mem[11] = 32'b0001100_01001_00001_00010_0000000000;//XOR R9,R1,R2
Instruction_Mem[12] = 32'b0000001_00000_00001_00011_0000000000;//ST R0,R1,R3 M[R1] = R3
Instruction_Mem[13] = 32'b0100001_01010_00001_00000_0000000000;//ST R10,R1,R0 R10 = M[R1]
Instruction_Mem[14] = 32'b0100010_01011_00001_000_1111_1111_1111;//ADI R11,R1,#fff R11 = R1 + 0xfff
Instruction_Mem[15] = 32'b0100101_01100_00001_000_1010_1011_1100;//SBI R12,R10,#abc R12 = R10 - 0xabc
Instruction_Mem[16] = 32'b0101110_01101_00011_00000_0000000000;//NOT R13,R3,R0 R13= NOT(R3)
Instruction_Mem[17] = 32'b1000000_01110_00011_00000_0000000000;//MOV R14,R3 R14 = R3
Instruction_Mem[18] = 32'b0110000_01111_00001_00000_0000001111;//LSL R15,R1,#0xf
Instruction_Mem[19] = 32'b0110001_10000_00010_00000_0000010000;//LSR R16,R2,#0x10
Instruction_Mem[20] = 32'b1100001_00000_00010_00000_0000000000;//JMR R2  PC = R2  then PC points to instruction[0xaa = 170]
Instruction_Mem[170] =32'b0000010_10010_00010_00011_0000000000;// ADD R18,R2,R3
Instruction_Mem[171] =32'b0100000_00000_00000_00000_0000001010;// BZ R0,#0xA PC = PC +1 + IM
Instruction_Mem[185] =32'b0100010_10011_00000_00011_1111111111;//ADI R19,R0,#fFF    ADI R[DR] <= R[SA] + se IM
Instruction_Mem[186] =32'b1100000_00000_00001_00000_0000001111;// BNZ R1,#0xF PC = PC +1 + IM
Instruction_Mem[203] =32'b0100010_10100_00000_00010_1010101010;//ADI R20,R0,#AAA    ADI R[DR] <= R[SA] + se IM 
Instruction_Mem[204] =32'b1000100_00000_00000_00000_0000001010;// JMP #0xA PC = PC + 1 + 0xA
Instruction_Mem[216] =32'b0000010_10101_00010_00001_0000000000;//ADD R21,R2,R1    ADD R[DR] <= R[SA] + R[SB]
Instruction_Mem[217] =32'b0000111_10110_00000_00000_0000001100;//JML R22,R0,#0xc PC = PC +1 + IM, R[DR] = PC + 1
Instruction_Mem[231] =32'b0000101_10111_00011_00010_0000000000;//SUB R23,R3,R2    SUB R[DR] <= R[SA] + R[SB]' +1



 
//Instruction_Mem[56]  = 32'b0000101_10110_00011_00010_0000000000;//SUB R22,R3,R2    SUB R[DR] <= R[SA] + R[SB]' +1
//Instruction_Mem[57]  = 32'b1100101_10111_00100_00011_0000000000;//SLT R23,R4,R3    SLT If R[SA] < R[SB], then R[DR]=1,else R[DR]=0 expected result R5=1
//Instruction_Mem[58]  = 32'b1100101_11000_00011_00100_0000000000;//SLT R24,R3,R4    SLT If R[SA] < R[SB], then R[DR]=1,else R[DR]=0 expected result R6=0
//Instruction_Mem[59]  = 32'b0001000_11001_00001_00010_0000000000;//AND R25,R1,R2
//Instruction_Mem[60]  = 32'b0001010_11010_00001_00010_0000000000;//OR R26,R1,R2  
//Instruction_Mem[61]  = 32'b0001100_11011_00001_00010_0000000000;//XOR R27,R1,R2
    end
    
always@(posedge clk or reset)
//always @(*)
if(reset==1)
    begin
        IF_DOF_NPC          = 32'b00000000000000000000000000000000; 
        IF_DOF_PC           = 32'b00000000000000000000000000000000; // PC + 1 is also 0
        MUXC_signal_select  = 2'b00;
        IF_DOF_IR           = Instruction_Mem[IF_DOF_PC];
    end
else
    begin
        IF_DOF_IR = Instruction_Mem[IF_DOF_PC];
        MUXC_signal_select = (EX_WB_BS & 2'b10) | ((((EX_WB_PS^EX_WB_Z)|(EX_WB_BS&2'b10))&(EX_WB_BS & 2'b01))& 2'b01);
        
        IF_DOF_PC = ((MUXC_signal_select==0)? IF_DOF_PC+1 : ((MUXC_signal_select==1 || MUXC_signal_select==3)? EX_WB_BrA : EX_WB_RAA ));
        IF_DOF_NPC = ((MUXC_signal_select==0)? IF_DOF_PC+1 : ((MUXC_signal_select==1 || MUXC_signal_select==3)? EX_WB_BrA : EX_WB_RAA ));
    end
endmodule
