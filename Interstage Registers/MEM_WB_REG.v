module MEM_WB_REG(clk, reset_n, RegWrite, Mem2Reg, ALUresult, MEMresult, JALresult, RegDestination, RegWrite_out, Mem2Reg_out, ALUresult_out, MEMresult_out, JALresult_out, RegDestination_out);
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
  
  //Ouput control inputs for the multiplexer & register file
  output reg RegWrite_out;
  output reg [1:0] Mem2Reg_out;
  
  //Output MUX inputs
  output reg [31:0] ALUresult_out;
  output reg [31:0] MEMresult_out;
  output reg [31:0] JALresult_out;
  
  //Output number of destination register 
  output reg [4:0] RegDestination_out;
  
  //Stored control inputs for the multiplexer & register file
  reg RegWrite_reg;
  reg [1:0] Mem2Reg_reg;
  
  //Stored MUX inputs
  reg [31:0] ALUresult_reg;
  reg [31:0] MEMresult_reg;
  reg [31:0] JALresult_reg;
  
  //Stored number of destination register 
  reg [4:0] RegDestination_reg;
  
  // Write on negative edge
  always @ (negedge clk) begin
  	RegWrite_reg <= RegWrite;
  	Mem2Reg_reg <= Mem2Reg;
  	ALUresult_reg <= ALUresult;
  	MEMresult_reg <= MEMresult;
  	JALresult_reg <= JALresult;
    RegDestination_reg <= RegDestination;
  end
  
  // Read on postive edge
  always @ (posedge clk) begin
    if(reset_n) begin
      RegWrite_out <= 1'b0;
      Mem2Reg_out <= 2'b00;
      ALUresult_out <= 32'b0;
      MEMresult_out <= 32'b0;
      JALresult_out <= 32'b0;
      RegDestination_out <= 5'b0;
    end
    else begin
      RegWrite_out <= RegWrite;
      Mem2Reg_out <= Mem2Reg;
      ALUresult_out <= ALUresult;
      MEMresult_out <= MEMresult;
      JALresult_out <= JALresult;
      RegDestination_out <= RegDestination;   
    end   
  end
  
endmodule //MEM_WB_REG

module MEM_WB_tb();
  reg clk, reset_n;
  reg RegWrite;
  reg [1:0] Mem2Reg;
  reg [31:0] ALUresult;
  reg [31:0] MEMresult;
  reg [31:0] JALresult;
  reg [4:0] RegDestination;
  
  wire RegWrite_out;
  wire [1:0] Mem2Reg_out;
  wire [31:0] ALUresult_out;
  wire [31:0] MEMresult_out;
  wire [31:0] JALresult_out;
  wire [4:0] RegDestination_out;
  
  always #50 clk = ~clk;
  //Instantiate module
  MEM_WB_REG tb(clk, reset_n, RegWrite, Mem2Reg, ALUresult, MEMresult, JALresult, RegDestination, RegWrite_out, Mem2Reg_out, ALUresult_out, MEMresult_out, JALresult_out, RegDestination_out);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, MEM_WB_tb);    
    
    clk = 1'b0;
    reset_n = 1'b1;
    RegWrite = 1'b1;
    Mem2Reg = 2'b01;
    ALUresult = 32'd500;
    MEMresult = 32'd100;
    JALresult = 32'd50;
    RegDestination = 5'd20;
    #50 $display("CLK = %b ", clk, "Reset = %b ", reset_n, "Memory to Register = %b ", Mem2Reg, "ALU Result = %d ", ALUresult, "Memory Result = %d ", MEMresult, "JAL Result = %d ", JALresult, "Register Destination = %d ", RegDestination);
    reset_n = 1'b0;
    RegWrite = 1'b1;
    Mem2Reg = 2'b01;
    ALUresult = 32'd500;
    MEMresult = 32'd100;
    JALresult = 32'd50;
    RegDestination = 5'd20;
    #50 $display("CLK = %b ", clk, "Reset = %b ", reset_n, "Memory to Register = %b ", Mem2Reg, "ALU Result = %d ", ALUresult, "Memory Result = %d ", MEMresult, "JAL Result = %d ", JALresult, "Register Destination = %d ", RegDestination);
    reset_n = 1'b0;
    RegWrite = 1'b1;
    Mem2Reg = 2'b01;
    ALUresult = 32'd500;
    MEMresult = 32'd100;
    JALresult = 32'd50;
    RegDestination = 5'd20;
    #50 $display("CLK = %b ", clk, "Reset = %b ", reset_n, "Memory to Register = %b ", Mem2Reg, "ALU Result = %d ", ALUresult, "Memory Result = %d ", MEMresult, "JAL Result = %d ", JALresult, "Register Destination = %d ", RegDestination);
    #1000 $finish;
  end
endmodule