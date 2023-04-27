`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2023 11:17:41 PM
// Design Name: 
// Module Name: Stall_MUX
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


module Stall_MUX(
input Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
input [1:0] ALUOp,
input stall_signal,  //select line
output reg Branch2, MemRead2, MemtoReg2, MemWrite2, ALUSrc2, RegWrite2,
output reg [1:0] ALUOp2
    );
    
    
always @ (Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp, stall_signal)
    begin
        if (stall_signal == 0)
            begin
                Branch2 = 0;
                MemRead2 = 0;
                MemtoReg2 = 0;
                MemWrite2 = 0;
                ALUSrc2 = 0;
                RegWrite2=0;
                ALUOp2 = 2'b00;               
            end
         else
            begin
                Branch2 = Branch;
                MemRead2 = MemRead;
                MemtoReg2 = MemtoReg;
                MemWrite2 = MemWrite;
                ALUSrc2 = ALUSrc;
                RegWrite2=RegWrite;
                ALUOp2 = ALUOp;  
            end
    end
endmodule
