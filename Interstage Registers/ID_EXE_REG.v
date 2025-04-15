module ID_EXE_REG(clk, reset_n, ID_Flush, Rs1_ID, Rs2_ID, JAL_ID, JALR_ID, MemRead_ID, MemWrite_ID, WordOrByte_ID, RegWrite_ID, ALUSrc_ID, MemtoReg_ID, ALUOp_ID, branch_ID, pc_ID, readData1_ID, readData2_ID, imm_ID, RegDestination_ID, branchTarget_ID, JALRTarget_ID, JAL_EXE, JALR_EXE, MemRead_EXE, MemWrite_EXE, WordOrByte_EXE, RegWrite_EXE, ALUSrc_EXE, MemtoReg_EXE, ALUOp_EXE, branch_EXE, pc_EXE, readData1_EXE, readData2_EXE, imm_EXE, RegDestination_EXE, Rs1_EXE, Rs2_EXE, branchTarget_EXE, JALRTarget_EXE);


  input clk, reset_n;
  
  input JAL_ID, JALR_ID, MemRead_ID, MemWrite_ID, WordOrByte_ID, RegWrite_ID, ALUSrc_ID;
  input [1:0] MemtoReg_ID; 
  input [3:0] ALUOp_ID;
  input branch_ID;
  input [31:0] pc_ID;
  input [31:0] readData1_ID, readData2_ID;
  input [31:0] imm_ID;
  input [4:0] RegDestination_ID, Rs1_ID, Rs2_ID;
  input [31:0] branchTarget_ID;
  input [31:0] JALRTarget_ID;
  input ID_Flush;
  
  output reg JAL_EXE, JALR_EXE, MemRead_EXE, MemWrite_EXE, WordOrByte_EXE, RegWrite_EXE, ALUSrc_EXE;
  output reg [1:0] MemtoReg_EXE; 
  output reg [3:0] ALUOp_EXE;
  output reg branch_EXE;
  output reg [31:0] pc_EXE;
  output reg [31:0] readData1_EXE, readData2_EXE;
  output reg [31:0] imm_EXE;
  output reg [4:0] RegDestination_EXE, Rs1_EXE, Rs2_EXE;
  output reg [31:0] branchTarget_EXE;
  output reg [31:0] JALRTarget_EXE;
  
  always @ (posedge clk)
    begin
      if(reset_n || ID_Flush)
        begin
          JAL_EXE <= 1'b0;
          JALR_EXE <= 1'b0;
          MemRead_EXE <= 1'b0;
          MemWrite_EXE <= 1'b0;
          WordOrByte_EXE <= 1'b0;
          RegWrite_EXE <= 1'b0;
          ALUSrc_EXE <= 1'b0;
          MemtoReg_EXE <= 2'b00;
          ALUOp_EXE <= 4'b0;
          branch_EXE <= 1'b0;
          pc_EXE <= 32'b0;
          readData1_EXE <= 32'b0;
          readData2_EXE <= 32'b0;
          imm_EXE <= 32'b0;
          RegDestination_EXE <= 5'b0;
	  Rs1_EXE <= 5'b0;
	  Rs2_EXE <= 5'b0;
          branchTarget_EXE <= 32'b0;
          JALRTarget_EXE <= 32'b0;
        end
      else 
        begin
          JAL_EXE <= JAL_ID;
          JALR_EXE <= JALR_ID;
          MemRead_EXE <= MemRead_ID;
          MemWrite_EXE <= MemWrite_ID;
          WordOrByte_EXE <= WordOrByte_ID;
          RegWrite_EXE <= RegWrite_ID;
          ALUSrc_EXE <= ALUSrc_ID;
          MemtoReg_EXE <= MemtoReg_ID;
          ALUOp_EXE <= ALUOp_ID;
          branch_EXE <= branch_ID;
          pc_EXE <= pc_ID;
          readData1_EXE <= readData1_ID;
          readData2_EXE <= readData2_ID;
          imm_EXE <= imm_ID;
          RegDestination_EXE <= RegDestination_ID;
	  Rs1_EXE <= Rs1_ID;
	  Rs2_EXE <= Rs2_ID;
          branchTarget_EXE <= branchTarget_ID;
          JALRTarget_EXE <= JALRTarget_ID;
        end
    end

endmodule // ID_EXE_REG
