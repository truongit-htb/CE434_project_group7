`timescale 1ns/1ps

module tb_conv2d_1kernel_1channel;
    // // path on Window
    // parameter Infile    = "E:/LAB/LAB_20_21_HK_II/CE434-ChuyenDeTKVM/git_vgg16/VGG16/CodePythonCNN/data_image_fp.txt";
    // parameter Outfile   = "E:/LAB/LAB_20_21_HK_II/CE434-ChuyenDeTKVM/git_vgg16/VGG16/CodePythonCNN/modelsim_out_conv2d_1kernel_1channel-02.txt";
    // // path on Ubuntu
    parameter Infile    = "/home/truong/Desktop/git_vgg16/Data/data_fp_image_111.txt";
    parameter Outfile   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv2d_1kernel_1channel_1XX.txt";

    parameter k = 20;

    parameter DATA_WIDTH = 32;
    parameter WIDTH = 56;
    parameter HEIGHT = 56;
    parameter Total_Pixel = WIDTH * HEIGHT;


    reg clk;
    reg resetn;
    reg valid_in;
    reg [31:0] data_in;
    wire [31:0] data_out;
    wire valid_out, done;

    reg [32-1:0] In_Memory [0:Total_Pixel-1];

    initial 
    begin
        $readmemh(Infile, In_Memory);
    end

    initial 
    begin
        clk = 1'b0;
        resetn = 1'b0;
        valid_in = 1'b1;    
        #(k*3/2) resetn = 1'b1;
    end

    integer i;
    initial 
    begin 
        //#(k*2) data_in = In_Memory[i];
        #(k*3/2);
        for (i = 0; i < Total_Pixel; i = i + 1) 
        begin
            
            // if (i == 4)
            // valid_in = 1'b0; 
            // if (i == 6)
            // valid_in = 1'b1; 

            // if (i == 10)
            // valid_in = 1'b0; 
            // if (i == 14)
            // valid_in = 1'b1; 

            
            data_in = In_Memory[i];
            // in2 = In_Memory[i + 1];
            #(k*2);            
        end
        data_in = 32'bx;
        // -------  Can duy tri VALID_IN them WIDTH+1 clock de co the tinh het so pixel o hang cuoi cung trong anh ---------
        #(k*2*(WIDTH + 1));
        
        valid_in = 1'b0;
        // #(k*4) $stop;
    end

    integer j;
    reg [32-1:0] Out_Memory [0:Total_Pixel-1];
    initial 
    begin
        j = 0;
        #(k*3/2);

        while (valid_out == 1'b0)
        begin
             #(k*2);
        end

        for (j = 0; j < Total_Pixel; j = j + 1)
        begin
            if (valid_out == 1'b1)
                Out_Memory[j] = data_out;
            else
                Out_Memory[j] = 32'hx;
            #(k*2);
        end

        #(k*2) $writememh(Outfile, Out_Memory);
        #k $finish;
    end
    
    always #k clk = ~clk;

    // testbench cho mach Nhan fp
    // FP_multiplier ins_mult(
	// 		clk,
	// 		resetn,
	// 		valid_in,
	// 		in1,
	// 		in2,
	// 		product,
	// 		valid_out
    // );

    // testbench cho mach conv2d_1kernel_1channel
    conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(WIDTH),.IMG_HEIGHT(HEIGHT),
        .kernelR0( 32'h3f800000 ),
        .kernelR1( 32'h3f8ccccd ),
        .kernelR2( 32'h3f800000 ),
        .kernelR3( 32'h00000000 ),
        .kernelR4( 32'h00000000 ),
        .kernelR5( 32'h00000000 ),
        .kernelR6( 32'hbf800000 ),
        .kernelR7( 32'hbf8ccccd ),
        .kernelR8( 32'hbf800000 )
		)
		conv1_0(
		clk,
		resetn,
		valid_in,
		data_in,             
		// load_kernel0,
		// kernel,            
		data_out,
		valid_out,
		done
		// load_kernel_done_0
		);

endmodule