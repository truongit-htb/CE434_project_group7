/*
module FindMaxMin(Cmax, Cmin, R_temp, G_temp, B_temp);
output reg [31:0] Cmax, Cmin;
input [31:0] R_temp, G_temp, B_temp;

always @(*) begin
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
end

endmodule
*/
module FindMaxMin(max, min, d1, d2, d3);
	output [32-1:0] max, min;
	input [32-1:0] d1, d2, d3;
	
	// tim max, min voi d1, d2, d3 deu la cac so duong
	assign max = (d1>d2) ? ((d1>d3) ? d1 : d3) : ((d2>d3) ? d2 : d3);
	assign min = (d1<d2) ? ((d1<d3) ? d1 : d3) : ((d2<d3) ? d2 : d3);
endmodule