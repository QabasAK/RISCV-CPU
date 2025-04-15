module shiftLeft1(in, out);
  
  input [31:0] in;
  
  output [31:0] out;
  
  assign out = in << 1;
  
endmodule

module shiftLeft1_tb();
  
  reg [31:0] in;
  
  wire [31:0] out;
  
  shiftLeft1 testing(in, out);
  
  initial
    begin
      in=32'd2;
      #1 $display("output = %d", out);
    end
  
endmodule