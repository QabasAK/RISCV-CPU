module ForwardingUnit(ID_EXERegrs1, ID_EXERegrs2,EXE_MEMRegrd, MEM_WBRegrd, EXE_MEM_RegWrite, MEM_WB_RegWrite, ForwardA, ForwardB);
  
  input [4:0] ID_EXERegrs1, ID_EXERegrs2, EXE_MEMRegrd, MEM_WBRegrd;
  input EXE_MEM_RegWrite, MEM_WB_RegWrite;
  
  output reg [1:0] ForwardA, ForwardB;
  
  always @ (ID_EXERegrs1, EXE_MEMRegrd, EXE_MEM_RegWrite, MEM_WBRegrd, MEM_WB_RegWrite)
    begin
      
      if( EXE_MEM_RegWrite && (EXE_MEMRegrd !=0) && (ID_EXERegrs1 == EXE_MEMRegrd))
        begin 
          ForwardA <= 2'b10;
        end
      else if( MEM_WB_RegWrite && (MEM_WBRegrd !=0) && (ID_EXERegrs1 == MEM_WBRegrd))
        begin 
          ForwardA <= 2'b01;
        end
      else 
        begin 
          ForwardA <= 2'b00;
        end
      
    end
  
  always @ (ID_EXERegrs2, EXE_MEMRegrd, EXE_MEM_RegWrite, MEM_WBRegrd, MEM_WB_RegWrite)
    begin 
      
      if( EXE_MEM_RegWrite && (EXE_MEMRegrd !=0) && (ID_EXERegrs2 == EXE_MEMRegrd))
        begin 
          ForwardB <= 2'b10;
        end
      else if( MEM_WB_RegWrite && (MEM_WBRegrd !=0) && (ID_EXERegrs2 == MEM_WBRegrd))
        begin 
          ForwardB <= 2'b01;
        end
      else 
        begin 
          ForwardB <= 2'b00;
        end
      
    end
endmodule

module ForwardingUnit_tb();
  
  reg [4:0] ID_EXERegrs1, ID_EXERegrs2, EXE_MEMRegrd, MEM_WBRegrd;
  reg EXE_MEM_RegWrite, MEM_WB_RegWrite;
  
  wire [1:0] ForwardA, ForwardB;
  
  ForwardingUnit testing(ID_EXERegrs1, ID_EXERegrs2,EXE_MEMRegrd, MEM_WBRegrd, EXE_MEM_RegWrite, MEM_WB_RegWrite, ForwardA, ForwardB);
  
  initial 
    begin
      
      ID_EXERegrs1 = 0;
      ID_EXERegrs2 = 0;
      EXE_MEMRegrd = 5'b111;
      MEM_WBRegrd = 5'b101;
      EXE_MEM_RegWrite = 1'b1;
      MEM_WB_RegWrite = 1'b0;
      #1 $display ("Forward A = %b && Forward B = %b", ForwardA, ForwardB);
      
      ID_EXERegrs1 = 5'd3;
      ID_EXERegrs2 = 5'd6;
      EXE_MEMRegrd = 5'd3;
      MEM_WBRegrd = 5'd9;
      EXE_MEM_RegWrite = 1'b1;
      MEM_WB_RegWrite = 1'b1;
      #1 $display ("Forward A = %b && Forward B = %b", ForwardA, ForwardB);
      
      ID_EXERegrs1 = 5'd3;
      ID_EXERegrs2 = 5'd9;
      EXE_MEMRegrd = 5'd3;
      MEM_WBRegrd = 5'd9;
      EXE_MEM_RegWrite = 1'b1;
      MEM_WB_RegWrite = 1'b1;
      #1 $display ("Forward A = %b && Forward B = %b", ForwardA, ForwardB);
    end
  
endmodule