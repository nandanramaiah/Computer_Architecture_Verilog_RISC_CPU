`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/28/2024 07:29:04 PM
// Design Name: 
// Module Name: HW5_RISC
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

module HW5_RISC(
clk,
reset,
IF_DOF_PC,
IF_DOF_IR
);

input clk;
input reset;

reg [31:0] DOF_EX_PC;
reg [31:0] DOF_EX_IR;
reg EX_WB_RW;
reg [4:0] EX_WB_DA;
reg [2:0] EX_WB_MD;
reg [1:0] EX_WB_BS;
reg EX_WB_PS;
reg EX_WB_MW;
reg [4:0] EX_WB_FS;
reg [4:0] EX_WB_SH;
reg [31:0]EX_WB_Bus_A;
reg [31:0]EX_WB_Bus_B;
reg [31:0]EX_WB_PC;
reg [4:0]WB_DA;
reg WB_RW;
reg [2:0]WB_MD;
reg [31:0]WB_F;
reg [31:0]WB_Data_Mem_Data_Out;
reg WB_N_XOR_V;

wire EX_WB_Z;
wire [31:0] EX_WB_BrA;
wire [31:0] EX_WB_RAA;
wire [31:0] IF_DOF_NPC;
wire DOF_EX_RW;
wire [4:0]DOF_EX_DA;
wire [2:0]DOF_EX_MD;
wire [1:0]DOF_EX_BS;
wire DOF_EX_PS;
wire DOF_EX_MW;
wire [4:0]DOF_EX_FS;
wire [4:0]DOF_EX_SH;
wire [31:0]DOF_EX_Bus_A;
wire [31:0]DOF_EX_Bus_B;
wire [31:0]Reg_Bus_A;
wire [31:0]Reg_Bus_B;
wire [4:0]DOF_EX_AA;
wire [4:0]DOF_EX_BA;
wire [31:0]WB_Bus_D;
wire [31:0]EX_WB_Data_Mem_Addr;
wire [31:0]Ex_WB_Data_Mem_Data_In;
wire [31:0]Data_Mem_Data_Out;
wire [31:0]EX_WB_F;

output [31:0] IF_DOF_PC;
output [31:0] IF_DOF_IR;

HW5_RISC_Reg_File Reg_File(
//input
.clk(clk),
.reset(reset),
.DOF_EX_AA(DOF_EX_AA),
.DOF_EX_BA(DOF_EX_BA),
.WB_DA(WB_DA),
.WB_RW(WB_RW),
.WB_Bus_D(WB_Bus_D),
//output
.Reg_Bus_A(Reg_Bus_A),
.Reg_Bus_B(Reg_Bus_B));

HW5_RISC_Data_Mem data_Mem(
//input
.clk(clk),
.reset(reset),
.EX_WB_MW(EX_WB_MW),
.EX_WB_Data_Mem_Addr(EX_WB_Data_Mem_Addr),
.Ex_WB_Data_Mem_Data_In(Ex_WB_Data_Mem_Data_In),
//output
.Data_Mem_Data_Out(Data_Mem_Data_Out));

HW5_RISC_IF IF(
//input
.clk(clk),
.reset(reset),
.EX_WB_Z(EX_WB_Z),
.EX_WB_PS(EX_WB_PS),
.EX_WB_BS(EX_WB_BS),
.EX_WB_BrA(EX_WB_BrA),
.EX_WB_RAA(EX_WB_RAA),
//output
.IF_DOF_NPC(IF_DOF_NPC),
.IF_DOF_PC(IF_DOF_PC),
.IF_DOF_IR(IF_DOF_IR)
);

HW5_RISC_DOF DOF(
//input
.clk(clk),
.reset(reset),
.Reg_Bus_A(Reg_Bus_A),
.Reg_Bus_B(Reg_Bus_B),
.DOF_EX_IR(DOF_EX_IR),
.DOF_EX_PC(DOF_EX_PC),
//output
.DOF_EX_SH(DOF_EX_SH),
.DOF_EX_AA(DOF_EX_AA),
.DOF_EX_BA(DOF_EX_BA),
.DOF_EX_BS(DOF_EX_BS),
.DOF_EX_PS(DOF_EX_PS),
.DOF_EX_MW(DOF_EX_MW),
.DOF_EX_FS(DOF_EX_FS),
.DOF_EX_RW(DOF_EX_RW),
.DOF_EX_DA(DOF_EX_DA),
.DOF_EX_MD(DOF_EX_MD),
.DOF_EX_Bus_A(DOF_EX_Bus_A),
.DOF_EX_Bus_B(DOF_EX_Bus_B));

HW5_RISC_EX EX(
//input
.clk(clk),
.reset(reset),
.EX_WB_RW(EX_WB_RW),
.EX_WB_DA(EX_WB_DA),
.EX_WB_MD(EX_WB_MD),
.EX_WB_BS(EX_WB_BS),
.EX_WB_PS(EX_WB_PS),
.EX_WB_MW(EX_WB_MW),
.EX_WB_FS(EX_WB_FS),
.EX_WB_SH(EX_WB_SH),
.EX_WB_Bus_A(EX_WB_Bus_A),
.EX_WB_Bus_B(EX_WB_Bus_B),
.EX_WB_PC(EX_WB_PC),
//output
.EX_WB_N_XOR_V(EX_WB_N_XOR_V),
.EX_WB_Z(EX_WB_Z),
.EX_WB_F(EX_WB_F),
.EX_WB_Data_Mem_Addr(EX_WB_Data_Mem_Addr),
.Ex_WB_Data_Mem_Data_In(Ex_WB_Data_Mem_Data_In),
.EX_WB_BrA(EX_WB_BrA),
.EX_WB_RAA(EX_WB_RAA));

HW5_RISC_WB WB(
//inputs
.clk(clk),
.reset(reset),
.WB_RW(WB_RW),
.WB_DA(WB_DA),
.WB_MD(WB_MD),
.WB_F(WB_F),
.WB_Data_Mem_Data_Out(WB_Data_Mem_Data_Out),
.WB_N_XOR_V(WB_N_XOR_V),
//output
.WB_Bus_D(WB_Bus_D)
);

always @(negedge clk)
begin
    WB_F        = EX_WB_F;
    WB_MD       = EX_WB_MD;
    WB_RW       = EX_WB_RW;
    WB_DA       = EX_WB_DA;
    WB_Data_Mem_Data_Out = Data_Mem_Data_Out;
    WB_N_XOR_V  = EX_WB_N_XOR_V;

    DOF_EX_PC   = IF_DOF_PC;
    DOF_EX_IR   = IF_DOF_IR;
    EX_WB_RW    = DOF_EX_RW;
    EX_WB_DA    = DOF_EX_DA;
    EX_WB_MD    = DOF_EX_MD;
    EX_WB_BS    = DOF_EX_BS;
    EX_WB_PS    = DOF_EX_PS;
    EX_WB_MW    = DOF_EX_MW;
    EX_WB_FS    = DOF_EX_FS;
    EX_WB_SH    = DOF_EX_SH;
    EX_WB_Bus_A = DOF_EX_Bus_A;
    EX_WB_Bus_B = DOF_EX_Bus_B;
    EX_WB_PC    = DOF_EX_PC;
//    WB_F        = EX_WB_F;
//    WB_MD       = EX_WB_MD;
//    WB_RW       = EX_WB_RW;
//    WB_DA       = EX_WB_DA;
//    WB_Data_Mem_Data_Out = Data_Mem_Data_Out;
//    WB_N_XOR_V  = EX_WB_N_XOR_V;
end
endmodule

