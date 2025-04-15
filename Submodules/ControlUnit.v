module control_unit(OPCODE, FUNCT3, MUXsel_Hazard, BEQ, BNE, JAL, JALR, wordOrByte, MemRead, MemWrite, ALUOp, MemtoReg, ALUSrc, RegWrite);
	input [6:0] OPCODE;
	input [2:0] FUNCT3;
	input MUXsel_Hazard;
	output reg [1:0] MemtoReg;
	output reg [3:0] ALUOp;
	output reg BEQ, BNE, JAL, JALR, wordOrByte, MemRead, MemWrite, ALUSrc, RegWrite; 
	
	always @ (OPCODE or FUNCT3 or MUXsel_Hazard) begin
		{RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, ALUOp, BEQ, BNE, JAL, JALR} <= 0;

		case(OPCODE)
		// OPCODE = 3
			7'b0000011: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b0;
				JALR = 1'b0;
			// lw
				if(FUNCT3 == 3'b000) begin
					wordOrByte = 1'b1;
				end
			// lb
				else if(FUNCT3 == 3'b010) begin
					wordOrByte = 1'b0;
				end
				else begin
					wordOrByte = 1'bx; // ERROR
				end
				MemRead = 1'b1;
				MemWrite = 1'b0;
				ALUOp = 4'b0110;
				MemtoReg = 2'b01;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end
			
		// OPCODE = 13
			7'b0001101: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b0;
				JALR = 1'b0;
			// andi
				if(FUNCT3 == 3'b110) begin
					ALUOp = 4'b0101;
				end
			// ori
				else if(FUNCT3 == 3'b111) begin
					ALUOp = 4'b0011;
				end
				else begin
					ALUOp = 4'bxxxx; // ERROR
				end
				wordOrByte = 1'bx;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 2'b00;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end
			
		// OPCODE = 1B, addi
			7'b0011011: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b0;
				JALR = 1'b0;
				if(FUNCT3 == 3'b000) begin
					ALUOp = 4'b0110;
				end
				else begin
					ALUOp = 4'bxxxx; // ERROR
				end
				wordOrByte = 1'bx;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 2'b00;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end
			
		// OPCODE = 23
			7'b0100011: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b0;
				JALR = 1'b0;
			// sw
				if(FUNCT3 == 3'b000) begin
					ALUOp = 4'b0110;
					wordOrByte = 1'b1;
				end
			// sb
				else if(FUNCT3 == 3'b010) begin
					ALUOp = 4'b0110;
					wordOrByte = 1'b0;
				end
				else begin
					ALUOp = 4'bxxxx; // ERROR
					wordOrByte = 1'bx; // ERROR
				end
				MemRead = 1'b0;
				MemWrite = 1'b1;
				MemtoReg = 2'b00;
				ALUSrc = 1'b1;
				RegWrite = 1'b0;
			end
			
		// OPCODE = 33, R-type
			7'b0110011: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b0;
				JALR = 1'b0;
				wordOrByte = 1'bx;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				ALUOp = {1'b0, FUNCT3};
				MemtoReg = 2'b00;
				ALUSrc = 1'b0;
				RegWrite = 1'b1;
			end
			
		// OPCODE = 38, lui
			7'b0111000: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b0;
				JALR = 1'b0;
				wordOrByte = 1'bx;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				ALUOp = 4'b1000;
				MemtoReg = 2'b00;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end
			
		// OPCODE = 63
			7'b1100011: begin
			// bne
				if(FUNCT3 == 3'b000) begin
					BEQ = 1'b0;
					BNE = 1'b1;
					ALUOp = 4'b0111;
				end
			// beq
				else if(FUNCT3 == 3'b001) begin
					BEQ = 1'b1;
					BNE = 1'b0;
					ALUOp = 4'b0001;
				end
				else begin
					BEQ = 1'b0; // ERROR
					BNE = 1'b0; // ERROR
					ALUOp = 4'b0; // ERROR
				end
				JAL = 1'b0;
				JALR = 1'b0;
				wordOrByte = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				MemtoReg = 2'b00;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end
			
		// OPCODE = 67, jalr
			7'b1100111: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b0;
				JALR = 1'b1;
				if(FUNCT3 == 3'b000) begin
					ALUOp = 4'b0110;
				end
				else begin
					ALUOp = 4'b00; // ERROR
				end
				wordOrByte = 1'b0;
				MemRead = 1'b0; 
				MemWrite = 1'b0;
				MemtoReg = 2'b00;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end
			
		// OPCODE = 6F, jal
			7'b1101111: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b1;
				JALR = 1'b0;
				wordOrByte = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				ALUOp = 4'b0110;
				MemtoReg = 2'b10;
				ALUSrc = 1'b1;
				RegWrite = 1'b1;
			end
			
		// ERROR
			default: begin
				BEQ = 1'b0;
				BNE = 1'b0;
				JAL = 1'b0;
				JALR = 1'b0;
				wordOrByte = 1'b0;
				MemRead = 1'b0;
				MemWrite = 1'b0;
				ALUOp = 4'b0;
				MemtoReg = 2'b0;
				ALUSrc = 1'b0;
				RegWrite = 1'b0;
			end
		endcase
		if(MUXsel_Hazard) 
			begin
				{RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, ALUOp, BEQ, BNE, JAL, JALR} <= 0;
			end
	end
endmodule
