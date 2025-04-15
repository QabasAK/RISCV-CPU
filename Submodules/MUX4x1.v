module MUX4x1 (in1, in2, in3, in4, sel, out);
  
  input [31:0] in1, in2, in3, in4;
  input [1:0] sel;
  
  output reg [31:0] out;
  
  always @ (*) 
    begin
      case(sel)
        2'b00: out = in1;
        2'b01: out = in2;
        2'b10: out = in3; 
        2'b11: out = in4; 
      endcase
    end
  
endmodule

module MUX4x1_tb();
  
  reg [31:0] in1, in2, in3, in4;
  reg [1:0] sel;
  wire [31:0] out;
  
  MUX4x1 testing(in1, in2, in3, in4, sel, out);
  
  initial
    begin
      in1=32'd10;
      in2=32'd20;
      in3=32'd30;
      in4=32'd40;
      sel=2'b00;
      #1 $display("When sel = %d output = %d", sel, out);
      sel=2'b01;
      #1 $display("When sel = %d output = %d", sel, out);
      sel=2'b10;
      #1 $display("When sel = %d output = %d", sel, out);
      sel=2'b11;
      #1 $display("When sel = %d output = %d", sel, out);
    end
  
endmodule