module Find_delta(delta, Cmax, Cmin);
output [31:0] delta;
input [31:0] Cmax, Cmin;

CongFP inst0(delta, Cmax, {1'b1, {Cmin[30:0]}});

endmodule