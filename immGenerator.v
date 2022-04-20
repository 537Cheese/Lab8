module immGenerator(instruction, immOut);
   input [31:0] instruction;
   output[31:0] immOut;
   reg[31:0] IMM_OUT;
   wire[6:0] opcode;
   wire[2:0] funct3;

   assign immOut = IMM_OUT;
   assign opcode = instruction[6:0];
   assign funct3 = instruction[14:12];
   always @(instruction) #0.1
   casex(opcode)
        7'b0010011: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]};
        7'b0100011: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[11:8], instruction[7]};
        7'b0010111: IMM_OUT <= { instruction[31], instruction[30:20], instruction[19:12], {12{1'b0}} };
        7'b0000011: IMM_OUT <= { {21{instruction[31]}}, instruction[30:25], instruction[24:21], instruction[20]};
        7'b1101111: IMM_OUT <= { {12{instruction[31]}}, instruction[19:12], instruction[20], instruction[30:25], instruction[24:21], {1{1'b0}}};
        7'b1100011: IMM_OUT <= { {20{instruction[31]}}, instruction[7], instruction[30:25], instruction[11:8], {1{1'b0}}};
        default: IMM_OUT <= 32'bx;
    endcase
endmodule
