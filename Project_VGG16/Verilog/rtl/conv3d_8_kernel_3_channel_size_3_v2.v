`include "conv3d_kernel_3_channel_size_3.v"

module conv3d_8_kernel_3_channel_size_3_v2 #(
	parameter DATA_WIDTH = 32,
    parameter IMG_WIDTH = 56,
    parameter IMG_HEIGHT = 56,
    parameter CHANNEL = 3,
    parameter NUM_KERNEL = 8,

    // Kx_Cy_Wz = KERNELx_CHANNELy_WEIGHTz
     
	parameter K0_C0_W0 = 32'h0, K0_C0_W1 = 32'h0, K0_C0_W2 = 32'h0, K0_C0_W3 = 32'h0, K0_C0_W4 = 32'h0, K0_C0_W5 = 32'h0, K0_C0_W6 = 32'h0, K0_C0_W7 = 32'h0, K0_C0_W8 = 32'h0,
	parameter K0_C1_W0 = 32'h0, K0_C1_W1 = 32'h0, K0_C1_W2 = 32'h0, K0_C1_W3 = 32'h0, K0_C1_W4 = 32'h0, K0_C1_W5 = 32'h0, K0_C1_W6 = 32'h0, K0_C1_W7 = 32'h0, K0_C1_W8 = 32'h0,
	parameter K0_C2_W0 = 32'h0, K0_C2_W1 = 32'h0, K0_C2_W2 = 32'h0, K0_C2_W3 = 32'h0, K0_C2_W4 = 32'h0, K0_C2_W5 = 32'h0, K0_C2_W6 = 32'h0, K0_C2_W7 = 32'h0, K0_C2_W8 = 32'h0,
	parameter K0_BIAS  = 32'h0,

	parameter K1_C0_W0 = 32'h0, K1_C0_W1 = 32'h0, K1_C0_W2 = 32'h0, K1_C0_W3 = 32'h0, K1_C0_W4 = 32'h0, K1_C0_W5 = 32'h0, K1_C0_W6 = 32'h0, K1_C0_W7 = 32'h0, K1_C0_W8 = 32'h0,
	parameter K1_C1_W0 = 32'h0, K1_C1_W1 = 32'h0, K1_C1_W2 = 32'h0, K1_C1_W3 = 32'h0, K1_C1_W4 = 32'h0, K1_C1_W5 = 32'h0, K1_C1_W6 = 32'h0, K1_C1_W7 = 32'h0, K1_C1_W8 = 32'h0,
	parameter K1_C2_W0 = 32'h0, K1_C2_W1 = 32'h0, K1_C2_W2 = 32'h0, K1_C2_W3 = 32'h0, K1_C2_W4 = 32'h0, K1_C2_W5 = 32'h0, K1_C2_W6 = 32'h0, K1_C2_W7 = 32'h0, K1_C2_W8 = 32'h0,
	parameter K1_BIAS  = 32'h0,

	parameter K2_C0_W0 = 32'h0, K2_C0_W1 = 32'h0, K2_C0_W2 = 32'h0, K2_C0_W3 = 32'h0, K2_C0_W4 = 32'h0, K2_C0_W5 = 32'h0, K2_C0_W6 = 32'h0, K2_C0_W7 = 32'h0, K2_C0_W8 = 32'h0,
	parameter K2_C1_W0 = 32'h0, K2_C1_W1 = 32'h0, K2_C1_W2 = 32'h0, K2_C1_W3 = 32'h0, K2_C1_W4 = 32'h0, K2_C1_W5 = 32'h0, K2_C1_W6 = 32'h0, K2_C1_W7 = 32'h0, K2_C1_W8 = 32'h0,
	parameter K2_C2_W0 = 32'h0, K2_C2_W1 = 32'h0, K2_C2_W2 = 32'h0, K2_C2_W3 = 32'h0, K2_C2_W4 = 32'h0, K2_C2_W5 = 32'h0, K2_C2_W6 = 32'h0, K2_C2_W7 = 32'h0, K2_C2_W8 = 32'h0,
	parameter K2_BIAS  = 32'h0,

	parameter K3_C0_W0 = 32'h0, K3_C0_W1 = 32'h0, K3_C0_W2 = 32'h0, K3_C0_W3 = 32'h0, K3_C0_W4 = 32'h0, K3_C0_W5 = 32'h0, K3_C0_W6 = 32'h0, K3_C0_W7 = 32'h0, K3_C0_W8 = 32'h0,
	parameter K3_C1_W0 = 32'h0, K3_C1_W1 = 32'h0, K3_C1_W2 = 32'h0, K3_C1_W3 = 32'h0, K3_C1_W4 = 32'h0, K3_C1_W5 = 32'h0, K3_C1_W6 = 32'h0, K3_C1_W7 = 32'h0, K3_C1_W8 = 32'h0,
	parameter K3_C2_W0 = 32'h0, K3_C2_W1 = 32'h0, K3_C2_W2 = 32'h0, K3_C2_W3 = 32'h0, K3_C2_W4 = 32'h0, K3_C2_W5 = 32'h0, K3_C2_W6 = 32'h0, K3_C2_W7 = 32'h0, K3_C2_W8 = 32'h0,
	parameter K3_BIAS  = 32'h0,

	parameter K4_C0_W0 = 32'h0, K4_C0_W1 = 32'h0, K4_C0_W2 = 32'h0, K4_C0_W3 = 32'h0, K4_C0_W4 = 32'h0, K4_C0_W5 = 32'h0, K4_C0_W6 = 32'h0, K4_C0_W7 = 32'h0, K4_C0_W8 = 32'h0,
	parameter K4_C1_W0 = 32'h0, K4_C1_W1 = 32'h0, K4_C1_W2 = 32'h0, K4_C1_W3 = 32'h0, K4_C1_W4 = 32'h0, K4_C1_W5 = 32'h0, K4_C1_W6 = 32'h0, K4_C1_W7 = 32'h0, K4_C1_W8 = 32'h0,
	parameter K4_C2_W0 = 32'h0, K4_C2_W1 = 32'h0, K4_C2_W2 = 32'h0, K4_C2_W3 = 32'h0, K4_C2_W4 = 32'h0, K4_C2_W5 = 32'h0, K4_C2_W6 = 32'h0, K4_C2_W7 = 32'h0, K4_C2_W8 = 32'h0,
	parameter K4_BIAS  = 32'h0,

	parameter K5_C0_W0 = 32'h0, K5_C0_W1 = 32'h0, K5_C0_W2 = 32'h0, K5_C0_W3 = 32'h0, K5_C0_W4 = 32'h0, K5_C0_W5 = 32'h0, K5_C0_W6 = 32'h0, K5_C0_W7 = 32'h0, K5_C0_W8 = 32'h0,
	parameter K5_C1_W0 = 32'h0, K5_C1_W1 = 32'h0, K5_C1_W2 = 32'h0, K5_C1_W3 = 32'h0, K5_C1_W4 = 32'h0, K5_C1_W5 = 32'h0, K5_C1_W6 = 32'h0, K5_C1_W7 = 32'h0, K5_C1_W8 = 32'h0,
	parameter K5_C2_W0 = 32'h0, K5_C2_W1 = 32'h0, K5_C2_W2 = 32'h0, K5_C2_W3 = 32'h0, K5_C2_W4 = 32'h0, K5_C2_W5 = 32'h0, K5_C2_W6 = 32'h0, K5_C2_W7 = 32'h0, K5_C2_W8 = 32'h0,
	parameter K5_BIAS  = 32'h0,

	parameter K6_C0_W0 = 32'h0, K6_C0_W1 = 32'h0, K6_C0_W2 = 32'h0, K6_C0_W3 = 32'h0, K6_C0_W4 = 32'h0, K6_C0_W5 = 32'h0, K6_C0_W6 = 32'h0, K6_C0_W7 = 32'h0, K6_C0_W8 = 32'h0,
	parameter K6_C1_W0 = 32'h0, K6_C1_W1 = 32'h0, K6_C1_W2 = 32'h0, K6_C1_W3 = 32'h0, K6_C1_W4 = 32'h0, K6_C1_W5 = 32'h0, K6_C1_W6 = 32'h0, K6_C1_W7 = 32'h0, K6_C1_W8 = 32'h0,
	parameter K6_C2_W0 = 32'h0, K6_C2_W1 = 32'h0, K6_C2_W2 = 32'h0, K6_C2_W3 = 32'h0, K6_C2_W4 = 32'h0, K6_C2_W5 = 32'h0, K6_C2_W6 = 32'h0, K6_C2_W7 = 32'h0, K6_C2_W8 = 32'h0,
	parameter K6_BIAS  = 32'h0,

	parameter K7_C0_W0 = 32'h0, K7_C0_W1 = 32'h0, K7_C0_W2 = 32'h0, K7_C0_W3 = 32'h0, K7_C0_W4 = 32'h0, K7_C0_W5 = 32'h0, K7_C0_W6 = 32'h0, K7_C0_W7 = 32'h0, K7_C0_W8 = 32'h0,
	parameter K7_C1_W0 = 32'h0, K7_C1_W1 = 32'h0, K7_C1_W2 = 32'h0, K7_C1_W3 = 32'h0, K7_C1_W4 = 32'h0, K7_C1_W5 = 32'h0, K7_C1_W6 = 32'h0, K7_C1_W7 = 32'h0, K7_C1_W8 = 32'h0,
	parameter K7_C2_W0 = 32'h0, K7_C2_W1 = 32'h0, K7_C2_W2 = 32'h0, K7_C2_W3 = 32'h0, K7_C2_W4 = 32'h0, K7_C2_W5 = 32'h0, K7_C2_W6 = 32'h0, K7_C2_W7 = 32'h0, K7_C2_W8 = 32'h0,
	parameter K7_BIAS  = 32'h0
    )
    (
    input	clk,
	input	resetn,
	input	data_valid_in,
	input	[DATA_WIDTH-1:0]	data_in0,
	input	[DATA_WIDTH-1:0]	data_in1,
	input	[DATA_WIDTH-1:0]	data_in2,
	output	[DATA_WIDTH-1:0]	data_out_conv0,
	output	[DATA_WIDTH-1:0]	data_out_conv1,
	output	[DATA_WIDTH-1:0]	data_out_conv2,
	output	[DATA_WIDTH-1:0]	data_out_conv3,
	output	[DATA_WIDTH-1:0]	data_out_conv4,
	output	[DATA_WIDTH-1:0]	data_out_conv5,
	output	[DATA_WIDTH-1:0]	data_out_conv6,
	output	[DATA_WIDTH-1:0]	data_out_conv7,
	output	valid_out_pixel,
	output	done_img
    );

    // reg [31:0] counter;
    wire [NUM_KERNEL-1:0] valid_out_conv;
	wire [NUM_KERNEL-1:0] done_conv; 

    
	conv3d_kernel_3_channel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),
		.C0_W0(K0_C0_W0),
		.C0_W1(K0_C0_W1),
		.C0_W2(K0_C0_W2),
		.C0_W3(K0_C0_W3),
		.C0_W4(K0_C0_W4),
		.C0_W5(K0_C0_W5),
		.C0_W6(K0_C0_W6),
		.C0_W7(K0_C0_W7),
		.C0_W8(K0_C0_W8),
		.C1_W0(K0_C1_W0),
		.C1_W1(K0_C1_W1),
		.C1_W2(K0_C1_W2),
		.C1_W3(K0_C1_W3),
		.C1_W4(K0_C1_W4),
		.C1_W5(K0_C1_W5),
		.C1_W6(K0_C1_W6),
		.C1_W7(K0_C1_W7),
		.C1_W8(K0_C1_W8),
		.C2_W0(K0_C2_W0),
		.C2_W1(K0_C2_W1),
		.C2_W2(K0_C2_W2),
		.C2_W3(K0_C2_W3),
		.C2_W4(K0_C2_W4),
		.C2_W5(K0_C2_W5),
		.C2_W6(K0_C2_W6),
		.C2_W7(K0_C2_W7),
		.C2_W8(K0_C2_W8),
		.BIAS(K0_BIAS)
		)
		conv_0(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(data_valid_in),
		.data_in0(data_in0),
		.data_in1(data_in1),
		.data_in2(data_in2),
		.data_out(data_out_conv0),
		.valid_out_pixel(valid_out_conv[0]),
		.done(done_conv[0])
		);
	conv3d_kernel_3_channel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),
		.C0_W0(K1_C0_W0),
		.C0_W1(K1_C0_W1),
		.C0_W2(K1_C0_W2),
		.C0_W3(K1_C0_W3),
		.C0_W4(K1_C0_W4),
		.C0_W5(K1_C0_W5),
		.C0_W6(K1_C0_W6),
		.C0_W7(K1_C0_W7),
		.C0_W8(K1_C0_W8),
		.C1_W0(K1_C1_W0),
		.C1_W1(K1_C1_W1),
		.C1_W2(K1_C1_W2),
		.C1_W3(K1_C1_W3),
		.C1_W4(K1_C1_W4),
		.C1_W5(K1_C1_W5),
		.C1_W6(K1_C1_W6),
		.C1_W7(K1_C1_W7),
		.C1_W8(K1_C1_W8),
		.C2_W0(K1_C2_W0),
		.C2_W1(K1_C2_W1),
		.C2_W2(K1_C2_W2),
		.C2_W3(K1_C2_W3),
		.C2_W4(K1_C2_W4),
		.C2_W5(K1_C2_W5),
		.C2_W6(K1_C2_W6),
		.C2_W7(K1_C2_W7),
		.C2_W8(K1_C2_W8),
		.BIAS(K1_BIAS)
		)
		conv_1(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(data_valid_in),
		.data_in0(data_in0),
		.data_in1(data_in1),
		.data_in2(data_in2),
		.data_out(data_out_conv1),
		.valid_out_pixel(valid_out_conv[1]),
		.done(done_conv[1])
		);
	conv3d_kernel_3_channel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),
		.C0_W0(K2_C0_W0),
		.C0_W1(K2_C0_W1),
		.C0_W2(K2_C0_W2),
		.C0_W3(K2_C0_W3),
		.C0_W4(K2_C0_W4),
		.C0_W5(K2_C0_W5),
		.C0_W6(K2_C0_W6),
		.C0_W7(K2_C0_W7),
		.C0_W8(K2_C0_W8),
		.C1_W0(K2_C1_W0),
		.C1_W1(K2_C1_W1),
		.C1_W2(K2_C1_W2),
		.C1_W3(K2_C1_W3),
		.C1_W4(K2_C1_W4),
		.C1_W5(K2_C1_W5),
		.C1_W6(K2_C1_W6),
		.C1_W7(K2_C1_W7),
		.C1_W8(K2_C1_W8),
		.C2_W0(K2_C2_W0),
		.C2_W1(K2_C2_W1),
		.C2_W2(K2_C2_W2),
		.C2_W3(K2_C2_W3),
		.C2_W4(K2_C2_W4),
		.C2_W5(K2_C2_W5),
		.C2_W6(K2_C2_W6),
		.C2_W7(K2_C2_W7),
		.C2_W8(K2_C2_W8),
		.BIAS(K2_BIAS)
		)
		conv_2(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(data_valid_in),
		.data_in0(data_in0),
		.data_in1(data_in1),
		.data_in2(data_in2),
		.data_out(data_out_conv2),
		.valid_out_pixel(valid_out_conv[2]),
		.done(done_conv[2])
		);
	conv3d_kernel_3_channel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),
		.C0_W0(K3_C0_W0),
		.C0_W1(K3_C0_W1),
		.C0_W2(K3_C0_W2),
		.C0_W3(K3_C0_W3),
		.C0_W4(K3_C0_W4),
		.C0_W5(K3_C0_W5),
		.C0_W6(K3_C0_W6),
		.C0_W7(K3_C0_W7),
		.C0_W8(K3_C0_W8),
		.C1_W0(K3_C1_W0),
		.C1_W1(K3_C1_W1),
		.C1_W2(K3_C1_W2),
		.C1_W3(K3_C1_W3),
		.C1_W4(K3_C1_W4),
		.C1_W5(K3_C1_W5),
		.C1_W6(K3_C1_W6),
		.C1_W7(K3_C1_W7),
		.C1_W8(K3_C1_W8),
		.C2_W0(K3_C2_W0),
		.C2_W1(K3_C2_W1),
		.C2_W2(K3_C2_W2),
		.C2_W3(K3_C2_W3),
		.C2_W4(K3_C2_W4),
		.C2_W5(K3_C2_W5),
		.C2_W6(K3_C2_W6),
		.C2_W7(K3_C2_W7),
		.C2_W8(K3_C2_W8),
		.BIAS(K3_BIAS)
		)
		conv_3(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(data_valid_in),
		.data_in0(data_in0),
		.data_in1(data_in1),
		.data_in2(data_in2),
		.data_out(data_out_conv3),
		.valid_out_pixel(valid_out_conv[3]),
		.done(done_conv[3])
		);
	conv3d_kernel_3_channel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),
		.C0_W0(K4_C0_W0),
		.C0_W1(K4_C0_W1),
		.C0_W2(K4_C0_W2),
		.C0_W3(K4_C0_W3),
		.C0_W4(K4_C0_W4),
		.C0_W5(K4_C0_W5),
		.C0_W6(K4_C0_W6),
		.C0_W7(K4_C0_W7),
		.C0_W8(K4_C0_W8),
		.C1_W0(K4_C1_W0),
		.C1_W1(K4_C1_W1),
		.C1_W2(K4_C1_W2),
		.C1_W3(K4_C1_W3),
		.C1_W4(K4_C1_W4),
		.C1_W5(K4_C1_W5),
		.C1_W6(K4_C1_W6),
		.C1_W7(K4_C1_W7),
		.C1_W8(K4_C1_W8),
		.C2_W0(K4_C2_W0),
		.C2_W1(K4_C2_W1),
		.C2_W2(K4_C2_W2),
		.C2_W3(K4_C2_W3),
		.C2_W4(K4_C2_W4),
		.C2_W5(K4_C2_W5),
		.C2_W6(K4_C2_W6),
		.C2_W7(K4_C2_W7),
		.C2_W8(K4_C2_W8),
		.BIAS(K4_BIAS)
		)
		conv_4(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(data_valid_in),
		.data_in0(data_in0),
		.data_in1(data_in1),
		.data_in2(data_in2),
		.data_out(data_out_conv4),
		.valid_out_pixel(valid_out_conv[4]),
		.done(done_conv[4])
		);
	conv3d_kernel_3_channel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),
		.C0_W0(K5_C0_W0),
		.C0_W1(K5_C0_W1),
		.C0_W2(K5_C0_W2),
		.C0_W3(K5_C0_W3),
		.C0_W4(K5_C0_W4),
		.C0_W5(K5_C0_W5),
		.C0_W6(K5_C0_W6),
		.C0_W7(K5_C0_W7),
		.C0_W8(K5_C0_W8),
		.C1_W0(K5_C1_W0),
		.C1_W1(K5_C1_W1),
		.C1_W2(K5_C1_W2),
		.C1_W3(K5_C1_W3),
		.C1_W4(K5_C1_W4),
		.C1_W5(K5_C1_W5),
		.C1_W6(K5_C1_W6),
		.C1_W7(K5_C1_W7),
		.C1_W8(K5_C1_W8),
		.C2_W0(K5_C2_W0),
		.C2_W1(K5_C2_W1),
		.C2_W2(K5_C2_W2),
		.C2_W3(K5_C2_W3),
		.C2_W4(K5_C2_W4),
		.C2_W5(K5_C2_W5),
		.C2_W6(K5_C2_W6),
		.C2_W7(K5_C2_W7),
		.C2_W8(K5_C2_W8),
		.BIAS(K5_BIAS)
		)
		conv_5(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(data_valid_in),
		.data_in0(data_in0),
		.data_in1(data_in1),
		.data_in2(data_in2),
		.data_out(data_out_conv5),
		.valid_out_pixel(valid_out_conv[5]),
		.done(done_conv[5])
		);
	conv3d_kernel_3_channel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),
		.C0_W0(K6_C0_W0),
		.C0_W1(K6_C0_W1),
		.C0_W2(K6_C0_W2),
		.C0_W3(K6_C0_W3),
		.C0_W4(K6_C0_W4),
		.C0_W5(K6_C0_W5),
		.C0_W6(K6_C0_W6),
		.C0_W7(K6_C0_W7),
		.C0_W8(K6_C0_W8),
		.C1_W0(K6_C1_W0),
		.C1_W1(K6_C1_W1),
		.C1_W2(K6_C1_W2),
		.C1_W3(K6_C1_W3),
		.C1_W4(K6_C1_W4),
		.C1_W5(K6_C1_W5),
		.C1_W6(K6_C1_W6),
		.C1_W7(K6_C1_W7),
		.C1_W8(K6_C1_W8),
		.C2_W0(K6_C2_W0),
		.C2_W1(K6_C2_W1),
		.C2_W2(K6_C2_W2),
		.C2_W3(K6_C2_W3),
		.C2_W4(K6_C2_W4),
		.C2_W5(K6_C2_W5),
		.C2_W6(K6_C2_W6),
		.C2_W7(K6_C2_W7),
		.C2_W8(K6_C2_W8),
		.BIAS(K6_BIAS)
		)
		conv_6(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(data_valid_in),
		.data_in0(data_in0),
		.data_in1(data_in1),
		.data_in2(data_in2),
		.data_out(data_out_conv6),
		.valid_out_pixel(valid_out_conv[6]),
		.done(done_conv[6])
		);
	conv3d_kernel_3_channel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),
		.C0_W0(K7_C0_W0),
		.C0_W1(K7_C0_W1),
		.C0_W2(K7_C0_W2),
		.C0_W3(K7_C0_W3),
		.C0_W4(K7_C0_W4),
		.C0_W5(K7_C0_W5),
		.C0_W6(K7_C0_W6),
		.C0_W7(K7_C0_W7),
		.C0_W8(K7_C0_W8),
		.C1_W0(K7_C1_W0),
		.C1_W1(K7_C1_W1),
		.C1_W2(K7_C1_W2),
		.C1_W3(K7_C1_W3),
		.C1_W4(K7_C1_W4),
		.C1_W5(K7_C1_W5),
		.C1_W6(K7_C1_W6),
		.C1_W7(K7_C1_W7),
		.C1_W8(K7_C1_W8),
		.C2_W0(K7_C2_W0),
		.C2_W1(K7_C2_W1),
		.C2_W2(K7_C2_W2),
		.C2_W3(K7_C2_W3),
		.C2_W4(K7_C2_W4),
		.C2_W5(K7_C2_W5),
		.C2_W6(K7_C2_W6),
		.C2_W7(K7_C2_W7),
		.C2_W8(K7_C2_W8),
		.BIAS(K7_BIAS)
		)
		conv_7(
		.clk(clk),
		.resetn(resetn),
		.data_valid_in(data_valid_in),
		.data_in0(data_in0),
		.data_in1(data_in1),
		.data_in2(data_in2),
		.data_out(data_out_conv7),
		.valid_out_pixel(valid_out_conv[7]),
		.done(done_conv[7])
		);

	assign valid_out_pixel = valid_out_conv[7];

	assign done_img = done_conv[7];


    // assign valid_out_pixel = valid_out_conv7;
    // assign done_img = done_conv_7;

    // always @ (posedge clk or negedge resetn) 
    // begin
    //     if(resetn == 1'b0) 
    //         counter <= 0;
    //     else 
    //         if (done_img == 1'b1)
    //             counter <= 0;
    //         else 
    //             if(valid_out_pixel == 1'b1) 
    //             begin
    //                 if(counter == (IMG_WIDTH)*(IMG_HEIGHT) -1 ) 
    //                     counter <= 0;
    //                 else 
    //                     counter <= counter + 1;
    //             end
    //             else 
    //                 counter <= counter;
    // end

    // always @ (posedge clk or negedge resetn) 
    // begin
    //     if(resetn == 1'b0) 
    //         done_img <= 0;
    //     else 
    //         if(counter == (IMG_WIDTH)*(IMG_HEIGHT) -2) 
    //             done_img <= (valid_out_pixel)?1'b1:1'b0;
    //         else 
    //             done_img <= 0;
    // end

    // assign done_img = (counter == (IMG_WIDTH)*(IMG_HEIGHT) -1) & valid_out_pixel;


endmodule