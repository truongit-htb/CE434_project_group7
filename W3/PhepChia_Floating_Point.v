module PhepChia_Floating_Point(Out, InA, InB);
	output [31:0] Out;
	input [31:0] InA, InB;	
	reg [31:0] Out;
	reg PhanDau;
	reg [7:0] PhanMu_A, PhanMu_B, PhanMu, PhanMu_Temp;
	reg [47:0] PhanDinhTri, PhanDinhTri_B, PhanDinhTri_A;
	reg [22:0] PhanDinhTri_Temp;
	
	always @(*)
	begin
	PhanDau = 1'b0;
	PhanMu_A = 8'b0; PhanMu_B = 8'b0; PhanMu = 8'b0; PhanMu_Temp = 8'b0;
	PhanDinhTri = 48'b0; PhanDinhTri_B = 48'b0; PhanDinhTri_A = 48'b0;
	PhanDinhTri_Temp = 23'b0;
	
	if (InA == 32'b0 && InB == 32'b0)
		Out = 32'bz;
	else 
		if (InA == 32'b0)
			Out = 32'b0;
		else 
			if (InB == 32'b0)
				Out = 32'bz;
			else
				begin
					PhanDau = InA[31] ^ InB[31];
					PhanMu_A = InA[30:23];
					PhanMu_B = InB[30:23];
					PhanDinhTri_A = {1'b1, InA[22:0], 24'b0};
					PhanDinhTri_B = {24'b0,1'b1, InB[22:0]};
					PhanMu = (PhanMu_A - PhanMu_B) + 8'd127;
					PhanDinhTri = PhanDinhTri_A / PhanDinhTri_B;
					// ---------
					begin
						if (InA[22:0] < InB[22:0])
						begin
							PhanDinhTri_Temp = {PhanDinhTri[22:0]};
							PhanMu_Temp = PhanMu - 8'b1;
						end
						else
						begin
							PhanDinhTri_Temp = {PhanDinhTri[23:1]};
							PhanMu_Temp = PhanMu;
						end
					end
					
					Out = {PhanDau, PhanMu_Temp, PhanDinhTri_Temp};
				end
	end
endmodule
