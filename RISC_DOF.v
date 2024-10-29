`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/26/2024 02:46:22 PM
// Design Name: 
// Module Name: HW5_RISC_DOF
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


module HW5_RISC_DOF(
clk,
reset,
Reg_Bus_A,
Reg_Bus_B,
DOF_EX_IR,
DOF_EX_PC,
DOF_EX_SH,
DOF_EX_AA,
DOF_EX_BA,
DOF_EX_BS,
DOF_EX_PS,
DOF_EX_MW,
DOF_EX_FS,
DOF_EX_RW,
DOF_EX_DA,
DOF_EX_MD,
DOF_EX_Bus_A,
DOF_EX_Bus_B
);

input clk;
input reset;
input [31:0] Reg_Bus_A;
input [31:0] Reg_Bus_B;
input [31:0] DOF_EX_IR;
input [31:0] DOF_EX_PC;

reg [31:0] DOF_EX_IM;
reg        DOF_EX_MA;
reg        DOF_EX_MB;
reg        DOF_EX_CS;

output reg [ 4:0] DOF_EX_SH;
output reg [ 4:0] DOF_EX_AA;
output reg [ 4:0] DOF_EX_BA;

output reg [ 1:0] DOF_EX_BS;
output reg        DOF_EX_PS;
output reg        DOF_EX_MW;
output reg [ 4:0] DOF_EX_FS;
output reg        DOF_EX_RW;
output reg [ 4:0] DOF_EX_DA;
output reg [ 2:0] DOF_EX_MD;
output reg [31:0] DOF_EX_Bus_A;
output reg [31:0] DOF_EX_Bus_B;

parameter NOP  = 7'b0000000;
parameter ADD  = 7'b0000010;
parameter SUB  = 7'b0000101;
parameter SLT  = 7'b1100101;
parameter AND  = 7'b0001000;
parameter OR   = 7'b0001010;
parameter XOR  = 7'b0001100;
parameter ST   = 7'b0000001;
parameter LD   = 7'b0100001;
parameter ADI  = 7'b0100010;
parameter SUBI = 7'b0100101;
parameter NOT  = 7'b0101110;
parameter ANI  = 7'b0101000;
parameter ORI  = 7'b0101010;
parameter XRI  = 7'b0101100;
parameter AIU  = 7'b1100010;
parameter SIU  = 7'b1000101;
parameter MOV  = 7'b1000000;
parameter LSL  = 7'b0110000;
parameter LSR  = 7'b0110001;
parameter JMR  = 7'b1100001;
parameter BZ   = 7'b0100000;
parameter BNZ  = 7'b1100000;
parameter JMP  = 7'b1000100;
parameter JML  = 7'b0000111;

//always @(posedge clk or reset)
always @(*)
if(reset==1) 
    begin
//        DOF_EX_IR    = 32'b00000000000000000000000000000000;
//        DOF_EX_PC    = 32'b00000000000000000000000000000000;
        DOF_EX_IM    = 32'b00000000000000000000000000000000;
        DOF_EX_SH    =  5'b00000;
        DOF_EX_MA    =  1'b0;
        DOF_EX_MB    =  1'b0;
        DOF_EX_AA    =  5'b00000;
        DOF_EX_BA    =  5'b00000;
        DOF_EX_CS    =  1'b0;
        DOF_EX_BS    =  2'b00;
        DOF_EX_PS    =  1'b0;
        DOF_EX_MW    =  1'b0;
        DOF_EX_FS    =  5'b00000;
        DOF_EX_RW    =  1'b0;
        DOF_EX_DA    =  5'b00000;
        DOF_EX_MD    =  3'b000;
        DOF_EX_Bus_A = 32'b00000000000000000000000000000000;
        DOF_EX_Bus_B = 32'b00000000000000000000000000000000;
    end
else
    begin
//        DOF_EX_IR = IF_DOF_IR;
//        DOF_EX_PC = IF_DOF_PC;
        
        DOF_EX_DA = DOF_EX_IR[24:20];
        DOF_EX_AA = DOF_EX_IR[19:15];
        DOF_EX_BA = DOF_EX_IR[14:10];
        DOF_EX_SH = DOF_EX_IR[ 4: 0];
        DOF_EX_IM = (DOF_EX_CS==1)?{{17{DOF_EX_IR[14]}}, {DOF_EX_IR[14:0]}}: {{17{1'b0}}, {DOF_EX_IR[14:0]}};
// above line does sign extension of 16 bit immediate value to 32 bit value 
//by replicating 15th bit of immediate 17 times and concatinating it to 14 bit immediate value        
        
        case(DOF_EX_IR[31:25])
            NOP : begin  DOF_EX_RW=0;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00000;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            ADD : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00010;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            SUB : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00101;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            SLT : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b10;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00101;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            AND : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b01000;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            OR  : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b01010;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            XOR : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b01100;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            ST  : begin  DOF_EX_RW=0;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=1;  DOF_EX_FS=5'b00000;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            LD  : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b01;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00000;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            ADI : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00010;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=1;  end
            SUBI: begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00101;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=1;  end
            NOT : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b01110;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            ANI : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b01000;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            ORI : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b01010;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            XRI : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b01100;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            AIU : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00010;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            SIU : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00101;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            MOV : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00000;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            LSL : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b10000;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            LSR : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b00;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b10001;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            JMR : begin  DOF_EX_RW=0;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b10;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00000;  DOF_EX_MB=0;  DOF_EX_MA=0;  DOF_EX_CS=0;  end
            BZ  : begin  DOF_EX_RW=0;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b01;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00000;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=1;  end
            BNZ : begin  DOF_EX_RW=0;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b01;  DOF_EX_PS=1;  DOF_EX_MW=0;  DOF_EX_FS=5'b00000;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=1;  end
            JMP : begin  DOF_EX_RW=0;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b11;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00000;  DOF_EX_MB=1;  DOF_EX_MA=0;  DOF_EX_CS=1;  end
            JML : begin  DOF_EX_RW=1;  DOF_EX_MD=2'b00;  DOF_EX_BS=2'b11;  DOF_EX_PS=0;  DOF_EX_MW=0;  DOF_EX_FS=5'b00111;  DOF_EX_MB=1;  DOF_EX_MA=1;  DOF_EX_CS=1;  end
            default: ;
        endcase
        
        DOF_EX_Bus_A = DOF_EX_MA==0?Reg_Bus_A:DOF_EX_PC;
        DOF_EX_Bus_B = DOF_EX_MB==0?Reg_Bus_B:DOF_EX_IM;
        
//        DOF_EX_IR = IF_DOF_IR;
//        DOF_EX_PC = IF_DOF_PC;
        

    end
endmodule
