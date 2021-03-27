module Find_H(H, R_temp, G_temp, B_temp, Cmax, delta);
output reg [31:0] H;
input [31:0] R_temp, G_temp, B_temp, Cmax, delta;
wire	[31:0] a, b, c, d, h1, h2, h3, w1, w2, w3;

CongFP inst0(a, G_temp, {1'b1, {B_temp[30:0]}});
CongFP inst1(b, B_temp, {1'b1, {R_temp[30:0]}});
CongFP inst2(c, R_temp, {1'b1, {G_temp[30:0]}});
PhepChia_Floating_Point inst3(d, 32'h42700000, delta);
PhepNhan_Floating_Point ins [2:0] ({h1, h2, h3}, d, {a, b, c});
CongFP inst4(w1, h1, 32'h43B40000);
CongFP inst5(w2, h2, 32'h42F00000);
CongFP inst6(w3, h3, 32'h43700000);

always @(*) begin
	if(delta == 0) H = 32'd0;
	else begin
		case(Cmax) 
		R_temp: begin
			case(a[31])
			1'b0: H = h1;
			1'b1: H = w1;
			endcase
		end
		G_temp: H = w2;
		B_temp: H = w3;
		default: H = 32'hx;
		endcase
	end
end

endmodule