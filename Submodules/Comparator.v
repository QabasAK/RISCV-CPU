module comparator(A, B, BNE, BEQ, branch);
  
  input [31:0] A, B;
  input BNE, BEQ;
  
  output branch;
  
  wire equal;
  
  assign equal = (A==B)? 1 : 0;
  
  assign branch = (!equal & BNE) || (equal & BEQ);
  
endmodule

module comparator_tb();
  
  reg [31:0] A, B;
  reg BNE, BEQ;
  
  wire branch;
  
  comparator testing(A, B, BNE, BEQ, branch);
  
  initial 
    begin
      A = 32'b0;
      B = 32'b1;
      BNE = 1;
      BEQ = 0;
      #1 $display("Branch = %b", branch);
      
      BNE = 0;
      BEQ = 1;
      #1 $display("Branch = %b", branch);
      
      A = 32'b0;
      B = 32'b0;
      BNE = 1;
      BEQ = 0;
      #1 $display("Branch = %b", branch);
      
      BNE = 0;
      BEQ = 1;
      #1 $display("Branch = %b", branch);
    end
  
endmodule
