
module MEMWB(
  input clk, reset,
  input [63:0] Read_Data, // output of Data Memory
  input [63:0] EX_MEM_Result, //2 bit 2by1 mux input b    --->               CHECK ????
  input [4:0] EX_MEM_rd,
  input EX_MEM_MemtoReg, EX_MEM_RegWrite, 
  output reg [63:0] MEM_WB_Read_Data,
  output reg [63:0] MEM_WB_Result,
  output reg [4:0] MEM_WB_rd,
  output reg MEM_WB_MemtoReg, MEM_WB_RegWrite
);
  
  always @(posedge clk)
    begin
      if (reset == 1'b1)
        begin
          MEM_WB_Read_Data = 63'b0;
          MEM_WB_Result = 63'b0;
          MEM_WB_rd = 5'b0;
          MEM_WB_MemtoReg = 1'b0;
          MEM_WB_RegWrite = 1'b0;
          
        end
      else
        begin
          MEM_WB_Read_Data = Read_Data;
          MEM_WB_Result = EX_MEM_Result;
          MEM_WB_rd = EX_MEM_rd;
          MEM_WB_MemtoReg = EX_MEM_MemtoReg;
          MEM_WB_RegWrite = EX_MEM_RegWrite;
        end
    end
endmodule
