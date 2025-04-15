module instruction_memory(clk, address, read_data);
  input clk;
  input [31:0] address;
  output reg [31:0] read_data;
  
  reg [7:0] memory [16383:0];
  
  initial 
    begin       
      memory[0]<=8'h1b;
      memory[1]<=8'h01;
      memory[2]<=8'h00;
      memory[3]<=8'h00;
      
      memory[4]<=8'h9b;
      memory[5]<=8'h01;
      memory[6]<=8'h00;
      memory[7]<=8'h00;
      
      memory[8]<=8'h1b;
      memory[9]<=8'h0b;
      memory[10]<=8'h60;
      memory[11]<=8'h01;
      
      memory[12]<=8'h9b;
      memory[13]<=8'h0b;
      memory[14]<=8'h70;
      memory[15]<=8'h01;
      
      memory[16]<=8'h1b;
      memory[17]<=8'h0c;
      memory[18]<=8'h30;
      memory[19]<=8'h00;
      
      memory[20]<=8'h9b;
      memory[21]<=8'h0c;
      memory[22]<=8'h40;
      memory[23]<=8'h00;
      
      memory[24]<=8'h13;
      memory[25]<=8'h6d;
      memory[26]<=8'h9b;
      memory[27]<=8'h07;
      
      memory[28]<=8'h93;
      memory[29]<=8'hfd;
      memory[30]<=8'h9b;
      memory[31]<=8'h04;
      
      memory[32]<=8'hb3;
      memory[33]<=8'h60;
      memory[34]<=8'h7b;
      memory[35]<=8'h01;
      
      memory[36]<=8'h33;
      memory[37]<=8'h51;
      memory[38]<=8'h7c;
      memory[39]<=8'h01;
      
      memory[40]<=8'hb3;
      memory[41]<=8'hb1;
      memory[42]<=8'h21;
      memory[43]<=8'h00;
      
      memory[44]<=8'h33;
      memory[45]<=8'h72;
      memory[46]<=8'hbb;
      memory[47]<=8'h01;
      
      memory[48]<=8'hb3;
      memory[49]<=8'hc2;
      memory[50]<=8'h41;
      memory[51]<=8'h00;
      
      memory[52]<=8'h33;
      memory[53]<=8'ha3;
      memory[54]<=8'ha2;
      memory[55]<=8'h01;
      
      memory[56]<=8'hb3;
      memory[57]<=8'h03;
      memory[58]<=8'h83;
      memory[59]<=8'h01;
      
      memory[60]<=8'h33;
      memory[61]<=8'h94;
      memory[62]<=8'h63;
      memory[63]<=8'h29;
      
      memory[64]<=8'h33;
      memory[65]<=8'h6b;
      memory[66]<=8'h6b;
      memory[67]<=8'h01;
      
      memory[68]<=8'h33;
      memory[69]<=8'h6b;
      memory[70]<=8'h7b;
      memory[71]<=8'h01;
      
      memory[72]<=8'h33;
      memory[73]<=8'h6b;
      memory[74]<=8'h8b;
      memory[75]<=8'h01;
      
      memory[76]<=8'hb8;
      memory[77]<=8'h54;
      memory[78]<=8'h55;
      memory[79]<=8'h55;
    end
  
  always @ (posedge clk)
    begin 
      read_data<={memory[address+3],memory[address+2],memory[address+1],memory[address]};
    end 


endmodule // instruction_memory

module instruction_memory_testbench; 
  reg clk;
  reg [63:0] address;
  wire [31:0] read_data;
  
  always #50 clk= ~ clk;
  
  instruction_memory testing(clk, address, read_data);
  
  initial
    begin
      clk=0;
      address=0;
      #100 $display("Instruction at address %h is %h",address, read_data);
      address=4;
      #100 $display("Instruction at address %h is %h",address, read_data);
      address=8;
      #100 $display("Instruction at address %h is %h",address, read_data);
      address=12;
      #100 $display("Instruction at address %h is %h",address, read_data);
      address=16;
      #100 $display("Instruction at address %h is %h",address, read_data);
      address=20;
      #100 $display("Instruction at address %h is %h",address, read_data);
      address=24;
      #100 $display("Instruction at address %h is %h",address, read_data);
      
    end  
endmodule 