module rgb2hsv(H, S, V, RGB, Valid);
	output [8:0] H;
	output [6:0] S, V;
	input [23:0] RGB;
	input Valid;

	reg [15:0] R_temp, G_temp, B_temp, Cmax, Cmin, Delta;
	reg [15:0] H_temp, S_temp;
	
	always @(*)
	begin
	if (Valid == 1'b1)
	begin
	R_temp = {8'b0,{RGB[23:16]}} * 16'd100 / 16'd255;
	G_temp = {8'b0,{RGB[15:8]}} * 16'd100 / 16'd255;
	B_temp = {8'b0,{RGB[7:0]}} * 16'd100 / 16'd255; 
	/*
	if (R_temp > G_temp)
		if (R_temp > B_temp)
		begin
			Cmax = R_temp;
			if (G_temp > B_temp)
				Cmin = B_temp;
			else
				Cmin = G_temp;
		end
		else
		begin
			Cmax = B_temp;
			if (R_temp > G_temp)
				Cmin = G_temp;
			else
				Cmin = R_temp;
		end
	else
		if (G_temp > B_temp)
		begin
			Cmax = G_temp;
			if (R_temp > B_temp)
				Cmin = B_temp;
			else
				Cmin = R_temp;
		end
		else
		begin
			Cmax = B_temp;
			if (R_temp > G_temp)
				Cmin = G_temp;
			else
				Cmin = R_temp;
		end
	
	*/
	Cmax = R_temp;
	Cmin = R_temp;
	// tim max
	if (G_temp > Cmax)
		Cmax = G_temp;
	if (B_temp > Cmax)
		Cmax = B_temp;
	// tim min
	if (G_temp < Cmin)
		Cmin = G_temp;
	if (B_temp < Cmin)
		Cmin = B_temp;
	

	Delta = Cmax - Cmin;

	// H calculating
	if (Delta == 16'b0)
		H_temp = 16'b0;
	else
	if (Cmax == R_temp)
		H_temp = (G_temp - B_temp) * 16'd60 / Delta + ((G_temp < B_temp) ? 16'd360 : 16'd0);
	else
	if (Cmax == G_temp)
		H_temp = 16'd60 * (((B_temp - R_temp) / Delta) + 16'd2);
	else
	if (Cmax == B_temp)
		H_temp = 16'd60 * (((R_temp - G_temp) / Delta) + 16'd4);
	else
		H_temp = 16'bz; //default
	
	// S calculating
	if (Cmax == 16'd0)
		S_temp = 16'd0;
	else
		S_temp = Delta * 16'd100 / Cmax;

	// V calculating
	// V_temp = Cmax;
	end

	else
	begin
		H_temp[8:0] = 9'bz;
		S_temp[6:0] = 7'bz;
		//V_temp[6:0] = 7'b0;
	end
	end

	// Output
	assign H = H_temp[8:0];
	assign S = S_temp[6:0];
	assign V = Cmax[6:0];
	 
endmodule
	