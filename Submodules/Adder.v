module adder(A, B, Cin, S, Cout);
  
  input [31:0] A, B;
  input Cin;
  
  output [31:0] S;
  output Cout; 
  
  assign {Cout, S} = A + B + Cin;
  
endmodule

module adder_tb();
  
  reg [31:0] A, B;
  reg Cin;
  
  wire [31:0] S;
  wire Cout;
  
  adder testing(A, B, Cin, S, Cout);
  
  initial 
    begin
      A = 32'd10;
      B = 32'd15;
      Cin = 1'b0;
      #1 $display ("Sum = %d and Carry = %d", S, Cout);
    end
  
endmodule