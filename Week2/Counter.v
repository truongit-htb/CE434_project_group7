module Counter(Out, Valid, Reset_0, CLK);
	parameter height = 400;
	parameter width = 400;
	
	output [17:0]Out;
	output Valid;
	reg [17:0]Out;
	input Reset_0, CLK;

	assign Valid = (Out < height*width) ? 1'b1 : 1'b0;

	always @(posedge CLK)
	begin
	if (Reset_0 == 1'b0)
		Out = 18'd0;
	else
		Out = Out + 18'd1;
	end
endmodule

	
