module demo(valid, rgb, 
		H, S, V, Reset_0, CLK);
	parameter height = 400;
	parameter width = 400;
	
 	output [8:0] H;
	output [6:0] S, V;
	input Reset_0, CLK;

	output valid;
	//output [17:0] count;
	wire [17:0] count;
	output [23:0] rgb;
	
Counter ins0(	.Out(count), 
		.Valid(valid), 
		.Reset_0(Reset_0), 
		.CLK(CLK));

IMEM ins1(	.Img(rgb), 
		.Addr(count));

rgb2hsv ins2(	.H(H), 
		.S(S), 
		.V(V), 
		.RGB(rgb), 
		.Valid(valid));
endmodule