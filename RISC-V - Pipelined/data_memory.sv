
module data_memory
  (input [63:0] write_data,
   input [63:0] address,
   input memorywrite, clk,memoryread,
   output reg [63:0] read_data,
  output [63:0] element1,
  output [63:0] element2,
  output [63:0] element3);
  
  reg [7:0] mem [63:0];
  integer i;
  initial
    begin
      for (i=0; i<64; i=i+1)
        begin
          mem[i] = 0;
    
        end
//      mem[0] = 8'd1;
//      mem[8] = 8'd2;
//      mem[16] = 8'd3;
//      mem[24] = 8'd4;
//      mem[32] = 8'd5;
//      mem[40] = 8'd6;
//      mem[48] = 8'd7;
//      mem[56] = 8'd8;
    end
  
  
  assign element1 = {mem[7],mem[6],mem[5],mem[4],mem[3],mem[2],mem[1],mem[0]};
  assign element2 = {mem[15],mem[14],mem[13],mem[12],mem[11],mem[10],mem[9],mem[8]};
  assign element3 = {mem[23],mem[22],mem[21],mem[20],mem[19],mem[18],mem[17],mem[16]};

  
  always @ (*)
    begin
      if (memoryread)
        begin
          read_data[7:0] = mem[address+0];
          read_data[15:8] = mem[address+1];
          read_data[23:16] = mem[address+2];
          read_data[31:24] = mem[address+3];
          read_data[39:32] = mem[address+4];
          read_data[47:40] = mem[address+5];
          read_data[55:48] = mem[address+6];
          read_data[63:56] = mem[address+7];
        end
    end
  always @(posedge clk)
    begin
      if (memorywrite)
        begin
          mem[address] = write_data[7:0];
          mem[address+1] = write_data[15:8];
          mem[address+2] = write_data[23:16];
          mem[address+3] = write_data[31:24];
          mem[address+4] = write_data[39:32];
          mem[address+5] = write_data[47:40];
          mem[address+6] = write_data[55:48];
          mem[address+7] = write_data[63:56];
        end
    end
endmodule

