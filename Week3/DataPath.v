module DataPath(H, S, V, In, Valid, clk, s0, Cmax_En, Cmin_En, delta_En, tri_En, reg_En);
output [31:0] H, S, V;
input [95:0] In;
input [2:0] tri_En, reg_En;
input Valid, clk, s0, Cmax_En, Cmin_En, delta_En;
wire [31:0] r, g, b, w1, w2, w3, r_temp, g_temp, b_temp, Cmax, Cmin, out_max, out_min, delta,
				out_H, out_S, out_delta, reg_H, reg_S, reg_V;
_reg inst [2:0] ({r, g, b}, {w1, w2, w3}, clk, Valid);
FindRGB_temp inst1(r_temp, g_temp, b_temp, r, g, b);
mux2to1 ins [2:0] ({w1, w2, w3}, In, {r_temp, g_temp, b_temp}, s0);
FindMaxMin inst3(Cmax, Cmin, r, g, b);
_reg inst4(out_max, Cmax, clk, Cmax_En);
_reg inst5(out_min, Cmin, clk, Cmin_En);
Find_delta inst6(delta, out_max, out_min);
_reg inst7(out_delta, delta, clk, delta_En);
Find_H inst8(out_H, r, g, b, out_max, out_delta);
Find_S inst9(out_S, out_max, out_delta);
_reg insta [2:0] ({reg_H, reg_S, reg_V}, {out_H, out_S, out_max}, reg_En);
tri_state insts [2:0]({H, S, V}, {reg_H, reg_S, reg_V}, tri_En);
endmodule