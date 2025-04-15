module immediate_gen(instruction, immediate);
  input [31:0] instruction;
  output reg [31:0] immediate; 
  
  always @ (instruction)
    begin 
      case(instruction[6:0])
        // opcode= 3, 13, 1B, 67 I-format
        7'b0_000_011: 
        begin 
            immediate[11:0]=instruction[31:20];
            immediate[31:12]= {20{instruction[31]}};
          end
        7'b0_010_011:
        begin 
            immediate[11:0]=instruction[31:20];
          immediate[31:12]= {20{instruction[31]}};
          end
        7'b0_011_011:
        begin 
            immediate[11:0]=instruction[31:20];
          immediate[31:12]= {20{instruction[31]}};
          end
        7'b1_100_111:
          begin 
            immediate[11:0]=instruction[31:20];
            immediate[31:12]= {20{instruction[31]}};
          end
        
        //opcode= 23 S-format
        7'b0_100_011:
          begin
            immediate[11:0] ={instruction[31:25], instruction[11:7]};
            immediate[31:12]={20{instruction[31]}};
          end
        
        //opcode= 38 U-format
        7'b0_111_000:
          begin 
            immediate[11:0]=12'b0;
            immediate[31:12]=instruction[31:12];
          end
        
        //opcode= 63 SB-format
         7'b1_100_011:
           begin
             immediate[11:0]={instruction[31],instruction[7],instruction[30:25],instruction[11:8]};
             immediate[31:12]={20{instruction[31]}};
           end
        
        //opcode= 6F UJ-format
         7'b1_101_111:
           begin 
             immediate[19:0]={instruction[31],instruction[19:12],instruction[20],instruction[30:21]};
             immediate[31:20]={12{instruction[31]}};
           end 
       
        default: 
        immediate= 32'b0; 
        
      endcase
    end

endmodule //immediate_gen

module immediate_gen_testbench();

  reg [31:0] instruction;
  wire [31:0] immediate; 
  
  immediate_gen testing(instruction, immediate);
  
  initial 
    begin 
      //I-format (1)
      instruction=32'b101101011010_10101_111_01010_0_010_011;
      // 101101011010
      #2 $display("instruction = %b", instruction, " && immediate = %b", immediate);
      
      //I-format (2)
      instruction=32'b001001011011_10111_101_01010_1_100_111;
      //001001011011
      #2 $display("instruction = %b", instruction, " && immediate = %b", immediate);
      
      //U-format (3)
      instruction=32'b00011000010110011010_10101_0_111_000;
      //00011000010110011010_10101
      #2 $display("instruction = %b", instruction, " && immediate = %b", immediate);
      
      //SB-format (4)
      instruction=32'b1000011_10101_01010_111_11010_1_100_011;
      //100000111101
      #2 $display("instruction = %b", instruction, " && immediate = %b", immediate);
      
      //UJ-format (5)
      instruction=32'b1_0011000001_1_11010011__10101_1_101_111;
      //11101001110011000001
      #2 $display("instruction = %b", instruction, " && immediate = %b", immediate);
      
      //S-format (6)
      instruction=32'b1101011_10101_01010_111_11111_0_100_011;
      //110101111111
      #2 $display("instruction = %b", instruction, " && immediate = %b", immediate);
      
      //DEFAULT
      instruction=32'b0101101_10010_01001_100_10101_0_110_011;
      #2 $display("instruction = %b", instruction, " && immediate = %b", immediate);
    $finish;
    end  
endmodule 