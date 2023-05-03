
module instruction_memory(
  input [63:0] inst_address,
  output reg [31:0] instruction);
  reg [7:0] inst_mem[87:0];
  
  initial
    begin
      	//////////////////////////////////// CORRECT INSTRUCTION MEMORY //////////////////////////////
	
       {inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'b00000000000000000000010100010011;
        
       {inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'b00000000111100000000011100010011;   // laiba's project instruction: addi x14, x0, 15
         
       {inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'b00000000111001010011000000100011; // sd x14, 0(x10)
                 
       {inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'b00000101001100000000011100010011; // laiba's inst: addi x14, x0, 83

       {inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'b00000000111001010011010000100011; 
                
       {inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'b00000000011000000000011100010011; 
       {inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'b00000000111001010011100000100011; 
       {inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'b00000000001100000000010110010011;
       {inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'b00000000000000000000010001100011;
       {inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'b00000110000000000000101001100011;
       {inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'b00000000000000000000001100010011;
       {inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'b00000000101100000000001110110011;
       {inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'b00000000000000000000111000010011;
       {inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'b00000000101100000000111010110011;
       {inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'b00000000011100110100011001100011;
       {inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'b00000100000000000000110001100011;
       {inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'b00000000000000000000111100010011;
       {inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'b00000000001100110001111100010011; // slli x30, x6, 3       
       {inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'b00000000101011110000111100110011;
       {inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'b00000000000011110011100100000011; // ld x18, 0(x30)         
       {inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]} = 32'b00000000011000000000111000110011;
       {inst_mem[87], inst_mem[86], inst_mem[85], inst_mem[84]} = 32'b00000001110111100100011001100011;
       {inst_mem[91], inst_mem[90], inst_mem[89], inst_mem[88]} = 32'b00000010000000000000101001100011;
       {inst_mem[95], inst_mem[94], inst_mem[93], inst_mem[92]} = 32'b00000000000000000000111110010011;
       {inst_mem[99], inst_mem[98], inst_mem[97], inst_mem[96]} = 32'b00000000001111100001111110010011; // slli x31, x28, 3       
       {inst_mem[103], inst_mem[102], inst_mem[101], inst_mem[100]} = 32'b00000000101011111000111110110011;
       {inst_mem[107], inst_mem[106], inst_mem[105], inst_mem[104]} = 32'b00000000000011111011100110000011; // ld x19, 0(x31)     
       {inst_mem[111], inst_mem[110], inst_mem[109], inst_mem[108]} = 32'b00000000000011110011100100000011; // NEW INSTRUCTION ADDED! ld x18, 0(x30)
       {inst_mem[115], inst_mem[114], inst_mem[113], inst_mem[112]} = 32'b00000001001010011100010001100011;
       {inst_mem[119], inst_mem[118], inst_mem[117], inst_mem[116]} = 32'b00000000000000000000100001100011;
       {inst_mem[123], inst_mem[122], inst_mem[121], inst_mem[120]} = 32'b00000001001111110011000000100011;  // sd x19, 0(x30)
       {inst_mem[127], inst_mem[126], inst_mem[125], inst_mem[124]} = 32'b00000001001011111011000000100011; // sd x18, 0(x31)
       {inst_mem[131], inst_mem[130], inst_mem[129], inst_mem[128]} = 32'b00000000000000000000001001100011;
       {inst_mem[135], inst_mem[134], inst_mem[133], inst_mem[132]} = 32'b00000000000111100000111000010011;
       {inst_mem[139], inst_mem[138], inst_mem[137], inst_mem[136]} = 32'b11111101110111100100110011100011;
       {inst_mem[143], inst_mem[142], inst_mem[141], inst_mem[140]} = 32'b00000000000100110000001100010011;
       {inst_mem[147], inst_mem[146], inst_mem[145], inst_mem[144]} = 32'b11111010011100110100101011100011;
       {inst_mem[151], inst_mem[150], inst_mem[149], inst_mem[148]} = 32'b11111000000000000000100011100011;
       {inst_mem[155], inst_mem[154], inst_mem[153], inst_mem[152]} = 32'b00000000000000000000000000010011;	// last instruction (NOP) -> END: 
    end
  always @ (inst_address)
    begin
      instruction[7:0] = inst_mem[inst_address+0];
      instruction[15:8] = inst_mem[inst_address+1];
      instruction[23:16] = inst_mem[inst_address+2];
      instruction[31:24] = inst_mem[inst_address+3];
    end
endmodule
