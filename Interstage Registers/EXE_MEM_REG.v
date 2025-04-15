module EX_MEM_REG(clk, reset, pc, ALUresult, rs2, rd, WordOrByte, MemRead, MemWrite, MemtoReg, RegWrite, WordOrByte_out, MemRead_out, MemWrite_out, MemtoReg_out, RegWrite_out, pc_out, ALUresult_out, rs2_out, rd_out);
  
  // Input signals from the EX stage
  input clk, reset;
  input [31:0] pc, ALUresult, rs2;
  input [4:0] rd;
  input [1:0] MemtoReg;
  input RegWrite, WordOrByte, MemWrite, MemRead;

  // Values that will outputted when reading from the buffer
  output reg [31:0] pc_out, ALUresult_out, rs2_out;
  output reg [4:0] rd_out;
  output reg [1:0] MemtoReg_out;
  output reg RegWrite_out, WordOrByte_out, MemWrite_out, MemRead_out;
  
  // registers to save the input
  reg [31:0] pc_reg, ALUresult_reg, rs2_reg;
  reg [4:0] rd_reg;
  reg [1:0] MemtoReg_reg;
  reg WordOrByte_reg, MemRead_reg, MemWrite_reg, RegWrite_reg;
  	
  // Write on negative edge
  always @ (negedge clk) begin
    pc_reg <= pc;
    ALUresult_reg <= ALUresult;
    rs2_reg <= rs2;
    rd_reg <= rd;
    MemtoReg_reg <= MemtoReg;
    WordOrByte_reg <= WordOrByte;
    MemRead_reg <= MemRead;
    MemWrite_reg <= MemWrite;
    RegWrite_reg <= RegWrite;
  end
  
  // Read on positive edge
  always @ (posedge clk) begin
    if(reset == 1'b1) begin
      pc_out <= 32'b0;  
      ALUresult_out <= 32'b0;
      rs2_out <=  32'b0;
      rd_out <= 5'b0;
      MemtoReg_out <= 2'b00;
      WordOrByte_out <= 1'b0;
      MemRead_out <= 1'b0;
      MemWrite_out<= 1'b0;
      RegWrite_out <= 1'b0;
    end
    else begin
      pc_out <= pc;  
      ALUresult_out <= ALUresult;
      rs2_out <= rs2;
      rd_out <= rd;
      MemtoReg_out <= MemtoReg;
      WordOrByte_out <= WordOrByte;
      MemRead_out <= MemRead;
      MemWrite_out<= MemWrite;
      RegWrite_out <= RegWrite;     
    end
  end

endmodule


module EX_MEM_tb();
  reg clk, reset;
  reg [31:0] pc, ALUresult, rs2;
  reg [4:0] rd;
  reg [1:0] MemtoReg;
  reg RegWrite, WordOrByte, MemWrite, MemRead;
  
  wire [31:0] pc_out, ALUresult_out, rs2_out;
  wire [4:0] rd_out;
  wire [1:0] MemtoReg_out;
  wire RegWrite_out, WordOrByte_out, MemWrite_out, MemRead_out; 
  
  always #50 clk = ~clk;
  
  // Instantiate Module
  EX_MEM_REG t1(clk, reset, pc, ALUresult, rs2, rd, WordOrByte, MemRead, MemWrite, MemtoReg, RegWrite, WordOrByte_out, MemRead_out, MemWrite_out, MemtoReg_out, RegWrite_out, pc_out, ALUresult_out, rs2_out, rd_out);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, EX_MEM_tb);
    
    clk = 0;
    reset = 1'b0;
    pc= 32'd15;
	ALUresult = 32'd20;
	rs2 = 32'd5;
	rd = 5'd6;
	WordOrByte = 1'bx;
	MemRead = 1'b0;
	MemWrite = 1'b0;
	MemtoReg = 2'b10;
	RegWrite = 1'b1;
    #50 $display("CLK = %b ", clk,"Reset = %b ", reset, "PC = %d ", pc,"ALU Result = %d ", ALUresult,"RS2 = %d ", rs2,"RD = %d ", rd, "Word/Byte = %b ", WordOrByte, "MemRead = %b ", MemRead, "MemWrite = %b ", MemWrite, "MemtoReg = %b ", MemtoReg, "RegWrite = %b", RegWrite);
    
    reset = 1'b0;
    pc= 32'd15;
	ALUresult = 32'd20;
	rs2 = 32'd5;
	rd = 5'd6;
	WordOrByte = 1'bx;
	MemRead = 1'b0;
	MemWrite = 1'b0;
	MemtoReg = 2'b10;
	RegWrite = 1'b1;
    #50 $display("CLK = %b ", clk,"Reset = %b ", reset, "PC = %d ", pc,"ALU Result = %d ", ALUresult,"RS2 = %d ", rs2,"RD = %d ", rd, "Word/Byte = %b ", WordOrByte, "MemRead = %b ", MemRead, "MemWrite = %b ", MemWrite, "MemtoReg = %b ", MemtoReg, "RegWrite = %b", RegWrite);
    
    #100 reset = 1'b1;
    pc = 32'd15;
	ALUresult = 32'd20;
	rs2 = 32'd5;
	rd = 5'd6;
	WordOrByte = 1'bx;
	MemRead = 1'b0;
	MemWrite = 1'b0;
	MemtoReg = 2'b10;
	RegWrite = 1'b1;
    #50 $display("CLK = %b ", clk,"Reset = %b ", reset, "PC = %d ", pc,"ALU Result = %d ", ALUresult,"RS2 = %d ", rs2,"RD = %d ", rd, "Word/Byte = %b ", WordOrByte, "MemRead = %b ", MemRead, "MemWrite = %b ", MemWrite, "MemtoReg = %b ", MemtoReg, "RegWrite = %b", RegWrite);

#1000 $finish;
  end
  
endmodule
