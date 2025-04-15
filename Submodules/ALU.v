module ALU(A, B, ALU_Result, ALUOpCode, ZeroFlag);
  
  input [31:0] A, B;
  input [3:0] ALUOpCode;
  
  output reg [31:0] ALU_Result;
  output reg ZeroFlag; 


always @* begin
    case(ALUOpCode)
        4'b0000: ALU_Result = A >> B;
        4'b0001: ALU_Result = A - B;
        4'b0010: ALU_Result = A << B;
        4'b0011: ALU_Result = A | B;
        4'b0100: ALU_Result = (A < B) ? 32'b1 : 32'b0;
        4'b0101: ALU_Result = A & B;
        4'b0110: ALU_Result = A + B;
        4'b0111: ALU_Result = A ^B;
    	4'b1000: begin
                  ALU_Result[11:0]=12'b0;
		          ALU_Result[31:12]=B[19:0];
		 end

    endcase
    
    ZeroFlag = (ALU_Result == 32'b0); 
end

endmodule

module ALU_tb();
  
  reg [31:0] A, B;
  reg [3:0] ALUOpCode;
  
  wire [31:0] ALUResult;
  wire ZeroFlag;
  
  ALU testing(A, B, ALUResult, ALUOpCode, ZeroFlag);
  
  initial
    begin
      A = 1;
      B = 2;
      ALUOpCode=4'd0;
      #1 $display("OP:0 (SHIFTLEFT) Result: %h, Zero: %b",ALUResult, ZeroFlag);
      
      ALUOpCode=4'd1;
      #1 $display("OP:1 (SUBTRACT) Result: %h, Zero: %b",ALUResult, ZeroFlag);
      
      ALUOpCode=4'd2;
      #1 $display("OP:2 (SHIFTRIGHT) Result: %h, Zero: %b",ALUResult, ZeroFlag);
      
      ALUOpCode=4'd3;
      #1 $display("OP:3 (OR) Result: %h, Zero: %b",ALUResult, ZeroFlag);
      
      ALUOpCode=4'd4;
      #1 $display("OP:4 (SET IF LESS THAN) Result: %h, Zero: %b",ALUResult, ZeroFlag);
      
      ALUOpCode=4'd5;
      #1 $display("OP:5 (AND) Result: %h, Zero: %b",ALUResult, ZeroFlag);
      
      ALUOpCode=4'd6;
      #1 $display("OP:6 (ADD) Result: %h, Zero: %b",ALUResult, ZeroFlag);
      
      ALUOpCode=4'd7;
      #1 $display("OP:7 (XOR) Result: %h, Zero: %b",ALUResult, ZeroFlag);
      
      ALUOpCode=4'd8;
      #1 $display("OP:8 (LUI) Result: %h, Zero: %b",ALUResult, ZeroFlag);
    end
  
endmodule