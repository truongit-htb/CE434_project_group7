module checkValid(Valid_In, In);
output Valid_In;
input [95:0] In;

assign Valid_In = ((32'b0 <= In[31:0] && In[31:0] <= 32'h437F0000) &&
		    (32'b0 <= In[63:32] && In[63:32] <= 32'h437F0000) &&
		    (32'b0 <= In[95:64] && In[95:64] <= 32'h437F0000)) ? 1'b1 : 1'b0;
endmodule