
module twox1Mux(
  input [63:0] A,B,
  input SEL,
  output reg[63:0] out);
  
  always @ (A or B or SEL)
    begin 
      if (SEL==0)
        out=A;
      else
        out=B;
    end
endmodule