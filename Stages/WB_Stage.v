module WB_stage(clk, reset_n, RegWrite, Mem2Reg, ALUresult, MEMresult, JALresult, RegDestination, WriteData_ID, WriteRegister_ID, RegWrite_ID);
  
  //shared inputs
  input clk, reset_n;
  
  //control inputs for the multiplexer & register file
  input RegWrite;
  input [1:0] Mem2Reg;
  
  //MUX inputs
  input [31:0] ALUresult;
  input [31:0] MEMresult;
  input [31:0] JALresult;
  
  //number of destination register 
  input [4:0] RegDestination;
  
  //WB-stage outputs 
  output [31:0] WriteData_ID;
  output [4:0] WriteRegister_ID;
  output RegWrite_ID; 
  
  //selecting which input depending on the instruction s.t. 00 --> ALU, 01 --> load, 10 --> pc
  MUX4x1 WB_MUX(ALUresult, MEMresult, JALresult, 32'b0, Mem2Reg, WriteData_ID);
  
  assign WriteRegister_ID = RegDestination;
  assign RegWrite_ID = RegWrite;
  
endmodule



module WB_stage_tb();
  
  //inputs as registers
  reg clk, reset_n;
  reg RegWrite;
  reg [1:0] Mem2Reg;
  reg [31:0] ALUresult;
  reg [31:0] MEMresult;
  reg [31:0] JALresult;
  reg [4:0] RegDestination;
  
  //outputs as wires
  wire [31:0] WriteData_ID;
  wire [4:0] WriteRegister_ID;
  wire RegWrite_ID; 
  
  //instantiate the WB-stage module 
  WB_stage testing(clk, reset_n, RegWrite, Mem2Reg, ALUresult, MEMresult, JALresult, RegDestination, WriteData_ID, WriteRegister_ID, RegWrite_ID);
  
  always #50 clk = ~clk;
  
  //testing
  initial 
    begin
      clk = 0;
      reset_n = 0;
      RegWrite = 1'b1;
      Mem2Reg = 2'b00;
      
      ALUresult = 32'h0fdff262;
      MEMresult = 32'h35c8eb66;
      JALresult = 32'h76cae447;
      RegDestination = 5'b01001;
           
      #100 $display("Write Data = %h write register = %d & RegWrite control = %d", WriteData_ID, WriteRegister_ID, RegWrite_ID);
      
      Mem2Reg = 2'b01;
      
      #100 $display("Write Data = %h write register = %d & RegWrite control = %d", WriteData_ID, WriteRegister_ID, RegWrite_ID);
      
      Mem2Reg = 2'b10;
      
      #100 $display("Write Data = %h write register = %d & RegWrite control = %d", WriteData_ID, WriteRegister_ID, RegWrite_ID);
      
      #1000 $finish; 
    end
  
endmodule