`timescale 1ns/1ns
module tb_softmax ();
    parameter t = 10;
    reg clk;
	reg resetn;
	reg valid_in;
    reg [31:0] class0,class1;
    wire [31:0] percent0,percent1;
    wire  valid_out;
    
    initial begin
        clk = 0;
        resetn = 1;
        valid_in = 0;
        #(2*t) resetn = 0;
        #(2*t) resetn = 1;
        #(3*t) valid_in = 1; class0 = 32'h40000000; class1 = 32'h3f800000;
        #(2*t) class0 = 32'h3f7bb2ff; class1 = 32'h3a9d4952;
        #(20*t) $stop;
    end

    always @(clk) begin
        #t clk <= ~clk;
    end

    softmax inst(
        clk,
        resetn,
        valid_in,
        class0,class1,
        percent0,percent1,
        valid_out
    );
endmodule