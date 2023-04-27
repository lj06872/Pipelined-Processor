`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/03/2023 10:05:08 PM
// Design Name: 
// Module Name: RISC_V_Processor_tb
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

module RISC_V_Processor_tb();

  reg clk, reset;
wire [63:0] element1;
  wire [63:0] element2;
  wire [63:0] element3;

  
  RISC_V_Processor r1
  (
    .clk(clk),
    .reset(reset),
    .element1(element1),
    .element2(element2),
    .element3(element3) 
  );

initial
 begin
 $dumpfile("dump.vcd");
 $dumpvars();
clk = 0;
reset = 1;

 #3 reset = 0;

 end
 always #5 clk = ~clk;

endmodule
    



// TASK 2 INSTRUCTION TESTS FOR PIPLEINE VERSION //

// first instruction test: x3, x4, x5
// 2nd:  x9, x21, x9



