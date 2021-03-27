module Find_S (S, Cmax, delta);
output reg [31:0] S;
input [31:0] Cmax, delta;
wire [31:0] a, b;

PhepChia_Floating_Point inst0(a, delta, Cmax);
PhepNhan_Floating_Point inst1(b, a, 32'h42C80000);

always @(*) begin
	if(Cmax == 32'd0) S = 32'd0;
	else S = b;
end

endmodule
