module tb();
  reg clk, reset;
  wire [63:0] element1;
  wire [63:0] element2;
  wire [63:0] element3;

  wire stall;
  wire flush;
  
  RISC_V_Processor r1
  (
    .clk(clk),
    .reset(reset),
    .element1(element1),
    .element2(element2),
    .element3(element3),
    .stall(stall),
    .flush(flush)
  );
  
  initial 
    begin
      
      $dumpfile("dump.vcd");
      $dumpvars(1, tb);
		
      clk = 1'b0;
      reset = 1'b1;
      
      #7 
      reset = 1'b0;
      
    end
  
  always
    begin
      #5
      clk = ~clk;
    end
endmodule
