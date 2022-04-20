module mux (data0, data1, sel, out);
  parameter WIDTH = 32;
  input [WIDTH-1:0] data0, data1;
  input sel;
  output [WIDTH-1:0] out;

  assign out = (sel == 1) ? data1 : data0;
endmodule
