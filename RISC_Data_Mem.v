`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 05:39:30 PM
// Design Name: 
// Module Name: HW5_RISC_Data_Mem
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


module HW5_RISC_Data_Mem(
clk,
reset,
EX_WB_MW,
EX_WB_Data_Mem_Addr,
Ex_WB_Data_Mem_Data_In,
Data_Mem_Data_Out);

input clk;
input reset;
input EX_WB_MW;
input [31:0] EX_WB_Data_Mem_Addr;
//with 32 bit address i can access 429,49,76,290 data mem locations
//but the size of the data is limited to 1024 mem locations only
input [31:0] Ex_WB_Data_Mem_Data_In;

reg [31:0] Mem [0:1023];

output reg [31:0] Data_Mem_Data_Out;

always @(posedge clk or reset)
    begin
        if(reset==1)
            Data_Mem_Data_Out = 32'b00000000000000000000000000000000;    
        else
            begin
                if(EX_WB_MW == 1)
                    Mem[EX_WB_Data_Mem_Addr] = Ex_WB_Data_Mem_Data_In;  
            end
    end

always @(*)
    begin
        Data_Mem_Data_Out = Mem[EX_WB_Data_Mem_Addr];    
    end
endmodule
