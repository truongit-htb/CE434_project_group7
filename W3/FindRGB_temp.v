module FindRGB_temp(R_temp, G_temp, B_temp, R, G, B);
output [31:0] R_temp, G_temp, B_temp;
input	[31:0] R, G, B;

PhepNhan_Floating_Point inst0(R_temp, R, 32'h3ec8c8c9);
PhepNhan_Floating_Point inst1(G_temp, G, 32'h3ec8c8c9);
PhepNhan_Floating_Point inst2(B_temp, B, 32'h3ec8c8c9);

endmodule