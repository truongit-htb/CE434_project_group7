`timescale 1ps/1ps
module tb_fc();
    parameter weight_file = "../Data/weight_file.txt";
    parameter Infile = "../Data/test_in_fc.txt";
    parameter Outfile = "../Data/out_fc.txt";
    parameter k = 20;
    reg clk;
	reg resetn;
	// input ack;
	reg load_weight;
	//input load_bias;
	reg valid_in;
	reg [31:0] data_in;
	reg [31:0] weight;
	// input [31:0] bias;
	wire [31:0] feature;
	wire valid_out;
	wire load_weight_done;
    //--------TEST--------//
    wire full, valid_out_mult;

    reg [32-1:0] In_Memory_0 [0:17-1];
    reg [32-1:0] In_Memory_1 [0:16-1];
    reg [32-1:0] Out_Memory [0:1];

    initial begin
        $readmemh(weight_file, In_Memory_0);
        $readmemh(Infile, In_Memory_1);
       // $readmemh(Image_Channel2, In_Memory_2);
    end

    initial begin
        clk = 1'b0;
        resetn = 1'b0;
        valid_in = 1'b0; 
        #(k*4/2) resetn = 1'b1;   
        load_weight = 1'b1;
    end

    integer i, j;
    initial begin
        #(k*4/2);
        for(i = 0; i < 17; i = i+1) begin
            weight = In_Memory_0[i];
            #(k*2);
        end
        load_weight = 1'b0;
        #(2*k);
        for(j=0; j<16; j = j +1) begin
            data_in = In_Memory_1[j];
            valid_in = 1'b1;
            #(2*k);
        end
        valid_in = 1'b0;
    end

    initial begin
        if(valid_out == 1) begin
            Out_Memory[0] = feature;
        end
        #(k*2) $fwritememh(Outfile, Out_Memory[0]);
        #(400*k) $finish;
    end
  
    
    
    
    always @(clk) #k clk <= ~clk;
    
    full_connected_16  # (
		.WIDTH(4), // after maxpool
		.HEIGHT(4) // after maxpool
	)
	inst(
	clk,
	resetn,
	// ack,
	load_weight,
	//load_bias,
	valid_in,
	data_in,
	weight,
	// bias,
	feature,
	valid_out,
    full, valid_out_mult,
	load_weight_done//,
	//load_bias_done
	);
    
endmodule
    