module Program_Counter
(
	input clk,reset,
	input [63:0] PC_In,
	output reg [63:0] PC_Out
);

	initial 
	PC_Out=64'd0;

	always @ (posedge clk or posedge reset)
	begin
	
		if (reset)
			PC_Out=64'd0;
			
		else
            begin
                PC_Out=PC_In;
            end
	end

endmodule


 // // ** Program Counter for PIPELINED-VERSION ** // // 
 
//module Program_Counter
//(
//	input clk,reset,
//	input [63:0] PC_In,
//	input PC_Write,
//	output reg [63:0] PC_Out
//);

//	initial 
//	PC_Out=64'd0;

//	always @ (posedge clk or posedge reset)
//	begin
	
//		if (reset || PC_Write)
//			PC_Out=64'd0;
			
//		else // hazard_detection_unit condition
//            begin
//                PC_Out=PC_In;
//            end
//	end

//endmodule
