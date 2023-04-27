`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2023 10:03:03 AM
// Design Name: 
// Module Name: RISC_V_Processor
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


module RISC_V_Processor(
input clk,
input reset,
 input wire[63:0] element1,
  input wire[63:0] element2,
  input wire[63:0] element3,
  input wire[63:0] element4,
  input wire[63:0] element5,
  input wire[63:0] element6,
  input wire[63:0] element7,
  input wire[63:0] element8
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
wire [63:0] WriteData, ReadData1, ReadData2;

// imm gen
wire [63:0] imm_data;

//mux1
wire [63:0] mux1out;

//ALU Control
wire [3:0] Operation;

// ALU 
wire [63:0] Result; wire Zero;

//Shift Left 1
wire [63:0] imm_shifted;
assign imm_shifted = {imm_data[62:0], 1'b0};

//adder2
wire [63:0] add2out;

//branch and gate
wire branch_andgate; assign branch_andgate = Branch && Zero;

//MUX2
wire [63:0] mux2out;

//Data Memory
wire [63:0] Read_Data;

//MUX3  
wire [63:0] mux3out;

Program_Counter pc(clk, reset, PC_In, PC_Out);
Instruction_Memory im(PC_Out, Instruction);
Adder adder1(PC_Out, B, add1out);
InsParser ip(Instruction, opcode, rd, funct3, rs1, rs2, funct7);
Control_Unit cu(opcode, Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, ALUOp);
registerFile rf(WriteData, rs1, rs2, rd, RegWrite, clk, reset, ReadData1, ReadData2);
ImmGen ig(Instruction, imm_data);
Mux mux1(ReadData2, imm_data, ALUSrc, mux1out);
ALU_Control ac(ALUOp, {funct7[5], funct3},  Operation);
ALU_64_bit alu(ReadData1, mux1out, Operation, funct3, Result, Zero);
Adder adder2(PC_Out, imm_shifted, add2out);

Mux mux2(add1out, add2out, branch_andgate, mux2out);
assign PC_In = mux2out;

Data_Memory dm(Result, ReadData2, clk, MemWrite, MemRead, Read_Data,
              element1,
              element2,
             element3
             );
Mux mux3(Result, Read_Data, MemtoReg, mux3out); 
assign WriteData = mux3out;

    
endmodule
