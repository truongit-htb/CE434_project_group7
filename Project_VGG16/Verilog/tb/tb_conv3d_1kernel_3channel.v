`timescale 1ns/1ps

module tb_conv3d_1kernel_1channel;
    // // path on Window
    // parameter Infile    = "E:/LAB/LAB_20_21_HK_II/CE434-ChuyenDeTKVM/git_vgg16/VGG16/CodePythonCNN/data_image_fp.txt";
    // parameter Outfile   = "E:/LAB/LAB_20_21_HK_II/CE434-ChuyenDeTKVM/git_vgg16/VGG16/CodePythonCNN/modelsim_out_conv2d_1kernel_1channel-02.txt";
    
    // // path on Ubuntu
    parameter Image_Channel0 = "/home/truong/Desktop/git_vgg16/Data/data_fp_image_channel_000.txt";
    parameter Image_Channel1 = "/home/truong/Desktop/git_vgg16/Data/data_fp_image_channel_001.txt";
    parameter Image_Channel2 = "/home/truong/Desktop/git_vgg16/Data/data_fp_image_channel_002.txt";
    // parameter Outfile   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_000.txt";

    parameter Outfile_0   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_000.txt";
    parameter Outfile_1   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_001.txt";
    parameter Outfile_2   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_002.txt";
    parameter Outfile_3   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_003.txt";
    parameter Outfile_4   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_004.txt";
    parameter Outfile_5   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_005.txt";
    parameter Outfile_6   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_006.txt";
    parameter Outfile_7   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_007.txt";

    parameter k = 20;

    // LAM ON NHO DAT DUNG KICH THUOC ANH KHONG THI DUNG HOI HAN!
    parameter DATA_WIDTH = 32;
    parameter WIDTH = 20;
    parameter HEIGHT = 20;
    parameter Total_Pixel = WIDTH * HEIGHT;


    reg clk;
    reg resetn;
    reg valid_in;
    reg [31:0] data_in0;
    reg [31:0] data_in1;
    reg [31:0] data_in2;
    // wire [31:0] data_out;
    wire valid_out, done;

    wire   [DATA_WIDTH-1:0]    data_out0;
    wire   [DATA_WIDTH-1:0]    data_out1;
    wire   [DATA_WIDTH-1:0]    data_out2;
    wire   [DATA_WIDTH-1:0]    data_out3;
    wire   [DATA_WIDTH-1:0]    data_out4;
    wire   [DATA_WIDTH-1:0]    data_out5;
    wire   [DATA_WIDTH-1:0]    data_out6;
    wire   [DATA_WIDTH-1:0]    data_out7;

    reg [32-1:0] In_Memory_0 [0:Total_Pixel-1];
    reg [32-1:0] In_Memory_1 [0:Total_Pixel-1];
    reg [32-1:0] In_Memory_2 [0:Total_Pixel-1];

    initial 
    begin
        $readmemh(Image_Channel0, In_Memory_0);
        $readmemh(Image_Channel1, In_Memory_1);
        $readmemh(Image_Channel2, In_Memory_2);
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

            
            data_in0 = In_Memory_0[i];
            data_in1 = In_Memory_1[i];
            data_in2 = In_Memory_2[i];
            // in2 = In_Memory[i + 1];
            #(k*2);            
        end
        data_in0 = 32'bx;
        data_in1 = 32'bx;
        data_in2 = 32'bx;
        // -------  Can duy tri VALID_IN them WIDTH+1 clock de co the tinh het so pixel o hang cuoi cung trong anh ---------
        #(k*2*(WIDTH + 1));
        
        valid_in = 1'b0;
        // #(k*4) $stop;
    end

    // reg [32-1:0] Out_Memory [0:Total_Pixel-1];
    
    reg [32-1:0] Out_Memory_0 [0:Total_Pixel-1];
    reg [32-1:0] Out_Memory_1 [0:Total_Pixel-1];
    reg [32-1:0] Out_Memory_2 [0:Total_Pixel-1];
    reg [32-1:0] Out_Memory_3 [0:Total_Pixel-1];
    reg [32-1:0] Out_Memory_4 [0:Total_Pixel-1];
    reg [32-1:0] Out_Memory_5 [0:Total_Pixel-1];
    reg [32-1:0] Out_Memory_6 [0:Total_Pixel-1];
    reg [32-1:0] Out_Memory_7 [0:Total_Pixel-1];
    integer j;
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
                // Out_Memory[j] = data_out;
                begin
                Out_Memory_0[j] = data_out0;
                Out_Memory_1[j] = data_out1;
                Out_Memory_2[j] = data_out2;
                Out_Memory_3[j] = data_out3;
                Out_Memory_4[j] = data_out4;
                Out_Memory_5[j] = data_out5;
                Out_Memory_6[j] = data_out6;
                Out_Memory_7[j] = data_out7;
                end
            else
                // Out_Memory[j] = 32'hx;
                begin
                Out_Memory_0[j] = 32'hx;
                Out_Memory_1[j] = 32'hx;
                Out_Memory_2[j] = 32'hx;
                Out_Memory_3[j] = 32'hx;
                Out_Memory_4[j] = 32'hx;
                Out_Memory_5[j] = 32'hx;
                Out_Memory_6[j] = 32'hx;
                Out_Memory_7[j] = 32'hx;
                end
            #(k*2);
        end

        #(k*2);
        // $writememh(Outfile, Out_Memory);

        $writememh(Outfile_0, Out_Memory_0);
        $writememh(Outfile_1, Out_Memory_1);
        $writememh(Outfile_2, Out_Memory_2);
        $writememh(Outfile_3, Out_Memory_3);
        $writememh(Outfile_4, Out_Memory_4);
        $writememh(Outfile_5, Out_Memory_5);
        $writememh(Outfile_6, Out_Memory_6);
        $writememh(Outfile_7, Out_Memory_7);

        #k $stop;
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

    // // testbench cho mach conv2d_1kernel_3channel
    // conv3d_kernel_3_channel_size_3 #(
	// 	.DATA_WIDTH(32),.IMG_WIDTH(WIDTH),.IMG_HEIGHT(HEIGHT)
	// 	)
	// 	block1_conv1_1kernel_3channel(
	// 	clk,
	// 	resetn,
	// 	valid_in,
	// 	data_in0,             
	// 	data_in1,             
	// 	data_in2,             
	// 	// load_kernel0,
	// 	// kernel,            
	// 	data_out,
	// 	valid_out,
	// 	done
	// 	// load_kernel_done_0
	// 	);

    // testbench cho mach conv2d_8kernel_3channel
    block1_conv1_8_kernel_3_channel #(
		.DATA_WIDTH(32),.IMG_WIDTH(WIDTH),.IMG_HEIGHT(HEIGHT)
		)
		block1_conv1_8kernel_3channel(
		clk,
		resetn,
		valid_in,
		data_in0,             
		data_in1,             
		data_in2,             
		// load_kernel0,
		// kernel,            
		// data_out,
        data_out0,
        data_out1,
        data_out2,
        data_out3,
        data_out4,
        data_out5,
        data_out6,
        data_out7,
		valid_out,
		done
		// load_kernel_done_0
		);

endmodule