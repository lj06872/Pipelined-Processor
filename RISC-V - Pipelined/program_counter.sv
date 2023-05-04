module program_counter(
  input [63:0] PC_In,
  input clk,
  input reset,
  input stall, 
  output reg [63:0] PC_Out);
  
  always @(posedge clk or posedge reset)
    begin
      if (reset==1'b1)
        begin        
          PC_Out = 64'd0;
        end
      else if (stall == 1'b0) 
        begin 
          PC_Out = PC_In;
        end
    end
endmodule

