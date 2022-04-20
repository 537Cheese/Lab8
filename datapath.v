module datapath(clock, reset_, memtoreg, regwrite, aluControl, instr, readDataDMem, zero, pc, aluOut, readData2, selBranch, alusrcA, alusrcB, jump, LSb_aluresult);
   input clock, reset_, memtoreg, selBranch, alusrcA, alusrcB, regwrite, jump;
   input[3:0] aluControl;
   input[31:0] instr, readDataDMem;
   output zero, LSb_aluresult;
   output[31:0] pc, aluOut, readData2;
   wire[4:0] writereg;
   wire[31:0] pcnext, pcplus4, pcbranch, pcMux;
   wire[31:0] immOut, aluinA, aluinB, writeDataRegFile, readData1;
   assign writereg = instr[11:7];


   FFD_resettable #(32) pcreg(clock, reset_, pcnext, pc);
   adder                pcaddStart(pc, 32'b100, pcplus4);
   adder       pcaddBranch(pc, immOut, pcbranch);
   mux #(32)   pcBranchMux(pcplus4, pcbranch, selBranch, pcMux);
   mux #(32)   pcJumpMux(pcMux, aluOut, jump, pcnext);

   regfile     rf(clock, regwrite, instr[19:15], instr[24:20], instr[11:7], writeDataRegFile, readData1, readData2);
   mux #(32)   muxToWrite(aluOut, readDataDMem, memtoreg, writeDataRegFile);
   immGenerator immg(instr, immOut);


   mux #(32)  muxsrcB(readData2, immOut, alusrcB, aluinB);
   mux #(32)  muxsrcA(pc, readData1, alusrcA, aluinA);
   alu        alu(aluinA, aluinB, aluControl, aluOut, zero, LSb_aluresult);
endmodule
