`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 09:24:09 PM
// Design Name: 
// Module Name: EX_MEM_Buffer
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


module EX_MEM_Buffer(
input clk,
input reset,
input [63:0] ALUResult,
input [63:0] ReadData2in,
input Branch, MemRead, MemtoReg, MemWrite, RegWrite, Zero,
input [4:0] Rd,
input [2:0] funct3,
input flush,

output reg [63:0] ALUResult2,
output reg [63:0] ReadData2out,
output reg Branch2, MemRead2, MemtoReg2, MemWrite2, RegWrite2, Zero2,
output reg [4:0] Rd2,
output reg [2:0] EX_MEM_funct3
);

always@(posedge clk)
            begin
            if(reset == 1'b0)
            begin
            ALUResult2 = ALUResult;
            ReadData2out = ReadData2in;
            Branch2 = Branch;
            MemtoReg2 = MemtoReg;
            MemWrite2 = MemWrite;
            MemRead2 = MemRead;
            RegWrite2 = RegWrite;
            Rd2 = Rd;
            Zero2 = Zero;
            EX_MEM_funct3 = funct3;
            end
            end
            
            
       always@(reset)
     begin
            if(reset == 1'b1)
            begin    
            ALUResult2 = 0;
            ReadData2out = 0;
            Branch2 = 0;
            MemtoReg2 = 0;
            MemWrite2 = 0;
            MemRead2 = 0;
            RegWrite2 = 0;
            Rd2 = 0;
            Zero2 = 0;
            EX_MEM_funct3 = 0;
            end       
    end

endmodule
