module MUX2x1(in1, in2, sel, out);

  input [31:0] in1, in2;
  input sel;

  output reg [31:0] out;
	
  always @ (*) begin
	case(sel)
		1'b0: out = in1;
		1'b1: out = in2;
	endcase
  end
endmodule


module MUX2x1_tb();
  reg [31:0] in1, in2;
  reg sel;
  wire [31:0] out;
  
  MUX2x1 testing(in1, in2, sel, out);
  
  initial 
    begin
      in1 = 32'h2cbd0b5d;
      in2 = 32'hdcf83f6f;
      sel =1'b0;
      #1 $display("When sel = %d Result = %h", sel, out);
      sel =1'b1;
      #1 $display("When sel = %d Result = %h", sel, out);
    end
  
endmodule