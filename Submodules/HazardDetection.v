module Hazard_Detection(ID_EXE_MemRead, IF_ID_Rs1, IF_ID_Rs2, ID_EXE_Rd, pc_write_enable, control_mux, IF_ID_RegWrite);

  input ID_EXE_MemRead;
  input [4:0] IF_ID_Rs1, IF_ID_Rs2, ID_EXE_Rd;

  output reg pc_write_enable;
  output reg control_mux;
  output reg IF_ID_RegWrite;
  
  always @ (*) begin
    if(ID_EXE_MemRead && (ID_EXE_Rd == IF_ID_Rs1 || ID_EXE_Rd == IF_ID_Rs2)) begin
      control_mux = 1'b1;
      pc_write_enable = 1'b0;
      IF_ID_RegWrite = 1'b0;    
    end
    else begin
      control_mux = 1'b0;
      pc_write_enable = 1'b1;
      IF_ID_RegWrite = 1'b1;
    end
  end
  
endmodule

module tb();
  reg ID_EXE_MemRead;
  reg [4:0] IF_ID_Rs1, IF_ID_Rs2, ID_EXE_Rd;

  wire pc_write_enable;
  wire control_mux;
  wire IF_ID_RegWrite;
  
  Hazard_Detection HDU(ID_EXE_MemRead, IF_ID_Rs1, IF_ID_Rs2, ID_EXE_Rd, pc_write_enable, control_mux, IF_ID_RegWrite);

  
  initial begin

    $dumpfile("dump.vcd");
    $dumpvars(0, tb);

    ID_EXE_MemRead = 1'b0;
    IF_ID_Rs1 = 5'd10;
    IF_ID_Rs2 = 5'd3;
    ID_EXE_Rd = 5'd20;
    #20 $display("IF/ID RS1 = %d ", IF_ID_Rs1, "IF/ID RS2 = %d ", IF_ID_Rs2, "ID/EXE Rd = %d ", ID_EXE_Rd, "ID/EXE MemRead = %b ", ID_EXE_MemRead, "PC Write Enable = %b ", pc_write_enable, "Control MUX = %b ", control_mux, "IF/ID RegWrite = %b ", IF_ID_RegWrite);

    ID_EXE_MemRead = 1'b0;
    IF_ID_Rs1 = 5'd10;
    IF_ID_Rs2 = 5'd3;
    ID_EXE_Rd = 5'd10;
    #20 $display("IF/ID RS1 = %d ", IF_ID_Rs1, "IF/ID RS2 = %d ", IF_ID_Rs2, "ID/EXE Rd = %d ", ID_EXE_Rd, "ID/EXE MemRead = %b ", ID_EXE_MemRead, "PC Write Enable = %b ", pc_write_enable, "Control MUX = %b ", control_mux, "IF/ID RegWrite = %b ", IF_ID_RegWrite);

    ID_EXE_MemRead = 1'b1;
    IF_ID_Rs1 = 5'd20;
    IF_ID_Rs2 = 5'd20;
    ID_EXE_Rd = 5'd20;
    #20 $display("IF/ID RS1 = %d ", IF_ID_Rs1, "IF/ID RS2 = %d ", IF_ID_Rs2, "ID/EXE Rd = %d ", ID_EXE_Rd, "ID/EXE MemRead = %b ", ID_EXE_MemRead, "PC Write Enable = %b ", pc_write_enable, "Control MUX = %b ", control_mux, "IF/ID RegWrite = %b ", IF_ID_RegWrite);  
  
    #500 $finish;
  end
endmodule