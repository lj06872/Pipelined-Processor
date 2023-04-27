`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2023 10:00:26 PM
// Design Name: 
// Module Name: Hazard_Detection_Unit
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


module Hazard_Detection_Unit (
 input reset,
 input clk,
 input IDEXEMemRead,
 input [4:0] IDEXERd,
 input [4:0] IFIDRs1, IFIDRs2,
 output reg PC_Write, stall, IF_ID_Write
);

 initial
    begin
      stall = 1'b0;
    end
  
  always @(*)
    begin
    
      if (IDEXEMemRead == 1'b1 && ((IDEXERd == IFIDRs1 || (IDEXERd == IFIDRs2))))
        begin
        stall = 1'b1;
        IF_ID_Write = 1'b1;
        PC_Write = 1'b1;
        end
        
      else
        begin
        stall = 1'b0;
        IF_ID_Write = 1'b0;
        PC_Write = 1'b0;
        end
    end
endmodule

