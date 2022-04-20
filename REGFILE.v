module regfile(clock, regWrite, readReg1, readReg2, regDest, writeData, readData1, readData2);
   input clock, regWrite;
   input[4:0] readReg1, readReg2, regDest;
   input[31:0] writeData;
   output[31:0] readData1, readData2;
   reg[31:0] readData1, readData2;
   reg[31:0] regFile[0:31];

   always @(negedge clock) if (regWrite == 1) regFile[regDest] <= writeData;
   always @(readReg1) readData1 <= (readReg1 != 0) ? regFile[readReg1] : 0;
   always @(readReg2) readData2 <= (readReg2 != 0) ? regFile[readReg2] : 0;
endmodule
