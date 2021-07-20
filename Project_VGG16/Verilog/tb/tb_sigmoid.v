`timescale 1ns/1ns
module tb_sigmoid ();
    parameter t = 10;
    reg clk;
	reg resetn;
	reg valid_in;
    reg [31:0] x;
    wire [31:0] f_x;
    wire valid_out;
    //wire [63:0] tp, fx;
    initial begin
        clk = 0;
        resetn = 1;
        valid_in = 0;
        #(2*t) resetn = 0;
        #(2*t) resetn = 1;
        #(3*t) valid_in = 1; x = 32'h3f800000; 
        #(2*t) x = 32'hc0000000;
        #(2*t) x = 32'h40000000;
        #(2*t) x = 32'h44fa0000;
        #(20*t) $stop;
    end

    always @(clk) begin
        #t clk <= ~clk;
    end

    sigmoid inst(
        clk,
        resetn,
        valid_in,
        x,
        f_x,
        valid_out
        );
endmodule