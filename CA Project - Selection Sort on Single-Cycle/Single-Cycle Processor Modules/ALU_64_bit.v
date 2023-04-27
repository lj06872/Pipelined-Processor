`timescale 1ns / 1ps
//module ALU_64_bit(
// input [63:0] a,
// input [63:0] b,
// input [3:0] Operation,
// input [2:0] func3,
// output reg [63:0] result,
// output reg zero
//);

//  always @(*)
//    begin
//      case(Operation)
//        4'b0000:
//          begin
//            result = a & b;
//          end
//        4'b0001:
//          begin
//            result = a | b;
//          end
//        4'b0010:
//          begin
//            result = a + b;
//          end
//        4'b0110:
//          begin
//            result = a - b;
//          end
//        4'b1100:
//          begin
//            result = ~(a | b);
//          end
//      endcase 
//       case(func3)
//        3'b000:
//          begin
//            if (result == 64'b0)
//              zero = 1;
//            else
//              zero = 0;
//          end
//        3'b100:
//          begin
//            if (b < a)
//              zero = 1;
//            else
//              zero = 0;
//          end
        
//      endcase 
       
//    end
//endmodule 
module ALU_64_bit(
 input [63:0] a,
 input [63:0] b,
 input [3:0] operation,
 input [2:0] func3,
 output reg [63:0] result,
 output reg zero
);

 always @(*)
 begin
 //$monitor("a = %d, b= %d, func3 = %b", a,b,func3);
 case(operation)
 4'b0000: begin //and
 result = a&b;
 end
 4'b0001: begin //or
 result = a|b;
 end
 4'b0010: begin //add
 result = a+b;
 end
 4'b0110: begin //subtract
 result = a-b;
 end
 4'b1100: begin //nor
 result = ~(a|b);
 end
 4'b0100: begin
 result = a << b;
 end
 endcase

 case(func3)
 3'b000: begin
 case(result)
 64'd0: zero = 1'b1;
 default: zero = 1'b0;
 endcase
 end
 3'b100: begin //less than
 if (a < b) begin
 zero = 1'b1;
 end else begin
 zero = 1'b0;
 end
 end
 default: zero = 1'b0;
 endcase
 end


endmodule