module DataPath(H, S, V, Valid_Out, In, Enable);
output [31:0] H, S, V;
output Valid_Out;
input [95:0] In;
input Enable;

wire [31:0] r_temp, g_temp, b_temp, Cmax, Cmin, delta;
wire [31:0] w_h, w_s;
wire Valid_In;

// Check valid input
check_Valid_In check_input(Valid_In, In);

// Calculate R', G', B'
FindRGB_temp cal_rgb(r_temp, g_temp, b_temp, In[95:64], In[63:32], In[31:0], Valid_In);
// Calculate Cmax(R', G', B'), Cmin(R', G', B')
FindMaxMin cal_max_min(Cmax, Cmin, r_temp, g_temp, b_temp);
// Calculate delta = Cmax - Cmin
Find_delta cal_delta(delta,Cmax, Cmin);
// Calculate H, S, V
Find_H cal_h(w_h, r_temp, g_temp, b_temp, Cmax, delta);
Find_S cal_s(w_s, Cmax, delta);

//assign V = Cmax; ###############

// Check valid output to write
check_Valid_Out check_output(Valid_Out, {H, S, Cmax});

assign H = (Enable) ? w_h : 32'bz;
assign S = (Enable) ? w_s : 32'bz;
assign V = (Enable) ? Cmax : 32'bz;
endmodule