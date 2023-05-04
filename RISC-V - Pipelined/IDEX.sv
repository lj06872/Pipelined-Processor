module IDEX(
  input clk,reset,
  input [3:0] Funct, // instruction[30, 14-12]
  input [63:0] IF_ID_PC_Out,//adder input, ouput of IFID carried forward
  input [63:0] ReadData1, 
  input [63:0] ReadData2,
  input [63:0] imm_data,//from immediate data extractor
  input [4:0] rs1,//from instruction parser
  input [4:0] rs2, //from instruction parser
  input [4:0] rd, //from instruction parser
  input Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite,
  input [1:0] ALUOp,
  input flush, 
  output reg [63:0] ID_EX_PC_Out,
  output reg [4:0] ID_EX_rs1,
  output reg [4:0] ID_EX_rs2,
  output reg [4:0] ID_EX_rd,
  output reg [63:0] ID_EX_imm_data,
  output reg [63:0] ID_EX_ReadData1, //2bit mux
  output reg [63:0] ID_EX_ReadData2, //2bit mux
  output reg [3:0] ID_EX_Funct,
  output reg ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_RegWrite, ID_EX_ALUSrc, 
  output reg [1:0] ID_EX_ALUOp
);
  
  always @ (posedge clk)
    begin
      if (reset == 1'b1 || flush == 1'b1)
        begin
          ID_EX_PC_Out = 64'b0;
          ID_EX_rs1 = 5'b0;
          ID_EX_rs2 = 5'b0;
          ID_EX_rd = 5'b0;
          ID_EX_imm_data = 64'b0;
          ID_EX_ReadData1 = 64'b0;
          ID_EX_ReadData2 = 64'b0;
          ID_EX_Funct = 4'b0;
          ID_EX_Branch = 1'b0;
          ID_EX_MemRead = 1'b0;
          ID_EX_MemtoReg =1'b0;
          ID_EX_MemWrite = 1'b0;
          ID_EX_RegWrite = 1'b0;
          ID_EX_ALUSrc = 1'b0;
          ID_EX_ALUOp = 2'b0;
        end
      else
        begin
          ID_EX_PC_Out = IF_ID_PC_Out;
          ID_EX_rs1 = rs1;
          ID_EX_rs2 = rs2;
          ID_EX_rd = rd;
          ID_EX_imm_data = imm_data;
          ID_EX_ReadData1 = ReadData1;
          ID_EX_ReadData2 = ReadData2;
          ID_EX_Funct = Funct;
          ID_EX_Branch = Branch;
          ID_EX_MemRead = MemRead;
          ID_EX_MemtoReg = MemtoReg;
          ID_EX_MemWrite = MemWrite;
          ID_EX_RegWrite = RegWrite;
          ID_EX_ALUSrc = ALUSrc;
          ID_EX_ALUOp = ALUOp;
          
        end
    end
endmodule