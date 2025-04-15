module CPU(clk, reset_n);
  
  input clk, reset_n;
  
  //IF to IF-ID 
  wire [31:0] instruction_IF_ID, pc_IF_ID;
  //IF-ID to ID 
  wire [31:0] instruction_ID, pc_ID;
  wire [4:0] Rs1_ID, Rs2_ID, Rd_ID; 
  
  //ID to ID-EXE 
  wire RegWrite_ID_EXE, JAL_ID_EXE, JALR_ID_EXE, MemRead_ID_EXE, MemWrite_ID_EXE, WordOrByte_ID_EXE, ALUSrc_ID_EXE, branch_ID_EXE;
  wire [1:0] MemtoReg_ID_EXE;
  wire [3:0] ALUOp_ID_EXE;
  wire [4:0] RegDestination_ID_EXE, Rs1_ID_EXE, Rs2_ID_EXE;
  wire [31:0] pc_ID_EXE, readData1_ID_EXE, readData2_ID_EXE, imm_ID_EXE, branchTarget_ID_EXE, JALRTarget_ID_EXE;
  
  //ID-EXE to EXE 
  wire RegWrite_EXE, MemRead_EXE, MemWrite_EXE, WordOrByte_EXE, ALUSrc_EXE;
  wire [1:0] MemtoReg_EXE;
  wire [3:0] ALUOp_EXE;
  wire [4:0] RegDestination_EXE, Rs1_EXE, Rs2_EXE;
  wire [31:0] pc_EXE, readData1_EXE, readData2_EXE, imm_EXE;
  
  
  //EXE to EXE-MEM 
  wire [31:0] ALUresult_EXE_MEM, pc_EXE_MEM, WriteData_EXE_MEM;
  wire [4:0] RegDestination_EXE_MEM;
  wire [1:0] MemtoReg_EXE_MEM;
  wire WordOrByte_EXE_MEM, MemRead_EXE_MEM, MemWrite_EXE_MEM, RegWrite_EXE_MEM;
  //EXE-MEM to MEM 
  wire [31:0] ALUresult_MEM, pc_MEM, WriteData_MEM;
  wire [4:0] RegDestination_MEM;
  wire [1:0] MemtoReg_MEM;
  wire WordOrByte_MEM, MemRead_MEM, MemWrite_MEM, RegWrite_MEM;
  
  
  //MEM to MEM-WB 
  wire [31:0] ReadData_MEM_WB, ALUresult_MEM_WB, pc_MEM_WB;
  wire [1:0] MemtoReg_MEM_WB;
  wire [4:0] RegDestination_MEM_WB;
  wire RegWrite_MEM_WB;
  //MEM-WB to WB 
  wire [31:0] ReadData_WB, ALUresult_WB, pc_WB;
  wire [1:0] MemtoReg_WB;
  wire [4:0] RegDestination_WB;
  wire RegWrite_WB;
  
  //WB to ID 
  wire [4:0] WriteRegister_WB_ID;
  wire [31:0] WriteData_WB_ID;
  wire RegWrite_WB_ID;
  
  //MEM to EXE
  wire [31:0] WriteData_WB;
  assign WriteData_WB_ID = MemtoReg_WB[0]? ReadData_WB : ALUresult_WB;
  
  //ID-EXE to IF 
  wire branch_IF, JAL_IF, JALR_IF;
  wire [31:0] branchAddr_IF, JALAddr_IF, JALRAddr_IF;
  
  wire IF_Flush, ID_Flush;
  
  //Forwarding Unit inputs and outputs
  wire [4:0] EXE_MEM_Rd, MEM_WB_Rd, ID_EXE_Rs1, ID_EXE_Rs2;
  wire [1:0] ForwardA, ForwardB;
  
  //Hazard Detection Unit
  wire pcWrite_Stall;
  wire MUXsel_ID;
  wire IF_ID_WriteEnable;
  
  wire [31:0] Forward_ALUresult;
  wire [31:0] Forward_WriteData;
  
  ControlFlush branching(JAL_IF, JALR_IF, branch_IF, IF_Flush, ID_Flush);

  ForwardingUnit forwarding(Rs1_EXE, Rs2_EXE, RegDestination_MEM, RegDestination_WB, RegWrite_EXE_MEM, RegWrite_MEM_WB, ForwardA, ForwardB);
  
  Hazard_Detection detecting(MemRead_ID_EXE, Rs1_ID, Rs2_ID, Rd_ID, pcWrite_Stall, MUXsel_ID, IF_ID_WriteEnable);
  
  //clk, reset_n, pc_writeStall, branch, JAL, JALR, branchAddr, JALAddr, JALRAddr, instruction, pc
  IF_stage FETCH(clk, reset_n, pcWrite_Stall, branch_IF, JAL_IF, JALR_IF, branchAddr_IF, JALAddr_IF, JALRAddr_IF, instruction_IF_ID, pc_IF_ID);
  
  //clk, reset_n, IF_Flush, pc, instruction, pc_out, instruction_out, Rs1_ID, Rs2_ID, Rd_ID
  IF_ID_REG REG1(clk, reset_n, IF_Flush,IF_ID_WriteEnable, pc_IF_ID, instruction_IF_ID, pc_ID, instruction_ID, Rs1_ID, Rs2_ID, Rd_ID);
  
  
  //clk, reset_n, instruction, pc, MUXsel_Hazard, RegDestination_in, Rs1_in, Rs2_in, RegWrite_ID, WriteData_ID, WriteRegister_ID, JAL, JALR, MemRead, MemWrite, WordOrByte,RegWrite, ALUSrc, MemtoReg, ALUOp, branch, pc_EXE, readData1, readData2, imm, RegDestination, Rs1_Out, Rs2_Out, branchTarget, JALRTarget
  ID_stage DECODE(clk, reset_n, instruction_ID, pc_ID, MUXsel_ID, Rd_ID, Rs1_ID, Rs2_ID, RegWrite_WB_ID, WriteData_WB_ID, WriteRegister_WB_ID, JAL_ID_EXE, JALR_ID_EXE, MemRead_ID_EXE, MemWrite_ID_EXE, WordOrByte_ID_EXE, RegWrite_ID_EXE, ALUSrc_ID_EXE, MemtoReg_ID_EXE, ALUOp_ID_EXE, branch_ID_EXE, pc_ID_EXE, readData1_ID_EXE, readData2_ID_EXE, imm_ID_EXE, RegDestination_ID_EXE, Rs1_ID_EXE, Rs2_ID_EXE, branchTarget_ID_EXE, JALRTarget_ID_EXE);
  
  //clk, reset_n, ID_Flush, Rs1_ID, Rs2_ID, JAL_ID, JALR_ID, MemRead_ID, MemWrite_ID, WordOrByte_ID, RegWrite_ID, ALUSrc_ID, MemtoReg_ID, ALUOp_ID, branch_ID, pc_ID, readData1_ID, readData2_ID, imm_ID, RegDestination_ID, branchTarget_ID, JALRTarget_ID, JAL_EXE, JALR_EXE, MemRead_EXE, MemWrite_EXE, WordOrByte_EXE, RegWrite_EXE, ALUSrc_EXE, MemtoReg_EXE, ALUOp_EXE, branch_EXE, pc_EXE, readData1_EXE, readData2_EXE, imm_EXE, RegDestination_EXE, Rs1_EXE, Rs2_EXE, branchTarget_EXE, JALRTarget_EXE
  ID_EXE_REG REG2(clk, reset_n, ID_Flush, Rs1_ID_EXE, Rs2_ID_EXE, JAL_ID_EXE, JALR_ID_EXE, MemRead_ID_EXE, MemWrite_ID_EXE, WordOrByte_ID_EXE, RegWrite_ID_EXE, ALUSrc_ID_EXE, MemtoReg_ID_EXE, ALUOp_ID_EXE, branch_ID_EXE, pc_ID_EXE, readData1_ID_EXE, readData2_ID_EXE, imm_ID_EXE, RegDestination_ID_EXE, branchTarget_ID_EXE, JALRTarget_ID_EXE, JAL_IF, JALR_IF, MemRead_EXE, MemWrite_EXE, WordOrByte_EXE, RegWrite_EXE, ALUSrc_EXE, MemtoReg_EXE, ALUOp_EXE, branch_IF, pc_EXE, readData1_EXE, readData2_EXE, imm_EXE, RegDestination_EXE, Rs1_EXE, Rs2_EXE, branchAddr_IF, JALRAddr_IF);

  
  //clk, reset_n, ForwardA, ForwardB, ALUresult_EXE_MEM, ALUresult_MEM_WB, readData1, readData2, imm, RegDestination, pc, MemtoReg, ALUOp, WordOrByte, MemRead, MemWrite, ALUSrc, RegWrite, ALUresult, pc_MEM, WriteData_MEM, RegDestination_MEM, MemtoReg_MEM, WordOrByte_MEM, MemRead_MEM, MemWrite_MEM, RegWrite_MEM
  EXE_stage EXECUTE(clk, reset_n, ForwardA, ForwardB, Forward_ALUresult, Forward_WriteData, readData1_EXE, readData2_EXE, imm_EXE, RegDestination_EXE, pc_EXE, MemtoReg_EXE, ALUOp_EXE, WordOrByte_EXE, MemRead_EXE, MemWrite_EXE, ALUSrc_EXE, RegWrite_EXE, ALUresult_EXE_MEM, pc_EXE_MEM, WriteData_EXE_MEM, RegDestination_EXE_MEM, MemtoReg_EXE_MEM, WordOrByte_EXE_MEM, MemRead_EXE_MEM, MemWrite_EXE_MEM, RegWrite_EXE_MEM);
  
  //clk, reset, pc, ALUresult, rs2, rd, WordOrByte, MemRead, MemWrite, MemtoReg, RegWrite, WordOrByte_out, MemRead_out, MemWrite_out, MemtoReg_out, RegWrite_out, pc_out, ALUresult_out, rs2_out, rd_out
  EX_MEM_REG REG3(clk, reset_n, pc_EXE_MEM, ALUresult_EXE_MEM, WriteData_EXE_MEM, RegDestination_EXE_MEM, WordOrByte_EXE_MEM, MemRead_EXE_MEM, MemWrite_EXE_MEM, MemtoReg_EXE_MEM, RegWrite_EXE_MEM, WordOrByte_MEM, MemRead_MEM, MemWrite_MEM, MemtoReg_MEM, RegWrite_MEM, pc_MEM, ALUresult_MEM, WriteData_MEM, RegDestination_MEM);
  
  MEM_stage MEMORY(clk, reset_n, RegWrite_MEM, MemtoReg_MEM, MemRead_MEM, MemWrite_MEM, WordOrByte_MEM, ALUresult_MEM, WriteData_MEM, pc_MEM, RegDestination_MEM, ReadData_MEM_WB, ALUresult_MEM_WB, pc_MEM_WB, RegWrite_MEM_WB, MemtoReg_MEM_WB, RegDestination_MEM_WB);
  
  MEM_WB_REG REG4(clk, reset_n, RegWrite_MEM_WB, MemtoReg_MEM_WB, ALUresult_MEM_WB, ReadData_MEM_WB, pc_MEM_WB, RegDestination_MEM_WB, RegWrite_WB, MemtoReg_WB, ALUresult_WB, ReadData_WB, pc_WB, RegDestination_WB);

  WB_stage WRITEBACK(clk, reset_n, RegWrite_WB, MemtoReg_WB, ALUresult_WB, ReadData_WB, pc_WB, RegDestination_WB, WriteData_WB_ID, WriteRegister_WB_ID, RegWrite_WB_ID);
  
  assign JALAddr_IF = branchAddr_IF;
  assign Forward_ALUresult = ALUresult_MEM;
  assign Forward_WriteData = MemtoReg_WB[0] ? ReadData_WB : ALUresult_WB ;

endmodule
