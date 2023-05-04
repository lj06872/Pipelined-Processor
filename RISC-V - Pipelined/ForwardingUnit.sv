module ForwardingUnit
  (
    input [4:0] ID_EX_rs1, //ID/EX.RegisterRs1
    input [4:0] ID_EX_rs2, //ID/EX.RegisterRs2
    input [4:0] EX_MEM_rd, //EX/MEM.RegisterRd
    input [4:0] MEM_WB_rd, //MEM/WB.RegisterRd
    
    input MEM_WB_RegWrite, //MEM/WB.RegWrite
    input EX_MEM_RegWrite, // EX/MEM.RegWrite
    output reg [1:0] forwardA,
    output reg [1:0] forwardB
 );
  
  always @(*)
    begin
    	if ( (EX_MEM_rd == ID_EX_rs1) & (EX_MEM_RegWrite != 0 & EX_MEM_rd !=0))
          begin
          	forwardA = 2'b10;
          end
      	else
          begin 
            // Not condition for MEM hazard 
            if ((MEM_WB_rd== ID_EX_rs1) & (MEM_WB_RegWrite != 0 & MEM_WB_rd != 0) & ~((EX_MEM_rd == ID_EX_rs1) &(EX_MEM_RegWrite != 0 & EX_MEM_rd !=0)  )  )
              begin
                forwardA = 2'b01;
              end
            else
              begin
                forwardA = 2'b00;
              end
          end
      
        if ( (EX_MEM_rd == ID_EX_rs2) & (EX_MEM_RegWrite != 0 & EX_MEM_rd !=0) )
          begin
            forwardB = 2'b10;
          end
        else
          begin
            // Not condition for MEM Hazard 
            if ( (MEM_WB_rd == ID_EX_rs2) & (MEM_WB_RegWrite != 0 & MEM_WB_rd != 0) &  ~((EX_MEM_RegWrite != 0 & EX_MEM_rd !=0 ) & (EX_MEM_rd == ID_EX_rs2) ) )
              begin
                forwardB = 2'b01;
              end
            else
              begin
                forwardB = 2'b00;
              end
          end
    end
endmodule