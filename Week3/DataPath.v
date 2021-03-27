module DataPath(H, S, V, In, clk);
output [31:0] H, S, V;
input [95:0] In;

input clk; 
wire [31:0] r_temp, g_temp, b_temp, Cmax, Cmin,delta;
				

FindRGB_temp inst1(r_temp, g_temp, b_temp, In[95:64], In[63:32], In[31:0]);

FindMaxMin inst3(Cmax, Cmin, r_temp, g_temp, b_temp);

Find_delta inst6(delta,Cmax, Cmin);

Find_H inst8(H, r_temp, g_temp, b_temp, Cmax, delta);
Find_S inst9(S, Cmax, delta);

assign V = Cmax;
endmodule
