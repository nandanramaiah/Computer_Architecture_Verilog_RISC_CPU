`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 01:28:06 PM
// Design Name: 
// Module Name: HW5_RISC_Reg_File
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


module HW5_RISC_Reg_File(
clk,
reset,
DOF_EX_AA,
DOF_EX_BA,
WB_DA,
WB_RW,
WB_Bus_D,
Reg_Bus_A,
Reg_Bus_B);

input clk;
input reset;
input [4:0] DOF_EX_AA;
input [4:0] DOF_EX_BA;
input [4:0] WB_DA;
input WB_RW;
input [31:0] WB_Bus_D;

reg [5:0] i;

output reg [31:0] Reg_Bus_A;
output reg [31:0] Reg_Bus_B;

reg [31:0] Reg [0:31];
    
initial
    begin
        Reg[0]  = 5'b00000;
        Reg[1]  = 5'b00001;
        Reg[2]  = 5'b00010;
        Reg[3]  = 5'b00011;
        Reg[4]  = 5'b00100;
        Reg[5]  = 5'b00101;
        Reg[6]  = 5'b00110;
        Reg[7]  = 5'b00111;
        Reg[8]  = 5'b01000;
        Reg[9]  = 5'b01001;
        Reg[10] = 5'b01010;
        Reg[11] = 5'b01011;
        Reg[12] = 5'b01100;
        Reg[13] = 5'b01101;
        Reg[14] = 5'b01110;
        Reg[15] = 5'b01111;
        Reg[16] = 5'b10000;
        Reg[17] = 5'b10001;
        Reg[18] = 5'b10010;
        Reg[19] = 5'b10011;
        Reg[20] = 5'b10100;
        Reg[21] = 5'b10101;
        Reg[22] = 5'b10110;
        Reg[23] = 5'b10111;
        Reg[24] = 5'b11000;
        Reg[25] = 5'b11001;
        Reg[26] = 5'b11010;
        Reg[27] = 5'b11011;
        Reg[28] = 5'b11100;
        Reg[29] = 5'b11101;
        Reg[30] = 5'b11110;
        Reg[31] = 5'b11111;      
    end
always @(posedge clk or reset)
    begin
        if(reset==1)
            begin
                for(i=0;i<32;i=i+1)
                    begin
                        Reg[i]= 5'b00000;
                    end
                    Reg_Bus_A = 32'b00000000000000000000000000000000;
                    Reg_Bus_B = 32'b00000000000000000000000000000000;
            end
         else
            begin
            if(WB_RW==1 && WB_DA!=5'b00000)
                begin
                    Reg[WB_DA] = WB_Bus_D;
                end
            end
    end
always@(*)
    begin
        Reg_Bus_A = Reg[DOF_EX_AA];
        Reg_Bus_B = Reg[DOF_EX_BA];
    end
    
endmodule
