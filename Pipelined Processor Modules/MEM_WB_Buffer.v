`timescale 1ns / 1ps

module MEM_WB_Buffer
(
 input clk,
 input reset,
 input [63:0] Result,
 input [63:0] Read_Data,
 input [4:0] rd1,
 input MemtoReg,
 input RegWrite,
 
 output reg [63:0] Result2,
 output reg [63:0] Read_Data2,
 output reg [4:0] rd2,
 output reg MemtoReg2,
 output reg RegWrite2
 );


always@(posedge clk)
            begin
            if(reset == 1'b0)
            begin
         Result2 = Result;
         Read_Data2 = Read_Data;
         rd2 = rd1;
         MemtoReg2 = MemtoReg;
         RegWrite2 = RegWrite;
         end
         end
         
         
 always@(reset)
     begin
            if(reset == 1'b1)
            begin
         Result2 = 0;
         Read_Data2 = 0;
         rd2 = 0;
         MemtoReg2 = 0;
         RegWrite2 = 0;
         end
 end

endmodule
