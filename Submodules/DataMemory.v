module data_memory (clk, reset_n, address, write_enable, read_enable, write_data, read_data, ls);
  
  input clk, reset_n;
  input write_enable, read_enable;
  input ls;   // 0: Byte    1: Word
  
  input [11:0] address;
  input [31:0] write_data;
  
  output reg [31:0] read_data;

  reg [7:0] MEMO[0:4095]; 
  integer i;
  
  always @(negedge clk) begin

    if (reset_n) begin
      // Reset memory with zeros 
      for ( i = 0; i < 4096; i = i + 1) begin
        MEMO[i] <= 8'h00;
      end
     
    end 
   
    read_data <= 32'h00000000;

      if (read_enable) begin
        case (ls)
          2'b0: // Load byte
          begin
            read_data <= MEMO[address][7:0];
             end
          2'b1: // Load word
          begin
            read_data <= {MEMO[address+3][7:0], MEMO[address + 2][7:0], MEMO[address + 1][7:0], MEMO[address ][7:0]};
             end
        endcase
      end
end 

  always @(posedge clk) begin

      if (write_enable) begin
        case (ls)
          2'b00: // Store byte
           begin
              
            MEMO[address] <= write_data[7:0];
        
             end
          2'b01: // Store word 
          begin 
            MEMO[address] <= write_data[7:0];
            MEMO[address + 1] <= write_data[15:8];
            MEMO[address + 2] <= write_data[23:16];
            MEMO[address + 3] <= write_data[31:24];
             end 
        endcase

      end
    end

endmodule