module rgbtohsv(H, S, V, Out_Valid, In_Valid, In, rst_n, clk);
output [31:0] H, S, V;
output Out_Valid;
//output Out_FLag;
input clk, rst_n, In_Valid;
input [95:0] In;
wire  Valid; //S0, Cmax_En, Cmin_En, delta_En;
//wire [2:0] tri_En;

Control ins0(Out_Valid, In_Valid, rst_n, clk);
DataPath ins1(H, S, V, In, clk);

endmodule
