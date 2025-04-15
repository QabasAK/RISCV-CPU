module tb_cpu();
  reg clk, reset_n;
  
  always #50 clk = ~clk;
  // Instantiate Module
  CPU tb(clk, reset_n);
  
  initial begin
    	$dumpfile("dump.vcd");
    $dumpvars(0, tb_cpu);
		clk = 1'b1;
		reset_n = 1'b1;
		#150;
		reset_n = 1'b0;

		#2500 $finish;
  end
endmodule 