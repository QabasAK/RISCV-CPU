module register_file(clk, reset_n, write_enable, read_addr1, read_addr2, write_addr, write_data, read_data1, read_data2);

  input clk;
  input reset_n;
  input write_enable;
  input [4:0] read_addr1, read_addr2, write_addr;
  input [31:0] write_data;
  
  output reg [31:0] read_data1, read_data2;

  reg [31:0] reg_file [0:31];
  integer i;

  // Write or Reset logic
  always @ (negedge clk) begin
    if (!reset_n) begin
      for (i = 0; i < 32; i = i + 1)
        reg_file[i] <= 32'd0;
    end
    else if (write_enable) begin
      if (write_addr != 5'd0)
        reg_file[write_addr] <= write_data;
    end
    reg_file[0] <= 32'd0;
  end

  // Read logic
  always @(*) begin
    read_data1 = reg_file[read_addr1];
    read_data2 = reg_file[read_addr2];
  end

endmodule
