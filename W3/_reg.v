module _reg(out, in, clk, en);
output reg [31:0] out;
input [31:0] in;
input clk, en;

always @(negedge clk) begin
	if(en == 0) out = out;
	else out = in;
end
endmodule
