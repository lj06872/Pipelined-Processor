`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 09:23:58 PM
// Design Name: 
// Module Name: ID_EX_Buffer
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


module ID_EX_Buffer
(
input clk,
input reset,
input [63:0] ReadDataIn,
input [63:0] ReadData2In,
input Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
input [1:0] ALUOp,
input [4:0] Rd1,
input [3:0] Funct1,
input [4:0]Rs1In, Rs2In,
input [2:0] funct3, 
input flush,


output reg [63:0] ReadDataOut,
output reg [63:0] ReadData2Out,
output reg Branch2, MemRead2, MemtoReg2, MemWrite2, ALUSrc2, RegWrite2,
output reg [1:0] ALUOp2,
output reg [4:0] Rd2,
output reg [3:0] Funct2,
output reg [4:0]Rs1Out, Rs2Out,
output reg [2:0] funct3out 
);

always@(posedge clk)
            begin
            if(reset == 1'b0)
            begin
            ReadDataOut = ReadDataIn;
            ReadData2Out = ReadData2In;
            Branch2 = Branch;
            MemtoReg2 = MemtoReg;
            MemWrite2 = MemWrite;
            MemRead2 = MemRead;
            ALUSrc2 = ALUSrc;
            RegWrite2 = RegWrite;
            ALUOp2 = ALUOp;
            Rd2 = Rd1;
            Funct2 = Funct1;
            Rs1Out = Rs1In;
            Rs2Out = Rs2In;
            funct3out = funct3;  // added
            end
            end
          
always@(reset)
     begin
            if(reset == 1'b1 || flush == 1)
            begin

            ReadDataOut = 0;
            ReadData2Out = 0;
            Branch2 = 0;
            MemtoReg2 = 0;
            MemWrite2 = 0;
            MemRead2 = 0;
            ALUSrc2 = 0;
            
            RegWrite2 = 0;
            ALUOp2 = 0;
            Rd2 = 0;
            Funct2 = 0;
            Rs1Out = 0;
            Rs2Out = 0;
            funct3out = 0;  // added
            end       
    end
   
endmodule