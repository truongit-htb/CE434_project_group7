module register(out, in, clk, write_en);
output reg [31:0] out;
input [31:0] in;
input clk, write_en;

always @(posedge clk) begin
	if(write_en == 1'b1) 
		out = in;
	else 
		out = out;
end
endmodule
