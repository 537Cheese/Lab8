module alu(a, b, aluctrl,  aluOut, zero, LSb_aluresult);
   input  [31:0] a, b;
   input  [3:0] aluctrl;
   output[31:0] aluOut;
   output zero, LSb_aluresult;
   reg[31:0] aluOut;
   assign zero = (aluOut==0) ? 1 : 0;
   assign LSb_aluresult = aluOut[0];
   always @(aluctrl or a or b)
      casex (aluctrl)
         0: aluOut <= a & b;
         1: aluOut <= a | b;
         2: aluOut <= OUT(a, b);
         4: aluOut <= a * b;
         5: aluOut <= a / b;
         10: aluOut <= a - b;
         11: aluOut <= (a < b) ? 1:0;
         default: aluOut<=0;
      endcase

      /* Function to signed operation*/
      function [31:0] OUT;
          input [31:0] a, b;
          begin
          casex(b[31])
              1'b1:   begin
                      b = ~b;
                      b = b + 1'b1;
                      OUT = a - b;
                      end
              default: OUT = a + b;
          endcase
          end
      endfunction
endmodule
