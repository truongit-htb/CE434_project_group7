module tri_state(out, in, ctrl);
output reg [31:0] out;
input [31:0] in;
input ctrl;

always @(*) begin
	if(ctrl == 1) out = in;
	else out = 32'hzzzzzzzz;
end
endmodule
