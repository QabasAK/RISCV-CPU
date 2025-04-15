module MEM_stage(clk, reset_n, RegWrite, MemtoReg, MemRead, MemWrite, WordOrByte, MemAddr, WriteData, pc, RegDestination, ReadData, ALUresult, pc_WB, RegWrite_WB, MemtoReg_WB, RegDestination_WB);
  
  //shared inputs 
  input clk, reset_n;
  
  //WB control signals & stage inputs
  input RegWrite;
  input [1:0] MemtoReg;
  input [4:0] RegDestination;
  
  //MEM control signals
  input MemRead, MemWrite, WordOrByte;
  
  //DM inputs & PC
  input [31:0] MemAddr, WriteData;
  input [31:0] pc;
  
  //MEM-stage outputs
  output [31:0] ReadData;
  output [31:0] ALUresult;
  
  //outputs necesaary in the WB stage
  output RegWrite_WB;
  output [1:0] MemtoReg_WB;
  output [4:0] RegDestination_WB;
  output [31:0] pc_WB;
  
  wire [11:0] AddrBits;
  assign AddrBits = MemAddr[11:0];
  
  //reading or writing in the data memory, instruction dependent
  data_memory MEM_DM(clk, reset_n, AddrBits, MemWrite, MemRead, WriteData, ReadData, WordOrByte);
  
  assign RegWrite_WB = RegWrite;
  assign MemtoReg_WB = MemtoReg;
  assign ALUresult = MemAddr;
  assign RegDestination_WB = RegDestination; 
  assign pc_WB = pc + 3'b100;
  
endmodule



module MEM_stage_tb();
  
  //inputs as registers
  reg clk, reset_n;
  reg RegWrite;
  reg [1:0] MemtoReg;
  reg [4:0] RegDestination;
  reg MemRead, MemWrite, WordOrByte;
  reg [31:0] MemAddr, WriteData;
  reg [31:0] pc;
  
  //outputs as wires
  wire [31:0] ReadData;
  wire [31:0] ALUresult;
  wire RegWrite_WB;
  wire [1:0] MemtoReg_WB;
  wire [4:0] RegDestination_WB;
  wire [31:0] pc_WB;
  
  //instantiate the MEM-stage module 
  MEM_stage testing(clk, reset_n, RegWrite, MemtoReg, MemRead, MemWrite, WordOrByte, MemAddr, WriteData, pc, RegDestination, ReadData, ALUresult, pc_WB, RegWrite_WB, MemtoReg_WB, RegDestination_WB);
  
  always #50 clk = ~clk;
  
  //testing
  initial 
    begin
      clk = 0;
      reset_n = 1;
      RegWrite = 0;
      MemtoReg = 0;
      MemRead = 0;
      MemWrite = 0;
      WordOrByte = 0;
      MemAddr = 32'h0;
      WriteData = 32'h0;
      pc = 32'h0;
      RegDestination = 5'h0;
      #100 $display("ReadData = %h ALUresult = %h pc_WB = %h RegWrite = %b MemtoReg = %b RegDestination = %d", ReadData, ALUresult, pc_WB, RegWrite_WB, MemtoReg_WB, RegDestination_WB);
      
      reset_n=0; 
      RegWrite = 0;
      MemtoReg = 0;
      MemRead = 0;
      MemWrite = 1;
      WordOrByte = 0;
      MemAddr = 32'haa;
      WriteData = 32'h11;
      pc = 32'h0;
      RegDestination = 5'h1a;
      #100 $display("ReadData = %h ALUresult = %h pc_WB = %h RegWrite = %b MemtoReg = %b RegDestination = %d", ReadData, ALUresult, pc_WB, RegWrite_WB, MemtoReg_WB, RegDestination_WB);
      
      #1000 $finish;
    end
  
endmodule