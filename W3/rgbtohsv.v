module rgbtohsv(H, S, V, In, clk);
output [31:0] H, S, V;
input clk;
input [95:0] In;
wire  Valid, S0, Cmax_En, Cmin_En, delta_En;
wire [2:0] tri_En;

Control ins0(Valid, S0, Cmax_En, Cmin_En, delta_En, tri_En, clk);
DataPath ins1(H, S, V, In, Valid, clk, S0, Cmax_En, Cmin_En, delta_En, tri_En);

endmodule
