`ifndef ACTIVATE_INCLUDED
    `include "activate.v"
    `define ACTIVATE_INCLUDED
`endif

module block1_demo #(
    parameter DATA_WIDTH = 32,
    parameter WIDTH = 56,
    parameter HEIGHT = 56,
    parameter CHANNEL_OUT = 8
) (
    input clk,
    input resetn,
    input valid_in,
    
    // // ports for conv2d
    // input [DATA_WIDTH-1:0] data_in,
    // output [DATA_WIDTH-1:0] data_out,
    // output valid_out,
    // output done


    // // ports for conv3d
    input [DATA_WIDTH-1:0] data_in_0,
    input [DATA_WIDTH-1:0] data_in_1,
    input [DATA_WIDTH-1:0] data_in_2,

    output [DATA_WIDTH-1:0] data_out_0,
    output [DATA_WIDTH-1:0] data_out_1,
    output [DATA_WIDTH-1:0] data_out_2,
    output [DATA_WIDTH-1:0] data_out_3,
    output [DATA_WIDTH-1:0] data_out_4,
    output [DATA_WIDTH-1:0] data_out_5,
    output [DATA_WIDTH-1:0] data_out_6,
    output [DATA_WIDTH-1:0] data_out_7,

    output valid_out,
    output done 
);
    // // // testbench cho mach conv2d_1kernel_1channel
    // wire [DATA_WIDTH-1:0] conv_out;
    // wire [DATA_WIDTH-1:0] relu_out;    
    // wire conv_valid_out;

    // conv2d_kernel_size_3 #(
    //     .DATA_WIDTH(32),.IMG_WIDTH(WIDTH),.IMG_HEIGHT(HEIGHT),
    //     .kernelR0( 32'h3f800000 ),
    //     .kernelR1( 32'h3f8ccccd ),
    //     .kernelR2( 32'h3f800000 ),
    //     .kernelR3( 32'h00000000 ),
    //     .kernelR4( 32'h00000000 ),
    //     .kernelR5( 32'h00000000 ),
    //     .kernelR6( 32'hbf800000 ),
    //     .kernelR7( 32'hbf8ccccd ),
    //     .kernelR8( 32'hbf800000 )
    // )
    // conv1_0(
    //     .clk(clk),
    //     .resetn(resetn),
    //     .data_valid_in(valid_in),
    //     .data_in(data_in),
    //     .data_out(conv_out),
    //     .valid_out_pixel(conv_valid_out),
    //     .done()
    // );

    // activate #(
    //     .DATA_WIDTH(32)
    // )
    // relu (
    //     .in(conv_out),
    //     .out(relu_out)
    // );

    // max_pooling #(
    // .DATA_WIDTH(32),
    // .WIDTH(WIDTH),
    // .HEIGHT(HEIGHT)
    // ) 
    // max_pool(
    //     .clk(clk),
    //     .resetn(resetn),
    //     .valid_in(conv_valid_out),
    //     .data_in(relu_out),
    //     .data_out(data_out),
    //     .valid_out(valid_out),
    //     .done(done)
    // );
    


    // testbench cho mach conv3d_8kernel_3channel
    wire [DATA_WIDTH-1:0] conv_out  [0: CHANNEL_OUT -1];
    wire [DATA_WIDTH-1:0] relu_out  [0: CHANNEL_OUT -1];
    
    wire conv_valid_out;

    wire [DATA_WIDTH-1:0] data_out_pool [0: CHANNEL_OUT -1];
    wire [CHANNEL_OUT -1 : 0] valid_out_pool;
    wire [CHANNEL_OUT -1 : 0] done_pool;


    assign data_out_0 = data_out_pool[0];
    assign data_out_1 = data_out_pool[1];
    assign data_out_2 = data_out_pool[2];
    assign data_out_3 = data_out_pool[3];
    assign data_out_4 = data_out_pool[4];
    assign data_out_5 = data_out_pool[5];
    assign data_out_6 = data_out_pool[6];
    assign data_out_7 = data_out_pool[7];

    assign valid_out = valid_out_pool[CHANNEL_OUT -1];
    assign done = done_pool[CHANNEL_OUT -1];


    block1_conv1_8_kernel_3_channel #(
		.DATA_WIDTH(32),.IMG_WIDTH(WIDTH),.IMG_HEIGHT(HEIGHT)
    )
    block1_conv1_8kernel_3channel(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(valid_in),
		.data_in0(data_in_0),             
		.data_in1(data_in_1),             
		.data_in2(data_in_2), 

        .data_out_conv0(conv_out[0]),
        .data_out_conv1(conv_out[1]),
        .data_out_conv2(conv_out[2]),
        .data_out_conv3(conv_out[3]),
        .data_out_conv4(conv_out[4]),
        .data_out_conv5(conv_out[5]),
        .data_out_conv6(conv_out[6]),
        .data_out_conv7(conv_out[7]),

		.valid_out_pixel(conv_valid_out),
		.done_img()
		);

    genvar i;

    generate
    for (i = 0; i < CHANNEL_OUT; i=i+1) 
    begin :initial_relu_and_max_pool // needs CHANNEL_OUT relu
        // FP_Top_AddSub fp_adders(clk,resetn,valid_in_add[i],op_1[i],op_2[i],output_add[i],valid_out_add[i]);

        activate #(
            .DATA_WIDTH(32)
        )
        relu (
            .in(conv_out[i]),
            .out(relu_out[i])
        );

        max_pooling #(
            .DATA_WIDTH(32),
            .WIDTH(WIDTH),
            .HEIGHT(HEIGHT)
        )
        max_pool(
            .clk(clk),
            .resetn(resetn),
            .valid_in(conv_valid_out),
            .data_in(relu_out[i]),
            .data_out(data_out_pool[i]),
            .valid_out(valid_out_pool[i]),
            .done(done_pool[i])
        );
    end
    endgenerate

endmodule