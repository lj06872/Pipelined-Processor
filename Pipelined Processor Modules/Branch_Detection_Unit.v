`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 12:33:34 AM
// Design Name: 
// Module Name: Branch_Detection_Unit
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


module Branch_Detection_Unit
  (
   input [2:0] funct3,
    input [63:0] ForwardA_Muxout,
    input [63:0] ForwardB_Muxout,
   output reg branch_almost_final
  );
  
  initial
    begin
     branch_almost_final = 1'b0;
    end
  
  always @(*)
	begin
      case (funct3)
        3'b000:
          begin
            if (ForwardA_Muxout == ForwardB_Muxout)   // beq check
              branch_almost_final = 1'b1;
            else
              branch_almost_final = 1'b0;
            end
         3'b100:
    		begin
              if (ForwardA_Muxout < ForwardB_Muxout)    // blt inst!
             branch_almost_final = 1'b1;
            else
              branch_almost_final = 1'b0;
            end
      endcase
     end
endmodule
