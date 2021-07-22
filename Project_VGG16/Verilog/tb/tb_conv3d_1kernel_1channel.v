`timescale 1ns/1ns

`include "../Verilog/rtl/dimension.v"

module tb_conv3d_1kernel_1channel;
    // // path on Ubuntu
    // parameter Image_Channel0 = "../Data/3_data_in/data_fp_sun_01_channel_000.txt";
    // parameter Image_Channel1 = "../Data/3_data_in/data_fp_sun_01_channel_001.txt";
    // parameter Image_Channel2 = "../Data/3_data_in/data_fp_sun_01_channel_002.txt";
    // // EXTEND
    parameter Image_Channel0 = "../Data/4_data_out/modelsim_block1_conv1_sun_000.txt";
    parameter Image_Channel1 = "../Data/4_data_out/modelsim_block1_conv1_sun_001.txt";
    parameter Image_Channel2 = "../Data/4_data_out/modelsim_block1_conv1_sun_002.txt";
    parameter Image_Channel3 = "../Data/4_data_out/modelsim_block1_conv1_sun_003.txt";
    parameter Image_Channel4 = "../Data/4_data_out/modelsim_block1_conv1_sun_004.txt";
    parameter Image_Channel5 = "../Data/4_data_out/modelsim_block1_conv1_sun_005.txt";
    parameter Image_Channel6 = "../Data/4_data_out/modelsim_block1_conv1_sun_006.txt";
    parameter Image_Channel7 = "../Data/4_data_out/modelsim_block1_conv1_sun_007.txt";
    

    parameter Outfile_0   = "../Data/4_data_out/modelsim_block1_conv2_sun_01_000.txt";
    parameter Outfile_1   = "../Data/4_data_out/modelsim_block1_conv2_sun_01_001.txt";
    parameter Outfile_2   = "../Data/4_data_out/modelsim_block1_conv2_sun_01_002.txt";
    parameter Outfile_3   = "../Data/4_data_out/modelsim_block1_conv2_sun_01_003.txt";
    parameter Outfile_4   = "../Data/4_data_out/modelsim_block1_conv2_sun_01_004.txt";
    parameter Outfile_5   = "../Data/4_data_out/modelsim_block1_conv2_sun_01_005.txt";
    parameter Outfile_6   = "../Data/4_data_out/modelsim_block1_conv2_sun_01_006.txt";
    parameter Outfile_7   = "../Data/4_data_out/modelsim_block1_conv2_sun_01_007.txt";

    parameter k = 5;

    parameter DATA_WIDTH = 32;


    reg clk;
    reg resetn;
    wire valid_in;
    wire [31:0] data_in_0;
    wire [31:0] data_in_1;
    wire [31:0] data_in_2;
    // // EXTEND
    wire [31:0] data_in_3;
    wire [31:0] data_in_4;
    wire [31:0] data_in_5;
    wire [31:0] data_in_6;
    wire [31:0] data_in_7;
    wire [31:0] data_out;
    wire valid_out, done;

    wire   [DATA_WIDTH-1:0]    data_out_0;
    wire   [DATA_WIDTH-1:0]    data_out_1;
    wire   [DATA_WIDTH-1:0]    data_out_2;
    wire   [DATA_WIDTH-1:0]    data_out_3;
    wire   [DATA_WIDTH-1:0]    data_out_4;
    wire   [DATA_WIDTH-1:0]    data_out_5;
    wire   [DATA_WIDTH-1:0]    data_out_6;
    wire   [DATA_WIDTH-1:0]    data_out_7;


    initial 
    begin
        clk = 1'b0;
        resetn = 1'b0;
        // valid_in = 1'b1;    
        #(k*3/2) resetn = 1'b1;
    end

    always #k clk = ~clk;

    tb_generator_3d #(
        .DWIDTH(32),
        // .input_file(Infile), //-----------
        .input_file_0(Image_Channel0),
        .input_file_1(Image_Channel1),
        .input_file_2(Image_Channel2),
        // // EXTEND
        .input_file_3(Image_Channel3),
        .input_file_4(Image_Channel4),
        .input_file_5(Image_Channel5),
        .input_file_6(Image_Channel6),
        .input_file_7(Image_Channel7),

        .WIDTH(`IMG_WIDTH),
        .HEIGHT(`IMG_HEIGHT)
    ) generator (
        .clk(clk),
        .resetn(resetn),
        // .fifo_data(data_in),
        .fifo_data_0(data_in_0),
        .fifo_data_1(data_in_1),
        .fifo_data_2(data_in_2),
        // // EXTEND
        .fifo_data_3(data_in_3),
        .fifo_data_4(data_in_4),
        .fifo_data_5(data_in_5),
        .fifo_data_6(data_in_6),
        .fifo_data_7(data_in_7),

        .fifo_wrreq(valid_in)
    );

    // block1_conv1_8_kernel_3_channel #(
	// 	.DATA_WIDTH(32),.IMG_WIDTH(`IMG_WIDTH),.IMG_HEIGHT(`IMG_HEIGHT)
    // )
    // block1_conv1_8kernel_3channel(
	// 	.clk(clk),
	// 	.resetn(resetn),
	// 	.data_valid_in(valid_in),
	// 	.data_in0(data_in_0),             
	// 	.data_in1(data_in_1),             
	// 	.data_in2(data_in_2), 

    //     .data_out_conv0(data_out_0),
    //     .data_out_conv1(data_out_1),
    //     .data_out_conv2(data_out_2),
    //     .data_out_conv3(data_out_3),
    //     .data_out_conv4(data_out_4),
    //     .data_out_conv5(data_out_5),
    //     .data_out_conv6(data_out_6),
    //     .data_out_conv7(data_out_7),

	// 	.valid_out_pixel(valid_out),
	// 	.done_img()
	// 	);


    // testbench cho mach conv2d_8kernel_3channel
    // block1_conv1 #(
    block1_conv2 #(
		.DATA_WIDTH(32),
        .WIDTH(`IMG_WIDTH),
        .HEIGHT(`IMG_HEIGHT)
    )
    block1 (
		.clk(clk),
		.resetn(resetn),
		.valid_in(valid_in),
		.data_in_0(data_in_0),             
		.data_in_1(data_in_1),             
		.data_in_2(data_in_2), 
        // // EXTEND
        .data_in_3(data_in_3),             
		.data_in_4(data_in_4),             
		.data_in_5(data_in_5), 
        .data_in_6(data_in_6),             
		.data_in_7(data_in_7), 

        .data_out_0(data_out_0),
        .data_out_1(data_out_1),
        .data_out_2(data_out_2),
        .data_out_3(data_out_3),
        .data_out_4(data_out_4),
        .data_out_5(data_out_5),
        .data_out_6(data_out_6),
        .data_out_7(data_out_7),

		.valid_out(valid_out),
		.done()
		);

    tb_writer_3d #(
        // .output_file(Outfile),
        .output_file_0(Outfile_0),
        .output_file_1(Outfile_1),
        .output_file_2(Outfile_2),
        .output_file_3(Outfile_3),
        .output_file_4(Outfile_4),
        .output_file_5(Outfile_5),
        .output_file_6(Outfile_6),
        .output_file_7(Outfile_7),

        // .WIDTH(`IMG_WIDTH>>1),
        // .HEIGHT(`IMG_HEIGHT>>1)
        .WIDTH(`IMG_WIDTH),
        .HEIGHT(`IMG_HEIGHT)
    ) writer(
        .clk(clk),
        .resetn(resetn),

        // .data_in(data_out),
        .data_in_0(data_out_0),
        .data_in_1(data_out_1),
        .data_in_2(data_out_2),
        .data_in_3(data_out_3),
        .data_in_4(data_out_4),
        .data_in_5(data_out_5),
        .data_in_6(data_out_6),
        .data_in_7(data_out_7),

        .data_valid_in(valid_out),
        .done(done)
    );

endmodule






// --------------- ex-TESTBENCH -------------

// module tb_conv3d_1kernel_1channel;
//     // // path on Ubuntu
//     parameter Image_Channel0 = "/home/truong/Desktop/git_vgg16/Data/data_fp_image_channel_000.txt";
//     parameter Image_Channel1 = "/home/truong/Desktop/git_vgg16/Data/data_fp_image_channel_001.txt";
//     parameter Image_Channel2 = "/home/truong/Desktop/git_vgg16/Data/data_fp_image_channel_002.txt";
//     // parameter Outfile   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_000.txt";

//     parameter Outfile_0   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_000.txt";
//     parameter Outfile_1   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_001.txt";
//     parameter Outfile_2   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_002.txt";
//     parameter Outfile_3   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_003.txt";
//     parameter Outfile_4   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_004.txt";
//     parameter Outfile_5   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_005.txt";
//     parameter Outfile_6   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_006.txt";
//     parameter Outfile_7   = "/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_8kernel_3channel_007.txt";

//     parameter k = 10;

//     // LAM ON NHO DAT DUNG KICH THUOC ANH KHONG THI DUNG HOI HAN!
//     parameter DATA_WIDTH = 32;
//     parameter WIDTH = 20;
//     parameter HEIGHT = 20;
//     parameter Total_Pixel = WIDTH * HEIGHT;


//     reg clk;
//     reg resetn;
//     reg valid_in;
//     reg [31:0] data_in0;
//     reg [31:0] data_in1;
//     reg [31:0] data_in2;
//     // wire [31:0] data_out;
//     wire valid_out, done;

//     wire   [DATA_WIDTH-1:0]    data_out0;
//     wire   [DATA_WIDTH-1:0]    data_out1;
//     wire   [DATA_WIDTH-1:0]    data_out2;
//     wire   [DATA_WIDTH-1:0]    data_out3;
//     wire   [DATA_WIDTH-1:0]    data_out4;
//     wire   [DATA_WIDTH-1:0]    data_out5;
//     wire   [DATA_WIDTH-1:0]    data_out6;
//     wire   [DATA_WIDTH-1:0]    data_out7;

//     reg [32-1:0] In_Memory_0 [0:Total_Pixel-1];
//     reg [32-1:0] In_Memory_1 [0:Total_Pixel-1];
//     reg [32-1:0] In_Memory_2 [0:Total_Pixel-1];

//     initial 
//     begin
//         $readmemh(Image_Channel0, In_Memory_0);
//         $readmemh(Image_Channel1, In_Memory_1);
//         $readmemh(Image_Channel2, In_Memory_2);
//     end

//     initial 
//     begin
//         clk = 1'b0;
//         resetn = 1'b0;
//         valid_in = 1'b1;    
//         #(k*3/2) resetn = 1'b1;
//     end

//     integer i;
//     initial 
//     begin 
//         //#(k*2) data_in = In_Memory[i];
//         #(k*3/2);
//         for (i = 0; i < Total_Pixel; i = i + 1) 
//         begin
            
//             // if (i == 4)
//             // valid_in = 1'b0; 
//             // if (i == 6)
//             // valid_in = 1'b1; 

//             // if (i == 10)
//             // valid_in = 1'b0; 
//             // if (i == 14)
//             // valid_in = 1'b1; 

            
//             data_in0 = In_Memory_0[i];
//             data_in1 = In_Memory_1[i];
//             data_in2 = In_Memory_2[i];
//             // in2 = In_Memory[i + 1];
//             #(k*2);            
//         end
//         data_in0 = 32'bx;
//         data_in1 = 32'bx;
//         data_in2 = 32'bx;
//         // -------  Can duy tri VALID_IN them WIDTH+1 clock de co the tinh het so pixel o hang cuoi cung trong anh ---------
//         #(k*2*(WIDTH + 1));
        
//         valid_in = 1'b0;
//         // #(k*4) $stop;
//     end

//     // reg [32-1:0] Out_Memory [0:Total_Pixel-1];
    
//     reg [32-1:0] Out_Memory_0 [0:Total_Pixel-1];
//     reg [32-1:0] Out_Memory_1 [0:Total_Pixel-1];
//     reg [32-1:0] Out_Memory_2 [0:Total_Pixel-1];
//     reg [32-1:0] Out_Memory_3 [0:Total_Pixel-1];
//     reg [32-1:0] Out_Memory_4 [0:Total_Pixel-1];
//     reg [32-1:0] Out_Memory_5 [0:Total_Pixel-1];
//     reg [32-1:0] Out_Memory_6 [0:Total_Pixel-1];
//     reg [32-1:0] Out_Memory_7 [0:Total_Pixel-1];
//     integer j;
//     initial 
//     begin
//         j = 0;
//         #(k*3/2);

//         while (valid_out == 1'b0)
//         begin
//              #(k*2);
//         end

//         for (j = 0; j < Total_Pixel; j = j + 1)
//         begin
//             if (valid_out == 1'b1)
//                 // Out_Memory[j] = data_out;
//                 begin
//                 Out_Memory_0[j] = data_out0;
//                 Out_Memory_1[j] = data_out1;
//                 Out_Memory_2[j] = data_out2;
//                 Out_Memory_3[j] = data_out3;
//                 Out_Memory_4[j] = data_out4;
//                 Out_Memory_5[j] = data_out5;
//                 Out_Memory_6[j] = data_out6;
//                 Out_Memory_7[j] = data_out7;
//                 end
//             else
//                 // Out_Memory[j] = 32'hx;
//                 begin
//                 Out_Memory_0[j] = 32'hx;
//                 Out_Memory_1[j] = 32'hx;
//                 Out_Memory_2[j] = 32'hx;
//                 Out_Memory_3[j] = 32'hx;
//                 Out_Memory_4[j] = 32'hx;
//                 Out_Memory_5[j] = 32'hx;
//                 Out_Memory_6[j] = 32'hx;
//                 Out_Memory_7[j] = 32'hx;
//                 end
//             #(k*2);
//         end

//         #(k*2);
//         // $writememh(Outfile, Out_Memory);

//         $writememh(Outfile_0, Out_Memory_0);
//         $writememh(Outfile_1, Out_Memory_1);
//         $writememh(Outfile_2, Out_Memory_2);
//         $writememh(Outfile_3, Out_Memory_3);
//         $writememh(Outfile_4, Out_Memory_4);
//         $writememh(Outfile_5, Out_Memory_5);
//         $writememh(Outfile_6, Out_Memory_6);
//         $writememh(Outfile_7, Out_Memory_7);

//         #k $stop;
//     end
    
//     always #k clk = ~clk;

//     // testbench cho mach conv2d_8kernel_3channel
//     block1_conv1_8_kernel_3_channel #(
// 		.DATA_WIDTH(32),.IMG_WIDTH(WIDTH),.IMG_HEIGHT(HEIGHT)
// 		)
// 		block1_conv1_8kernel_3channel(
// 		clk,
// 		resetn,
// 		valid_in,
// 		data_in0,             
// 		data_in1,             
// 		data_in2,             
// 		// load_kernel0,
// 		// kernel,            
// 		// data_out,
//         data_out0,
//         data_out1,
//         data_out2,
//         data_out3,
//         data_out4,
//         data_out5,
//         data_out6,
//         data_out7,
// 		valid_out,
// 		done
// 		// load_kernel_done_0
// 		);

// endmodule