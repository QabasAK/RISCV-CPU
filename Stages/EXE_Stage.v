module EXE_stage(clk, reset_n, ForwardA, ForwardB, ALUresult_EXE_MEM, ALUresult_MEM_WB, readData1, readData2, imm, RegDestination, pc, MemtoReg, ALUOp, WordOrByte, MemRead, MemWrite, ALUSrc, RegWrite, ALUresult, pc_MEM, WriteData_MEM, RegDestination_MEM, MemtoReg_MEM, WordOrByte_MEM, MemRead_MEM, MemWrite_MEM, RegWrite_MEM);
  
  //shared inputs
  input clk, reset_n;
  
  //EXE inputs for ALU & its buffer
  input [31:0] readData1, readData2;
  input [31:0] imm;
  input [31:0] pc;
  
  input [4:0] RegDestination;
  
  //WB control inputs
  input [1:0] MemtoReg;
  input RegWrite; 
  
  //MEM control inputs
  input MemRead, MemWrite, WordOrByte;
  
  //EXE control inputs
  input [3:0] ALUOp;
  input ALUSrc;
  
  //inputs for forwarding
  input [1:0] ForwardA, ForwardB;
  input [31:0] ALUresult_EXE_MEM, ALUresult_MEM_WB;
  
  //outputs to be passed to the following stage
  output [31:0] ALUresult, WriteData_MEM;
  output [31:0] pc_MEM;
  output [4:0] RegDestination_MEM;
  
  // WB control outputs sent from EXE
  output [1:0] MemtoReg_MEM;
  output RegWrite_MEM;
  
  //MEM control outputs sent from EXE
  output WordOrByte_MEM, MemWrite_MEM, MemRead_MEM;
  
  wire [31:0] OpA, OpB;
  wire [31:0] ALUOperand2;
  wire ZeroFlag;
  
  //selecting ALU operand; immediate vs. register data
  MUX2x1 ALUOperand(readData2, imm, ALUSrc, ALUOperand2);
  
  MUX4x1 A_val(readData1, ALUresult_EXE_MEM, ALUresult_MEM_WB, 32'b0, ForwardA, OpA);
  MUX4x1 B(ALUOperand2, ALUresult_EXE_MEM, ALUresult_MEM_WB, 32'b0, ForwardB, OpB);
  
  //performing the correct arithmetic/logical operation 
  ALU Executing(OpA, OpB, ALUresult, ALUOp, ZeroFlag);
  
  assign WriteData_MEM = readData2;
  assign pc_MEM = pc;
  assign RegDestination_MEM = RegDestination;
  
  assign MemtoReg_MEM = MemtoReg;
  assign RegWrite_MEM = RegWrite;
  
  assign WordOrByte_MEM = WordOrByte;
  assign MemWrite_MEM = MemWrite;
  assign MemRead_MEM = MemRead; 
  
endmodule



module EXE_stage_tb();
  
  //defining inputs as registers 
  reg clk, reset_n;
  reg [31:0] readData1, readData2;
  reg [31:0] imm;
  reg [31:0] pc;
  reg [4:0] RegDestination;
  reg [1:0] MemtoReg;
  reg RegWrite; 
  reg MemRead, MemWrite, WordOrByte;
  reg [3:0] ALUOp;
  reg ALUSrc;
  
  //defining outputs as wires
  wire [31:0] ALUresult, WriteData_MEM;
  wire [31:0] pc_MEM;
  wire [4:0] RegDestination_MEM;
  wire [1:0] MemtoReg_MEM;
  wire RegWrite_MEM;
  wire WordOrByte_MEM, MemWrite_MEM, MemRead_MEM;
  
  //instantiate the EXE-stage module 
  EXE_stage testing(clk, reset_n, readData1, readData2, imm, RegDestination, pc, MemtoReg, ALUOp, WordOrByte, MemRead, MemWrite, ALUSrc, RegWrite, ALUresult, pc_MEM, WriteData_MEM, RegDestination_MEM, MemtoReg_MEM, WordOrByte_MEM, MemRead_MEM, MemWrite_MEM, RegWrite_MEM);
  
  always #50 clk = ~clk;
  
  initial 
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, EXE_tb);
    
      clk = 0;
      reset_n = 1'b0;
      
	  readData1 = 32'd50;
      readData2 = 32'd20;
      RegDestination = 5'd2;
      
      imm = 32'd16;
	  pc = 32'd8;
      
	  MemtoReg = 2'b01;
	  ALUOp = 4'b0110;
      WordOrByte = 1'b1;
      MemRead = 1'b1;
      MemWrite = 1'b0;
      ALUSrc = 1'b1;
      RegWrite = 1'b1;
      
      #100 $display(" ALUresult = %d, Memory Data = %d, pc = %d", ALUresult, WriteData_MEM, pc_MEM);
      
      #1000 $finish;
    end
  
endmodule