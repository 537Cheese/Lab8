module FFD_resettable(clock, reset_, d, q);
   parameter WIDTH = 32;
   input  [WIDTH-1:0] d;
   input clock, reset_;
   output [WIDTH-1:0] q;
   reg [WIDTH-1:0] q;
   always @(posedge clock)
      #1.2 if (!reset_) q <= 0;
      else q <= d;
endmodule
