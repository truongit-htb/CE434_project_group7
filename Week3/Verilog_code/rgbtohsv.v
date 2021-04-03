module RGBtoHSV(H, S, V, Valid_Out, In, rst_n, clk);
output [31:0] H, S, V;
output Valid_Out;
input clk, rst_n;
input [95:0] In;

wire  write_en, sel_out; 


/*
Control ins0(Out_Valid, In_Valid, rst_n, clk);
DataPath ins1(H, S, V, In, clk);
*/

Control control(write_en, sel_out, Valid_Out, rst_n, clk);
DataPath datapath(H, S, V, /*Valid_In,*/ Valid_Out, In, clk, write_en, sel_out);
endmodule
