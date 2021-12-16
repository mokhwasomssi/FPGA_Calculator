module add6(a, b, s, co);

input [5:0] a, b;
output [5:0] s;
output co;
wire [6:0] t;

assign t = a + b;
assign s = t[5:0];
assign co = t[6];

endmodule