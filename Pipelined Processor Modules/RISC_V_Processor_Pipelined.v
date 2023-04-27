`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/24/2023 10:45:49 PM
// Design Name: 
// Module Name: RISC_V_Processor_Pipelined
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


module RISC_V_Processor_Pipelined (
input clk, reset,
input wire[31:0] element1,
  input wire[31:0] element2,
  input wire[31:0] element3,
  input wire[31:0] element4,
  input wire[31:0] element5,
  input wire[31:0] element6,
  input wire[31:0] element7,
  input wire[31:0] element8,
  input wire[31:0] element9,
  input wire[31:0] element10,
  input wire[31:0] element11,
  input wire[31:0] element12,
  input wire[31:0] element13,
  input wire[31:0] element14,
  input wire[31:0] element15,
  input wire[31:0] element16
);

//program counter
wire [63:0] PC_In, PC_Out;
wire [31:0] Instruction;

//adder1
wire [63:0] B = 64'd4;
wire [63:0] add1out;

// instruction parser (decoder)
wire [6:0] opcode, funct7;
wire [4:0] rd, rs1, rs2;
wire [2:0] funct3;

//control unit
wire  Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite; 
wire [1:0] ALUOp;

//register file
//wire [63:0] WriteData, 
wire [63:0] ReadData1, ReadData2;

// imm gen
wire [63:0] imm_data;



//ALU Control
wire [3:0] Operation;

// ALU 
wire [63:0] Result; wire Zero;

////Shift Left 1
//wire [63:0] imm_shifted;
//assign imm_shifted = {imm_data[62:0], 1'b0};

//adder2
wire [63:0] add2out;

////branch and gate
//wire branch_andgate; assign branch_andgate = Branch && Zero;

//MUX2
wire [63:0] mux2out;

//Data Memory
wire [63:0] Read_Data;

//MUX3  
wire [63:0] mux3out;


// **PIPELINE REGISTERS OUTPUTS** //

// IF/ID outputs:
wire [63:0] IF_ID_PC_Out;
wire [31:0] IF_ID_Instruction;

// ID/EX outputs:

wire [63:0] ID_EX_ReadData1;
wire [63:0] ID_EX_ReadData2;
wire ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_RegWrite;
wire [1:0] ID_EX_ALUOp;
wire [4:0] ID_EX_rd;
wire ID_EX_Funct1;
wire [4:0] ID_EX_rs1, ID_EX_rs2;
wire [2:0] ID_EX_funct3;  // added due to need in ALU!


// EX/MEM outputs: 
wire [63:0] EX_MEM_Result;
wire [63:0] EX_MEM_ReadData2;
wire EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_Zero;
wire [4:0] EX_MEM_rd;


// MEM/WB outputs:
wire [63:0] MEM_WB_Result;
wire [63:0] MEM_WB_Read_Data;
wire [4:0] MEM_WB_rd;
wire MEM_WB_MemtoReg, MEM_WB_RegWrite;



 // **DATA PATH START** //
wire PC_Write, stall_signal, IF_ID_Write;

Program_Counter pc(clk, reset, PC_In, PC_Write, PC_Out);
Instruction_Memory im(PC_Out, Instruction);
Adder adder1(PC_Out, B, add1out);


// IF/ID Stage:
IF_ID_Buffer IF_ID (clk, reset, PC_Out, Instruction, flush, IF_ID_Write, IF_ID_PC_Out, IF_ID_Instruction);
InsParser ip(IF_ID_Instruction, opcode, rd, funct3, rs1, rs2, funct7);
Control_Unit cu(opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
registerFile rf(mux3out, rs1, rs2, MEM_WB_rd, MEM_WB_RegWrite, clk, reset, ReadData1, ReadData2);
ImmGen ig(IF_ID_Instruction, imm_data);

wire [63:0] imm_shifted;
Adder adder2(IF_ID_PC_Out, imm_shifted, add2out);
assign imm_shifted = {imm_data[62:0], 1'b0};



Hazard_Detection_Unit hazard_detection_unit(clk, reset, ID_EX_MemRead, ID_EX_rd, rs1, rs2, 
                                            PC_Write, stall_signal, IF_ID_Write);
                                                                             
wire Branch2, MemRead2, MemtoReg2, MemWrite2, ALUSrc2, RegWrite2;
wire [1:0] ALUOp2;                                   
Stall_MUX stall_mux (
                 Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp,
                 stall_signal,  //select line
                 
                 Branch2, MemRead2, MemtoReg2, MemWrite2, ALUSrc2, RegWrite2,
                 ALUOp2
                );

// ID/EX Stage:
ID_EX_Buffer ID_EX (clk, reset, ReadData1, ReadData2, 
                    Branch2, MemRead2, MemtoReg2, MemWrite2, ALUSrc2, RegWrite2, ALUOp2,
                     rd, {funct7[5], funct3}, rs1, rs2, funct3,
                     flush,
                     
                      
                   
                    ID_EX_ReadData1,
                    ID_EX_ReadData2,                 
                    ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_ALUSrc, ID_EX_RegWrite,
                    ID_EX_ALUOp,
                    ID_EX_rd,
                    ID_EX_Funct1,
                    ID_EX_rs1, ID_EX_rs2, 
                    ID_EX_funct3);
                    


wire [1:0] ForwardA, ForwardB;
Forwarding_Unit forwarding_unit (ID_EX_rs1, ID_EX_rs2, EX_MEM_rd, MEM_WB_rd, EX_MEM_RegWrite, MEM_WB_RegWrite, ForwardA, ForwardB);

wire [63:0] ALU_in1, ALU_in2;
wire [63:0] ForwardB_muxout;
Mux_3by1 Forward_A_MUX (ID_EX_ReadData1, mux3out, EX_MEM_Result, ForwardA, ALU_in1);
Mux_3by1 Forward_B_MUX (ID_EX_ReadData2, mux3out, EX_MEM_Result, ForwardB, ForwardB_muxout);
                                  
Mux mux1(ForwardB_muxout, ID_EX_imm, ID_EX_ALUSrc, ALU_in2);
ALU_Control ac(ID_EX_ALUOp, ID_EX_Funct1, Operation);
ALU_64_bit alu(ALU_in1, ALU_in2, Operation, ID_EX_funct3, Result, Zero);


//
wire comparator_signal; // checks comparision b/w alu_in1 and alu_in2
Branch_Detection_Unit branch_detection_unit(ID_EX_funct3, ALU_in1, ALU_in2, comparator_signal);


wire [2:0] EX_MEM_funct3;
// EX/MEM Stage:
EX_MEM_Buffer EX_MEM (clk, reset, Result, ForwardB_muxout,
                     ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_RegWrite, 
                     Zero, ID_EX_rd,
                     ID_EX_funct3, 
                     flush,
                     
                  
                    EX_MEM_Result,
                    EX_MEM_ReadData2,
                    EX_MEM_Branch, EX_MEM_MemRead, EX_MEM_MemtoReg, EX_MEM_MemWrite, EX_MEM_RegWrite, EX_MEM_Zero,
                    EX_MEM_rd,
                    EX_MEM_funct3);



//branch and gate
wire branch_andgate; assign branch_andgate = EX_MEM_Branch && comparator_signal;


//Flush Check:
wire flush;
pipeline_flush flush_check(branch_andgate, flush);

Mux mux2(add1out, add2out, branch_andgate, mux2out);
assign PC_In = mux2out;
Data_Memory dm(EX_MEM_Result, EX_MEM_ReadData2, clk, EX_MEM_MemWrite, EX_MEM_MemRead, Read_Data,
                    element1,
 element2,
element3,
 element4,
element5,
element6,
 element7,
 element8,
  element9,
 element10,
 element11,
element12,
element13,
element14,
element15,
element16);


// MEM/WB Stage:
MEM_WB_Buffer MEM_WB (clk, reset, EX_MEM_Result, Read_Data, EX_MEM_rd, 
                        EX_MEM_MemtoReg, EX_MEM_RegWrite,
                        
                        MEM_WB_Result,
                        MEM_WB_Read_Data,
                        MEM_WB_rd,
                        MEM_WB_MemtoReg, MEM_WB_RegWrite);
                        
Mux mux3(MEM_WB_Result, MEM_WB_Read_Data, MEM_WB_MemtoReg, mux3out); 
//assign WriteData = mux3out;
//assign RegWrite = MEM_WB_RegWrite;
//assign rd = MEM_WB_rd;

endmodule
