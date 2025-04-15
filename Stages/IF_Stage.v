module IF_stage(clk, reset_n, pc_writeStall, branch, JAL, JALR, branchAddr, JALAddr, JALRAddr, instruction, pc);
  
  //shared inputs
  input clk, reset_n;
  
  //write enable for PC from Hazard Detection 
  input pc_writeStall; 
  
  //addresses inputs for next instruction
  input branch, JAL, JALR;
  input [31:0] branchAddr, JALAddr, JALRAddr;
  
  //outputs of Program counter & Instruction memory
  output [31:0] instruction;
  output [31:0] pc;
  
  wire [1:0] MUXSel;
  wire [31:0] PC_in, PC_out;
  wire [31:0] PCplus4;
  
  //selecting the appropriate value for the program counter
  assign MUXSel = branch? 2'b00 : ( JAL? 2'b01 : (JALR? 2'b10 : (2'b11)));
  MUX4x1 PC_MUX(branchAddr, JALAddr, JALRAddr, PCplus4, MUXSel, PC_in);
  
  //accessing the program counter register for current instruction
  pc_register PC_VAL(clk, reset_n, pc_writeStall, PC_in, PC_out);
  
  //calculating the address of the next instruction (PC + 4)
  adder IF_ADDER(PC_out, 32'h4, 1'b0, PCplus4,);
  
  //reading the instruction to be executed
  instruction_memory IF_MEM(clk, pc, instruction);
  
  assign pc = PC_out;
  
endmodule

module IF_stage_tb();

  //inputs as registers
  reg clk, reset_n;
  reg pc_writeStall;
  reg branch, JAL, JALR;
  reg [31:0] branchAddr, JALAddr, JALRAddr;
  
  //outputs as wires
  wire [31:0] instruction;
  wire [31:0] pc;
  
  //instantiate the IF-stage module
  IF_stage testing(clk, reset_n, pc_writeStall, branch, JAL, JALR, branchAddr, JALAddr, JALRAddr, instruction, pc);
  
  always #50 clk = ~clk;
  
  //testing
  initial 
    begin
      clk = 0;
      reset_n = 0;
      pc_writeStall = 1;
      branch = 1;
      JAL = 0;
      JALR = 0;
      branchAddr = 32'h0;
      JALAddr = 32'h8;
      JALRAddr = 32'h32;
      #100 $display("Instruction = %h PC = %h", instruction, pc);
      
      branch = 0;
      JAL = 1;
      JALR = 0;
      #100 $display("Instruction = %h PC = %h", instruction, pc);
      
      branch = 0;
      JAL = 0;
      JALR = 1;
      #100 $display("Instruction = %h PC = %h", instruction, pc);
      
      branch = 0;
      JAL = 0;
      JALR = 0;
      #100 $display("Instruction = %h PC = %h", instruction, pc);
      
      #1000 $finish; 
    end
  
endmodule