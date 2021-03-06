module FindRGB_temp(R_temp, G_temp, B_temp, R, G, B, Enable);
output [31:0] R_temp, G_temp, B_temp;
input  [31:0] R, G, B;
input  Enable;

wire   [31:0] w_r, w_g, w_b;

PhepNhan_Floating_Point inst0(w_r, R, 32'h3ec8c8c9);
PhepNhan_Floating_Point inst1(w_g, G, 32'h3ec8c8c9);
PhepNhan_Floating_Point inst2(w_b, B, 32'h3ec8c8c9);

assign R_temp = (Enable) ? w_r : 32'bx;
assign G_temp = (Enable) ? w_g : 32'bx;
assign B_temp = (Enable) ? w_b : 32'bx;

endmodule