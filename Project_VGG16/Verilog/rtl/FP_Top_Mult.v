`include "FP_nhan.v"
// `include "delay_clock.v"

module FP_Top_Mult (
    input  clk, resetn, valid_in,
    input  [31:0] a, b,
    output [31:0] out,
    output valid_out    
);
    reg [31:0] in1, in2;

    always @(posedge clk or negedge resetn) 
    begin
        if (resetn == 1'b0)
        begin
            in1 <= 32'b0;
            in2 <= 32'b0;
        end 
		else 
            if(valid_in == 1'b1)
            begin
                in1 <= a;
                in2 <= b;
            end 
            else 
            // if (valid_in == 1'b0) 
            begin
                in1 <= in1;
                in2 <= in2;
            end
    end

    FP_nhan nhan_fp (out, in1, in2);

    delay_clock #(.DATA_WIDTH(1),.N_CLOCKs(1)) valid_inst(clk, resetn, 1'b1, valid_in, valid_out);

endmodule