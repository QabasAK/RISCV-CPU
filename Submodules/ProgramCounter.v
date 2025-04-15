module pc_register(clk, reset_n, write_enable, data_in, data_out);
	input clk, reset_n, write_enable;
	input [31:0] data_in;
	output reg [31:0] data_out;
	
	reg [31:0] pc;
				
	always @ (negedge clk) begin
	    if(reset_n) begin
	        pc <= 32'b0;
	    end
	    else if(write_enable) begin
	        pc <= data_in;
	    end
	end
	
	always @ (*) data_out <= pc;
	
endmodule