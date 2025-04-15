module IF_ID_REG(clk, reset_n, IF_Flush, IF_ID_RegWrite, pc, instruction, pc_out, instruction_out, Rs1_ID, Rs2_ID, Rd_ID);
  
  // Shared inputs
  input clk, reset_n;
  
  // Inputs from instruction fecth stage
  input [31:0] pc, instruction;
  
  // Output is the values stored
  output reg [31:0] pc_out, instruction_out;
  output reg [4:0] Rs1_ID, Rs2_ID, Rd_ID;

  
  //Hazard Detection and Stalling
  input IF_Flush, IF_ID_RegWrite;
  
  always @ (posedge clk)
    begin
      if(reset_n || IF_Flush)
        begin
          Rs1_ID <= 0;
          Rs2_ID <= 0;
          Rd_ID <= 0;
          pc_out <= 0;
          instruction_out <= 0;
        end
      else if (IF_ID_RegWrite)
        begin
          Rs1_ID <= instruction[19:15];
          Rs2_ID <= instruction[24:20];
          Rd_ID <= instruction[11:7];
          pc_out <= pc;
          instruction_out <= instruction;
        end
    end

endmodule //IF_ID_REG