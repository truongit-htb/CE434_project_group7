`timescale 1ns/1ps

`include "../Verilog/rtl/dimension.v"

module tb_conv2d_1kernel_1channel;
    // // path on Window
    // parameter Infile    = "E:/LAB/LAB_20_21_HK_II/CE434-ChuyenDeTKVM/git_vgg16/VGG16/CodePythonCNN/data_image_fp.txt";
    // parameter Outfile   = "E:/LAB/LAB_20_21_HK_II/CE434-ChuyenDeTKVM/git_vgg16/VGG16/CodePythonCNN/modelsim_out_conv2d_1kernel_1channel-02.txt";
    // // path on Ubuntu
    parameter Infile    = "../Data/data_fp_image_channel_002.txt";
    parameter Outfile   = "../Data/modelsim_conv2d_channel_222.txt";

    parameter k = 10;

    parameter DATA_WIDTH = 32;
    // parameter `IMG_WIDTH = 56;
    // parameter HEIGHT = 56;
    // parameter Total_Pixel = `IMG_WIDTH * `IMG_HEIGHT;


    reg clk;
    reg resetn;
    wire valid_in;
    wire [31:0] data_in;
    wire [31:0] data_out;
    wire valid_out, done;

    // reg [32-1:0] In_Memory [0:Total_Pixel-1];

    // initial 
    // begin
    //     $readmemh(Infile, In_Memory);
    // end

    initial 
    begin
        clk = 1'b0;
        resetn = 1'b0;
        // valid_in = 1'b1;    
        #(k*3/2) resetn = 1'b1;
    end

    // integer i;
    // initial 
    // begin 
    //     //#(k*2) data_in = In_Memory[i];
    //     #(k*3/2);
    //     for (i = 0; i < Total_Pixel; i = i + 1) 
    //     begin
            
    //         // if (i == 4)
    //         // valid_in = 1'b0; 
    //         // if (i == 6)
    //         // valid_in = 1'b1; 

    //         // if (i == 10)
    //         // valid_in = 1'b0; 
    //         // if (i == 14)
    //         // valid_in = 1'b1; 

            
    //         data_in = In_Memory[i];
    //         // in2 = In_Memory[i + 1];
    //         #(k*2);            
    //     end
    //     data_in = 32'bx;
    //     // -------  Can duy tri VALID_IN them WIDTH+1 clock de co the tinh het so pixel o hang cuoi cung trong anh ---------
    //     #(k*2*(`IMG_WIDTH + 1));
        
    //     valid_in = 1'b0;
    //     // #(k*4) $stop;
    // end

    // integer j;
    // reg [32-1:0] Out_Memory [0:Total_Pixel-1];
    // initial 
    // begin
    //     j = 0;
    //     #(k*3/2);

    //     while (valid_out == 1'b0)
    //     begin
    //          #(k*2);
    //     end

    //     for (j = 0; j < Total_Pixel; j = j + 1)
    //     begin
    //         if (valid_out == 1'b1)
    //             Out_Memory[j] = data_out;
    //         else
    //             Out_Memory[j] = 32'hx;
    //         #(k*2);
    //     end

    //     #(k*2) $writememh(Outfile, Out_Memory);
    //     #k $finish;
    // end
    
    always #k clk = ~clk;

    tb_generator #(
        .DWIDTH(32),
        .input_file(Infile),
        .WIDTH(`IMG_WIDTH),
        .HEIGHT(`IMG_HEIGHT)
    ) generator (
        .clk(clk),
        .resetn(resetn),
        .fifo_data(data_in),
        .fifo_wrreq(valid_in)
    );

    // testbench cho mach conv2d_1kernel_1channel
    conv2d_kernel_size_3 #(
        .DATA_WIDTH(32),.IMG_WIDTH(`IMG_WIDTH),.IMG_HEIGHT(`IMG_HEIGHT),
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
        .clk(clk),
        .resetn(resetn),
        .data_valid_in(valid_in),
        .data_in(data_in),
        .data_out(data_out),
        .valid_out_pixel(valid_out),
        .done()
    );

    tb_writer #(
        .output_file(Outfile),
        .WIDTH(`IMG_WIDTH),
        .HEIGHT(`IMG_HEIGHT)
    ) writer(
        .clk(clk),
        .resetn(resetn),
        .data_in(data_out),
        .data_valid_in(valid_out),
        .done(done)
    );

endmodule