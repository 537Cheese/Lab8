module adder(a, b,  out);
   input[31:0] a, b;
   output[31:0] out;
   assign out = OUT(a, b);

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
