module check_Valid_In(Valid_In, In);
output Valid_In;
input [95:0] In;

wire w_r, w_g, w_b;

assign w_r = (32'b0 <= In[95:64] && In[95:64] <= 32'h437F0000) ? 1'b1 : 1'b0;
assign w_g = (32'b0 <= In[63:32] && In[63:32] <= 32'h437F0000) ? 1'b1 : 1'b0;
assign w_b = (32'b0 <= In[31:0] && In[31:0] <= 32'h437F0000) ? 1'b1 : 1'b0;
assign Valid_In =  w_r & w_g & w_b;

endmodule

module check_Valid_Out(Valid_Out, In);
output Valid_Out;
input [95:0] In;

wire w_h, w_s, w_v;

assign w_h = (32'b0 <= In[95:64] && In[95:64] <= 32'h43B40000) ? 1'b1 : 1'b0; // 0 <= h <= 360
assign w_s = (32'b0 <= In[63:32] && In[63:32] <= 32'h42C80000) ? 1'b1 : 1'b0; // 0 <= s <= 100
assign w_v = (32'b0 <= In[31:0] && In[31:0] <= 32'h42C80000) ? 1'b1 : 1'b0;   // 0 <= v <= 100
assign Valid_Out =  w_h & w_s & w_v;

endmodule