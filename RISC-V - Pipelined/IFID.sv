module IFID
  (
    input clk,
    input reset,
    input [31:0] instruction,
    input [63:0] PC_Out,
    input flush, 
    input IFIDWrite, 
    output reg [31:0] IF_ID_Instruction,
    output reg [63:0] IF_ID_PC_Out
  );
  always @(posedge clk)
    begin
      if (reset == 1'b1 || flush == 1'b1)
        begin
          IF_ID_Instruction = 32'b0;
          IF_ID_PC_Out = 64'b0;
        end
      else if (IFIDWrite == 1'b0)
        begin
          IF_ID_Instruction = instruction;
          IF_ID_PC_Out = PC_Out;
        end
    end
endmodule