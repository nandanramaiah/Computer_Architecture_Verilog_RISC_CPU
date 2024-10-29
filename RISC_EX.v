`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/27/2024 08:45:53 PM
// Design Name: 
// Module Name: HW5_RISC_EX
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


module HW5_RISC_EX(
clk,
reset,
//DOF_EX_RW,
//DOF_EX_DA,
//DOF_EX_MD,
//DOF_EX_BS,
//DOF_EX_PS,
//DOF_EX_MW,
//DOF_EX_FS,
//DOF_EX_SH,
//DOF_EX_Bus_A,
//DOF_EX_Bus_B,
//DOF_EX_PC,

EX_WB_RW,
EX_WB_DA,
EX_WB_MD,
EX_WB_BS,
EX_WB_PS,
EX_WB_MW,
EX_WB_FS,
EX_WB_SH,
EX_WB_Bus_A,
EX_WB_Bus_B,
EX_WB_PC,
EX_WB_N_XOR_V,
EX_WB_Z,
EX_WB_V,
EX_WB_N,
EX_WB_C,
EX_WB_F_64,
EX_WB_F,
EX_WB_Data_Mem_Addr,
Ex_WB_Data_Mem_Data_In,
EX_WB_BrA,
EX_WB_RAA);

input clk;
input reset;
//input DOF_EX_RW;
//input [4:0] DOF_EX_DA;
//input [1:0] DOF_EX_MD;
//input [1:0] DOF_EX_BS;
//input DOF_EX_PS;
//input DOF_EX_MW;
//input [4:0] DOF_EX_FS;
//input [4:0] DOF_EX_SH;
//input [31:0]DOF_EX_Bus_A;
//input [31:0]DOF_EX_Bus_B;
//input [31:0]DOF_EX_PC;

input EX_WB_RW;
input [4:0] EX_WB_DA;
input [1:0] EX_WB_MD;
input [1:0] EX_WB_BS;
input EX_WB_PS;
input EX_WB_MW;
input [4:0] EX_WB_FS;
input [4:0] EX_WB_SH;
input [31:0]EX_WB_Bus_A;
input [31:0]EX_WB_Bus_B;
input [31:0]EX_WB_PC;
output reg EX_WB_N_XOR_V;
output reg EX_WB_Z;
output reg EX_WB_V;
output reg EX_WB_N;
output reg EX_WB_C;
output reg [63:0]EX_WB_F_64;
output reg [31:0]EX_WB_F;
output reg [31:0]EX_WB_Data_Mem_Addr;
output reg [31:0]Ex_WB_Data_Mem_Data_In;
output reg [31:0]EX_WB_BrA;
output reg [31:0]EX_WB_RAA;

parameter NOP_ST_LD_MOV_JMR_BZ_BNZ_JMP  = 5'b00000;
parameter ADD_ADI_AIU       = 5'b00010;
parameter SUB_SLT_SUBI_SIU  = 5'b00101;
//parameter SLT  = 5'b00101;
parameter AND_ANI  = 5'b01000;
parameter OR_ORI   = 5'b01010;
parameter XOR_XRI  = 5'b01100;
//parameter ADI  = 5'b00010; same as ADD
//parameter SUBI = 5'b00101; same as SUB
parameter NOT  = 5'b01110;
//parameter ANI  = 5'b01000; same as AND
//parameter ORI  = 5'b01010; same as OR
//parameter XRI  = 5'b01100; same as XOR
//parameter AIU  = 5'b00010; sameas ADD
//parameter SIU  = 5'b00101; same as SUB
parameter LSL  = 5'b10000;
parameter LSR  = 5'b10001;
parameter JML  = 5'b00111;


//always @(posedge clk or reset)
always @(*)
    begin
        if(reset ==1)
            begin
                EX_WB_N_XOR_V = 0;
                EX_WB_Z       = 0;
                EX_WB_V       = 0;
                EX_WB_N       = 0;
                EX_WB_C       = 0;
                EX_WB_F_64    = 64'h0000000000000000;
                EX_WB_F       = 32'h00000000;
                EX_WB_BrA     = 32'h00000000;
                EX_WB_RAA     = 32'h00000000;
                EX_WB_Data_Mem_Addr = 32'h00000000;
                Ex_WB_Data_Mem_Data_In = 32'h00000000;

            end
        else
            begin
               
                case(EX_WB_FS)
                NOP_ST_LD_MOV_JMR_BZ_BNZ_JMP: EX_WB_F_64 = EX_WB_Bus_A;
                ADD_ADI_AIU      : EX_WB_F_64 = EX_WB_Bus_A + EX_WB_Bus_B;
                SUB_SLT_SUBI_SIU : begin
                                     EX_WB_F_64 = EX_WB_Bus_A - EX_WB_Bus_B;
                                     //EX_WB_F_64 = EX_WB_Bus_A + (32'hffffffff ^ EX_WB_Bus_B) + 1;
                                     //EX_WB_N_XOR_V =  (EX_WB_Bus_A < EX_WB_Bus_B)?1:0;
                                   end
                AND_ANI          : EX_WB_F_64 = EX_WB_Bus_A & EX_WB_Bus_B;
                OR_ORI           : EX_WB_F_64 = EX_WB_Bus_A | EX_WB_Bus_B;
                XOR_XRI          : EX_WB_F_64 = EX_WB_Bus_A ^ EX_WB_Bus_B;
                NOT              : EX_WB_F_64 = (32'hffffffff ^ EX_WB_Bus_A);
                LSL              : EX_WB_F_64 = EX_WB_Bus_A << EX_WB_SH;
                LSR              : EX_WB_F_64 = EX_WB_Bus_A >> EX_WB_SH;
                JML              : begin
                                    //EX_WB_PC   = EX_WB_PC + 1 + EX_WB_Bus_B;
                                    EX_WB_F_64 = EX_WB_PC + 1; 
                                   end    
                default          : ;
                endcase
                
                EX_WB_Data_Mem_Addr    = EX_WB_Bus_A;
                Ex_WB_Data_Mem_Data_In = EX_WB_Bus_B;
                EX_WB_BrA              = EX_WB_PC + EX_WB_Bus_B;
                EX_WB_RAA              = EX_WB_Bus_A;
               
                EX_WB_V                = (EX_WB_F_64>64'h00000000ffffffff)?1:0;
                EX_WB_C                = (EX_WB_F_64>64'h00000000ffffffff)?1:0;
                
                EX_WB_F                = EX_WB_F_64 & 64'h00000000ffffffff;
                EX_WB_Z                = (EX_WB_FS==JML)?1:(EX_WB_F==32'h00000)?1:0;
                EX_WB_N                = !(EX_WB_F[31]);
                //EX_WB_N_XOR_V          = (EX_WB_Bus_A < EX_WB_Bus_B)?1:0;
                EX_WB_N_XOR_V          = EX_WB_N ^ EX_WB_V;
     
                
            end
    end
endmodule
