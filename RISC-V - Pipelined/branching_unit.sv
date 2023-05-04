module branching_unit
  (
   input [2:0] funct3,
    input [63:0] ReadData1,
    input [63:0] b,
   output reg comparator_signal
  );
  
  initial
    begin
      comparator_signal = 1'b0;
    end
  
  always @(*)
	begin
      case (funct3)
        3'b000:
          begin
            if (ReadData1 == b)  // beq
              comparator_signal = 1'b1;
            else
              comparator_signal = 1'b0;
            end
         3'b100:
    		begin
              if (ReadData1 < b)  // blt
              comparator_signal = 1'b1;
            else
              comparator_signal = 1'b0;
            end
        3'b101:
          begin
            if (ReadData1 > b)   // bgt
          	comparator_signal = 1'b1;
           else
              comparator_signal = 1'b0;
          end    
      endcase
     end
endmodule