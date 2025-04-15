module ControlFlush(jal, jalr, branch, IF_Flush, ID_Flush);
  
  input jal, jalr, branch;
  output IF_Flush, ID_Flush;
  
  assign IF_Flush = (jal || jalr || branch);
  assign ID_Flush = (jal || jalr || branch);
  
endmodule

module ControlFlush_tb();
  
  reg jal, jalr, branch;
  wire IF_Flush, ID_Flush;
  
  ControlFlush testing(jal, jalr, branch, IF_Flush, ID_Flush);
  
  initial 
    begin
      
     jal = 0;
     jalr = 0;
     branch = 0;
     #1 $display("IF_Flush = %b ID_Flush = %b", IF_Flush, ID_Flush);
      
     jal = 0;
     jalr = 1;
     branch = 0;
     #1 $display("IF_Flush = %b ID_Flush = %b", IF_Flush, ID_Flush);
      
     jal = 1;
     jalr = 1;
     branch = 1;
     #1 $display("IF_Flush = %b ID_Flush = %b", IF_Flush, ID_Flush);
    end
  
endmodule