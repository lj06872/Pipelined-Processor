`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2023 01:46:23 AM
// Design Name: 
// Module Name: IF_ID_Buffer
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


module IF_ID_Buffer
(
 input clk,
 input reset,
 input [63:0] PC_Out,
 input [31:0] Instruction,
 input flush,
input IF_ID_Write,
 
 output reg [63:0] PC_Out2,
 output reg [31:0] Instruction2
);

always @(posedge clk or reset)
begin
    if(clk & IF_ID_Write == 0)  // maybe change to OR condition?
        begin
            Instruction2 = Instruction;
            PC_Out2 = PC_Out;
        end
  else if (reset==1 || flush == 1)
        begin
            Instruction2 = 0;
            PC_Out2 = 0;
        end
end
endmodule