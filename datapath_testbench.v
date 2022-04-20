module datapath_testbench;
   reg reset_; initial begin reset_=0; #22 reset_=1; #600; $stop; end
   reg clock;  initial clock<=0;   always #5 clock<=(!clock);
   reg memread, memtoreg, memwrite, selBranch, jump, alusrcA, alusrcB, regwrite;
   reg[3:0] alucontrol;
   reg [31:0] instr, readDataDMem;
   wire[11:0] control;
   assign control = {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch};
   wire zero, LSb_aluresult;
   wire[31:0] readData2, pc, aluout;
   wire[31:0] A, B, RESULT, NPC, PC4, PCD, PCQ, PCB, PC, PCJ,IMM_OUT;
   wire[4:0] A3;
   wire RESET;
   assign A = DP.aluinA, B = DP.aluinB, A3=DP.writereg, RESULT=DP.writeDataRegFile;
   assign  PC4=DP.pcplus4, PCD=DP.pcreg.d, PCQ=DP.pcreg.q, NPC=DP.pcnext, PCB=DP.pcbranch, PCJ=DP.pcMux, PC=DP.pc, RESET=DP.reset_, IMM_OUT = DP.immg.immOut;
   initial begin
      wait(reset_==1);
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b111000000100; instr<=32'h00500113; 
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b111000000100; instr<=32'h00C00193;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b111000000100; instr<=32'hFF718393;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b111000000100; instr<=32'h00300213;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b010000010101; instr<=32'h00720463;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b010000010111; instr<=32'h00314263;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b110000010110; instr<=32'h00312433;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b110000000100; instr<=32'h007202B3;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b001100000100; instr<=32'hFFDFF06F;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b001100000100; instr<=32'h0040006F;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b110000010100; instr<=32'h40428333;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b111001100100; instr<=32'h00402483; readDataDMem <= 10;
      @(posedge clock); #1 {regwrite, alusrcA, alusrcB, jump, memwrite, memread, memtoreg, alucontrol, selBranch} <= 12'b011010000100; instr<=32'h00202223;
      #5
      $display("DATAPATH TESTBENCH");
      $display("REG\t\tRESULT\tEXPECTED");
      $display("R2\t\t%h\t5", DP.rf.regFile[2]);
      $display("R3\t\t%h\tC", DP.rf.regFile[3]);
      $display("R7\t\t%h\t3", DP.rf.regFile[7]);
      $display("ReadData2\t%h\t5\n", DP.rf.readData2);
      $finish;
      #10
      $finish;
   end
   datapath DP(clock, reset_, memtoreg, regwrite, alucontrol, instr, readDataDMem, zero, pc, aluout, readData2, selBranch, alusrcA, alusrcB, jump, LSb_aluresult);
endmodule
	
