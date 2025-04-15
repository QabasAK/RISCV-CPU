module ID_stage(clk, reset_n, instruction, pc, MUXsel_Hazard, RegDestination_in, Rs1_in, Rs2_in, RegWrite_ID, WriteData_ID, WriteRegister_ID, JAL, JALR, MemRead, MemWrite, WordOrByte,RegWrite, ALUSrc, MemtoReg, ALUOp, branch, pc_EXE, readData1, readData2, imm, RegDestination, Rs1_Out, Rs2_Out, branchTarget, JALRTarget);
  
  //shared inputs
  input clk, reset_n;
  
  //input from Hazard Detection
  input MUXsel_Hazard;
  
  //IF stage inputs
  input [31:0] instruction;
  input [31:0] pc;
  input [4:0] RegDestination_in, Rs1_in, Rs2_in;
  
  //WB stage inputs
  input RegWrite_ID;
  input [31:0] WriteData_ID;
  input [4:0] WriteRegister_ID;
  
  //Control unit outputs
  output JAL, JALR, MemRead, MemWrite, WordOrByte, RegWrite, ALUSrc;
  output [1:0] MemtoReg; 
  output [3:0] ALUOp;
 
  output branch;
  
  //outputs for next stages
  output [31:0] pc_EXE;
  output [31:0] readData1, readData2;
  output [31:0] imm;
  output [4:0] RegDestination, Rs1_Out, Rs2_Out;
  
  //branch outcome & jump addresses
  output [31:0] branchTarget;
  output [31:0] JALRTarget;
  
  wire BEQ, BNE;
  wire [31:0] shiftedImm;
  
  //controlling the datapath based on the given instruction
  control_unit ID_CU(instruction[6:0], instruction[14:12], MUXsel_Hazard, BEQ, BNE, JAL, JALR, WordOrByte, MemRead, MemWrite, ALUOp, MemtoReg, ALUSrc, RegWrite);
  
  //accessing the required registers 
  register_file ID_RegFile(clk, reset_n, Rs1_in, Rs2_in, WriteRegister_ID, RegWrite_ID, WriteData_ID, readData1, readData2);
  
  //generating the immediate for ALU, Memory or Jumps
  immediate_gen ID_ImmGen(instruction, imm);
  
  //determining branch equality & inequality
  comparator ID_Branch(readData1, readData2, BNE, BEQ, branch);
  
  //preparing the immediate if the instruction is branch and it is taken
  shiftLeft1 ID_ImmPrep(imm, shiftedImm);
  
  //preparing the address of the next instruction if not fall-through
  adder branchTargetAddr(pc, shiftedImm, 1'b0, branchTarget,);
  adder jumpAddress(readData1, imm, 1'b0, JALRTarget,);
  
  assign pc_EXE = pc;
  assign RegDestination = RegDestination_in;
  assign Rs1_Out = Rs1_in;
  assign Rs2_Out = Rs2_in;
  
endmodule



module ID_stage_tb();
  
  //inputs as registers
  reg clk, reset_n;
  reg [31:0] instruction;
  reg [31:0] pc;
  reg RegWrite_ID;
  reg [31:0] WriteData_ID;
  reg [4:0] WriteRegister_ID;
  
  //outputs as wires
  wire JAL, JALR, MemRead, MemWrite, WordOrByte, RegWrite, ALUSrc;
  wire [1:0] MemtoReg; 
  wire [3:0] ALUOp;
  wire branch;
  wire [31:0] pc_EXE;
  wire [31:0] readData1, readData2;
  wire [31:0] imm;
  wire [4:0] RegDestination;
  wire [31:0] branchTarget;
  wire [31:0] JALRTarget;
  
  //instantiate the ID-stage module
  ID_stage testing(clk, reset_n, instruction, pc, RegWrite_ID, WriteData_ID, WriteRegister_ID, JAL, JALR, MemRead, MemWrite, WordOrByte,RegWrite, ALUSrc, MemtoReg, ALUOp, branch, pc_EXE, readData1, readData2, imm, RegDestination, branchTarget, JALRTarget);
  
  always #50 clk = ~clk;
  
  //testing
  initial 
    begin
      clk = 0;
      reset_n = 0;
      instruction = 32'h00000083;
      pc = 32'h24cc24ed;
      RegWrite_ID = 0;
      WriteData_ID = 32'hd8275365;
      WriteRegister_ID = 5'b00101;
      #100 $display("JAL = %b JALR = %b MemRead = %b MemWrite = %b WordOrByte = %b RegWrite = %b ALUSrc = %b MemtoReg = %b ALUOp = %b branch = %b PC = %h Data1 = %h Data2 = %h imm = %h Rd = %b", JAL, JALR, MemRead, MemWrite, WordOrByte,RegWrite, ALUSrc, MemtoReg, ALUOp, branch, pc_EXE, readData1, readData2, imm, RegDestination);
      #1000 $finish;
    end
  
endmodule