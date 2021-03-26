module Control(Valid, S0, Cmax_En, Cmin_En, delta_En, tri_En, reg_En, Out_Flag, clk);
output reg Valid, S0, Cmax_En, Cmin_En, delta_En, Out_Flag;
output reg [2:0] tri_En, reg_En;
reg [2:0] Q, Qnext;
input clk;

always @(posedge clk) begin
	Q <= Qnext;
end

always @(*) begin
	Valid = 1'b0; S0 = 1'b0; Cmax_En = 1'b0; Cmin_En = 1'b0; delta_En = 1'b0; tri_En = 3'b0; Out_Flag = 1'b0; reg_En = 3'b000;
	case(Q)
	3'd0: begin
		Valid = 1'b1;
		Qnext = 3'd1;
	end
	3'd1: begin
		Valid = 1'b1;
		S0 = 1'b1;
		Qnext = 3'd2;
	end
	3'd2: begin
		Cmax_En = 1'b1;
		Cmin_En = 1'b1;
		Qnext = 3'd3;
	end
	3'd3: begin
		delta_En = 1'b1;
		Qnext = 3'd4;
		//reg_En = 3'b111;
	end
	3'd4: begin
		reg_En = 3'b111;
		tri_En = 3'b111;
		Qnext = 3'd0;
		Out_Flag = 1'b1;
	end
	default: begin
		Valid = 1'b0; S0 = 1'b0; Cmax_En = 1'b0; Cmin_En = 1'b0; delta_En = 1'b0; tri_En = 3'b0; Out_Flag = 1'b0; reg_En = 3'b000;
	end
	endcase
end
endmodule