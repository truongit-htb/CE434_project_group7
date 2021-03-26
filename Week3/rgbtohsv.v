module rgbtohsv(H, S, V, Out_FLag, In, clk);
output [31:0] H, S, V;
output Out_FLag;
input clk;
input [95:0] In;
wire  Valid, S0, Cmax_En, Cmin_En, delta_En;
wire [2:0] tri_En, reg_En;

Control ins0(Valid, S0, Cmax_En, Cmin_En, delta_En, tri_En, reg_En, Out_FLag, clk);
DataPath ins1(H, S, V, In, Valid, clk, S0, Cmax_En, Cmin_En, delta_En, tri_En, reg_En);

endmodule
