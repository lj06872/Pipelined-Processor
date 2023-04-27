`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 11:34:46 PM
// Design Name: 
// Module Name: Mux_3by1
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


module Mux_3by1(
	input [63:0] a,
	input [63:0] b,
	input [63:0] c,
	input  sel,
	
	output reg [63:0]data_out
);


always @ (a, b, c,  sel)
begin
	case(sel)
    2'b00: data_out = a;
    2'b01: data_out = b;
    2'b10: data_out = c;
    default: data_out = 64'h0;
  endcase
end

endmodule
