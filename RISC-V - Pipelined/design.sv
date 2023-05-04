

module RISC_V_Processor(
  input clk,
  input reset,
  input wire[63:0] element1,
  input wire[63:0] element2,
  input wire[63:0] element3,
  input stall, flush);
  
  // CU wires
  wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite; wire [1:0] ALUOp;
  
  //regfile
  // wire regwrite_memwb_out;
  wire [63:0] ReadData1, ReadData2, WriteData;
  
   //PC wires
  wire [63:0] PC_In, PC_Out;
  
  // adders
  wire [63:0] adderout1, adderout2;
  

  // IF/ID Stage Outputs
  wire [31:0] instruction, IF_ID_Instruction;
  
  //Parser
  wire [6:0] opcode; wire [4:0] rd, rs1, rs2; wire [2:0] funct3; wire [6:0] funct7;
  
  
  // Immediate Data Extractor
  wire [63:0] imm_data;
  
  //ifid wires
  wire [63:0] IF_ID_PC_Out;
  

  // ID/EX Stage Outputs:
  wire [63:0] ID_EX_PC_Out;
  wire [4:0] ID_EX_rs1, ID_EX_rs2, ID_EX_rd;
  wire [63:0] ID_EX_imm_data, ID_EX_ReadData1, ID_EX_ReadData2;
  wire ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_RegWrite, ID_EX_ALUSrc; wire [1:0] ID_EX_ALUOp;
  wire [3:0] ID_EX_Funct;
  
  //mux wires
  wire [63:0] forward_A_muxout, forward_B_muxout, alu_64_b;
  

   // EX/MEM Stage Outputs:
  wire [63:0] Write_Data, EX_MEM_PC_Out, EX_MEM_Result;
  wire EX_MEM_Zero;
  wire [4:0] EX_MEM_rd;
  wire EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite;   
  

   // ALU 64
  wire [63:0] Result;
  wire Zero;
  
  // ALU Control
  wire [3:0] operation;
  
  // Data Memory
  wire [63:0] Read_Data;
 

  // MEM/WB Stage Outputs:
  wire[63:0] MEM_WB_Read_Data, MEM_WB_Result;
  wire [4:0] MEM_WB_rd;
  wire MEM_WB_MemtoReg;
  wire MEM_WB_RegWrite;
  

  // Forwarding Unit Outputs:
  wire [1:0] forwardA;
  wire [1:0] forwardB;
  

  // Branch signals:
  wire ID_EX_comparator_signal;
  wire EX_MEM_comparator_signal;
  
  
  pipeline_flush p_flush  ( .branch(EX_MEM_comparator_signal & EX_MEM_Branch), .flush(flush));
   
  hazard_detection_unit hu (ID_EX_MemRead, IF_ID_Instruction, ID_EX_rd, stall);


  
  program_counter pc (.PC_In(PC_In), .stall(stall),.clk(clk),.reset(reset),.PC_Out(PC_Out));
  
  instruction_memory im (.Inst_Address(PC_Out), .Instruction(instruction));
   
  adder adder1 (.a(PC_Out), .b(64'd4), .out(adderout1));
  
   IFID IF_ID
  (
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .PC_Out(PC_Out),
    .flush(flush),
    .IFIDWrite(stall),
    .IF_ID_Instruction(IF_ID_Instruction),
    .IF_ID_PC_Out(IF_ID_PC_Out)
  );
  
  Parser ip
  ( .instruction(IF_ID_Instruction), .opcode(opcode), .rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2), .funct7(funct7) );
  
  CU cu
  (
    .opcode(opcode),
    .branch(Branch),
    .memread(MemRead),
    .memtoreg(MemtoReg),
    .memwrite(MemWrite),
    .aluSrc(ALUSrc),
    .regwrite(RegWrite),
    .Aluop(ALUOp),
    .stall(stall)
  );
  
  data_extractor immextr (.instruction(IF_ID_Instruction), .imm_data(imm_data) );
  
  registerFile regfile 
  (
    .clk(clk),
    .reset(reset),
    .rs1(rs1),
    .rs2(rs2),
    .rd(MEM_WB_rd),
    .writedata(WriteData),
    .reg_write(MEM_WB_RegWrite),
    .readdata1(ReadData1),
    .readdata2(ReadData2)
  );
  

  IDEX ID_EX
  (
    .clk(clk),
    .flush(flush),
    .reset(reset),
    .Funct({IF_ID_Instruction[30],IF_ID_Instruction[14:12]}),
    .IF_ID_PC_Out(IF_ID_PC_Out),
    .ReadData1(ReadData1),
    .ReadData2(ReadData2),
    .imm_data(imm_data),
    .rs1(rs1), .rs2(rs2), .rd(rd),
    .Branch(Branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite), .ALUOp(ALUOp),

    .ID_EX_PC_Out(ID_EX_PC_Out), .ID_EX_rs1(ID_EX_rs1), .ID_EX_rs2(ID_EX_rs2), .ID_EX_rd(ID_EX_rd), 
    .ID_EX_imm_data(ID_EX_imm_data), .ID_EX_ReadData1(ID_EX_ReadData1), .ID_EX_ReadData2(ID_EX_ReadData2),
    .ID_EX_Funct(ID_EX_Funct), 
    .ID_EX_Branch(ID_EX_Branch), .ID_EX_MemRead(ID_EX_MemRead), .ID_EX_MemtoReg(ID_EX_MemtoReg), 
    .ID_EX_MemWrite(ID_EX_MemWrite), .ID_EX_RegWrite(ID_EX_RegWrite), .ID_EX_ALUSrc(ID_EX_ALUSrc), .ID_EX_ALUOp(ID_EX_ALUOp)
  );


  adder adder2 ( .a(ID_EX_PC_Out), .b(ID_EX_imm_data << 1), .out(adderout2) );
  
  ThreebyOneMux m1 // Forward_A MUX 
  (ID_EX_ReadData1, WriteData, EX_MEM_Result, forwardA, forward_A_muxout);
  
  ThreebyOneMux m2 // Forward_B MUX
  (ID_EX_ReadData2, WriteData, EX_MEM_Result, forwardB, forward_B_muxout);
  

  twox1Mux mux1 ( forward_B_muxout, ID_EX_imm_data, ID_EX_ALUSrc, alu_64_b );
  
  Alu64 alu
  (
    .a(forward_A_muxout),
    .b(alu_64_b),
    .ALuop(operation),
    .Result(Result),
    .zero(Zero)
  );
  
   alu_control ac  (.Aluop(ID_EX_ALUOp), .funct(ID_EX_Funct), .operation(operation));
  
  
  EXMEM EX_MEM
  (
    .clk(clk),.reset(reset), .add2out(adderout2), .Result(Result), .Zero(Zero), .flush(flush),
    .forward_B_muxout(forward_B_muxout), .ID_EX_rd(ID_EX_rd), .ID_EX_comparator_signal(ID_EX_comparator_signal),
    .ID_EX_Branch(ID_EX_Branch), .ID_EX_MemRead(ID_EX_MemRead), .ID_EX_MemtoReg(ID_EX_MemtoReg), .ID_EX_MemWrite(ID_EX_MemWrite), 
    .ID_EX_RegWrite(ID_EX_RegWrite),
    .EX_MEM_PC_Out( EX_MEM_PC_Out), .EX_MEM_Zero(EX_MEM_Zero), .EX_MEM_Result(EX_MEM_Result), .Write_Data(Write_Data), .EX_MEM_rd(EX_MEM_rd), 
    .EX_MEM_Branch(EX_MEM_Branch), .EX_MEM_MemRead(EX_MEM_MemRead), .EX_MEM_MemtoReg(EX_MEM_MemtoReg), .EX_MEM_MemWrite(EX_MEM_MemWrite), 
    .EX_MEM_RegWrite(EX_MEM_RegWrite), 
    .EX_MEM_comparator_signal(EX_MEM_comparator_signal)
  );
    
  data_memory datamem
  (
    .write_data(Write_Data),
    .address(EX_MEM_Result),
    .memorywrite(EX_MEM_MemWrite),
    .clk(clk),
    .memoryread(EX_MEM_MemRead),
    .read_data(Read_Data),
    .element1(element1),
    .element2(element2),
    .element3(element3)
  );
  

  twox1Mux mux2  ( .A(adderout1), .B(EX_MEM_PC_Out), .SEL(EX_MEM_Branch & EX_MEM_comparator_signal), .out(PC_In) );

 
  MEMWB MEM_WB 
  (
    .clk(clk),.reset(reset), .Read_Data(Read_Data),
    .EX_MEM_Result(EX_MEM_Result), .EX_MEM_rd(EX_MEM_rd), .EX_MEM_MemtoReg(EX_MEM_MemtoReg), .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .MEM_WB_Read_Data(MEM_WB_Read_Data), .MEM_WB_Result(MEM_WB_Result), .MEM_WB_rd(MEM_WB_rd), .MEM_WB_MemtoReg(MEM_WB_MemtoReg), 
    .MEM_WB_RegWrite(MEM_WB_RegWrite)
  );
  

   twox1Mux mux3   // MUX after MEM/WB Stage
  (
    .A(MEM_WB_Result), .B(MEM_WB_Read_Data), .SEL(MEM_WB_MemtoReg), .out(WriteData) 
  );
  
  
   ForwardingUnit f1
  (
    .ID_EX_rs1(ID_EX_rs1), .ID_EX_rs2(ID_EX_rs2), 
    .EX_MEM_rd(EX_MEM_rd),.MEM_WB_rd(MEM_WB_rd), 
    .MEM_WB_RegWrite(MEM_WB_RegWrite), .EX_MEM_RegWrite(EX_MEM_RegWrite),
    .forwardA(forwardA), .forwardB(forwardB)
  );
  
  
  branching_unit branc
  (
    .funct3(ID_EX_Funct[2:0]), .ReadData1(ID_EX_ReadData1), .b(alu_64_b), .comparator_signal(ID_EX_comparator_signal)
  );

        
endmodule 