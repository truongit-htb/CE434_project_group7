module Control(Out_Valid, In_Valid, rst_n, clk);
output reg Out_Valid;
reg Q, Qnext;
input rst_n, In_Valid, clk;

always @(posedge clk) begin
	if(rst_n == 0) Q <= 3'd0;
	else Q <= Qnext;
end

always @(*) begin
	Out_Valid = 1'b0; 
	case(Q)
	3'd0: begin
		if(In_Valid == 1'b1) Out_Valid = 1'b1;
		else Out_Valid = 1'b0;
		Qnext = 3'd0;
	end
	default: begin
		Out_Valid = 1'b0; 
	end
	endcase
end
endmodule