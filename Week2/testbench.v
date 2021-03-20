`timescale 1ns/1ps

module testbench();
	reg Reset_0, CLK;

	wire [8:0] H;
	wire [6:0] S, V;

	parameter t = 10;
	//wire [17:0]count;
	wire [23:0] rgb;
	wire valid;
	integer out; 
initial
begin
out = $fopen("output.txt", "w");
Reset_0 = 1'b0;
CLK = 1'b0;
#(t*2) Reset_0 = 1'b1;
#(t*320004) $stop;
end

always #t CLK = ~CLK;

always @(posedge CLK)
begin
	if (valid == 1'b1)
	$fwrite(out, "%d%d%d\n", H, S, V);
end

demo ins0(valid, rgb, H, S, V, Reset_0, CLK);
endmodule
