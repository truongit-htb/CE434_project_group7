module Control(write_en, sel_out, Valid_Out, rst_n, clk);
output reg write_en, sel_out;
input Valid_Out, rst_n, clk;

reg [1:0] Q, Qnext;

always @(posedge clk or negedge rst_n) begin
	if(rst_n == 1'b0) 
		Q <= 2'd0;
	else 
		Q <= Qnext;
end

always @(*) begin
	write_en = 1'b0;
	sel_out = 1'b0;
	case(Q)
	2'd0: begin
	if(rst_n == 1'b0)
		Qnext = 2'd0;
	else
		Qnext = 2'd1;
	end

	2'd1: begin
	write_en = 1'b1;
/*
	if (Valid_In = 1'b1)
		Enable = 1'b1;
	else 
		Enable = 1'b0;
*/
	Qnext = 2'd2;
	end

	2'd2: begin
	write_en = 1'b1;
	if (Valid_Out)
		sel_out = 1'b1;
	else
		sel_out = 1'b0;
	Qnext = 2'd2;
	end

	default: begin
	write_en = 1'b0;
	sel_out = 1'b0;
	Qnext = 2'd0;
	end
	endcase
end
endmodule