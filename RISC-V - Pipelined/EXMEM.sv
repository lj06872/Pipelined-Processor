          
module EXMEM(
  input clk,reset,
  input [63:0] add2out, //adder output
  input [63:0] Result,// alu output
  input Zero,//64bit alu output
  input [63:0] forward_B_muxout, 
  input [4:0] ID_EX_rd, //IDEX output
  input ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_RegWrite, //IDEX outputs
  input flush, 
  input ID_EX_comparator_signal,
  output reg [63:0] EX_MEM_PC_Out,
  output reg EX_MEM_Zero,
  output reg [63:0] EX_MEM_Result,
  output reg [63:0] Write_Data, // to be sent into Data Memory
  output reg [4:0] EX_MEM_rd,
  output reg EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite,
  output reg EX_MEM_comparator_signal
  );
  
  always @ (posedge clk)
    begin
      if (reset == 1'b1 || flush == 1'b1)
        begin
          EX_MEM_PC_Out = 64'b0;
          EX_MEM_Zero = 1'b0;
          EX_MEM_Result = 63'b0;
          Write_Data = 64'b0;
          EX_MEM_rd = 5'b0;
          EX_MEM_Branch = 1'b0;
          EX_MEM_MemRead = 1'b0;
          EX_MEM_MemtoReg =1'b0;
          EX_MEM_MemWrite = 1'b0;
          EX_MEM_RegWrite = 1'b0;
          EX_MEM_comparator_signal = 1'b0;
        end
      else
        begin
          EX_MEM_PC_Out = add2out;
          EX_MEM_Zero = Zero;
          EX_MEM_Result = Result;
          Write_Data = forward_B_muxout;
          EX_MEM_rd = ID_EX_rd;
          EX_MEM_Branch = ID_EX_Branch;
          EX_MEM_MemRead = ID_EX_MemRead;
          EX_MEM_MemtoReg = ID_EX_MemtoReg;
          EX_MEM_MemWrite = ID_EX_MemWrite;
          EX_MEM_RegWrite = ID_EX_RegWrite;
          EX_MEM_comparator_signal = ID_EX_comparator_signal;
        end
    end
endmodule