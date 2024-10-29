`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 07:39:07 PM
// Design Name: 
// Module Name: HW5_RISC_WB
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


module HW5_RISC_WB(
clk,
reset,
//EX_WB_RW,
//EX_WB_DA,
//EX_WB_MD,
//EX_WB_F,
//EX_WB_N_XOR_V,
//Data_Mem_Data_Out,
WB_RW,
WB_DA,
WB_MD,
WB_F,
WB_Data_Mem_Data_Out,
WB_N_XOR_V,
WB_Bus_D
);

input clk;
input reset;
//input EX_WB_RW;
//input [4:0]  EX_WB_DA;
//input [1:0]  EX_WB_MD;
//input [31:0] EX_WB_F;
//input [31:0] Data_Mem_Data_Out;
//input EX_WB_N_XOR_V;

input WB_RW;
input [4:0]WB_DA;
input [1:0]WB_MD;
input [31:0]WB_F;
input [31:0] WB_Data_Mem_Data_Out;
input WB_N_XOR_V;

output reg [31:0]WB_Bus_D;

//always @(posedge clk or reset)
always @(*)
    begin
        if(reset==1)
            begin
                  WB_Bus_D             = 32'h00000000;  
            end
        else
            begin                 
                WB_Bus_D = (WB_MD==3)?WB_Bus_D:
                            (WB_MD==2)?(32'h00000000 | WB_N_XOR_V):
                            (WB_MD==1)?WB_Data_Mem_Data_Out:
                             WB_F;
            end    
    end
    
endmodule
