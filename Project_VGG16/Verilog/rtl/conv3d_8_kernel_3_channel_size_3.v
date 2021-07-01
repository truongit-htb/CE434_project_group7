`include "conv3d_kernel_3_channel_size_3.v"

module conv3d_8_kernel_3_channel_size_3 #(
	parameter DATA_WIDTH = 32,
    parameter IMG_WIDTH = 56,
    parameter IMG_HEIGHT = 56,
    parameter SIZE = 3,
    parameter CHANNEL = 3,
    parameter NUM_KERNEL = 8,

    // Kx_Cy_Wz = KERNELx_CHANNELy_WEIGHTz
    parameter K0_C0_W0 = 32'h3f800000,
    parameter K0_C0_W1 = 32'h3f8ccccd,
    parameter K0_C0_W2 = 32'h3f800000,
    parameter K0_C0_W3 = 32'h00000000,
    parameter K0_C0_W4 = 32'h00000000,
    parameter K0_C0_W5 = 32'h00000000,
    parameter K0_C0_W6 = 32'hbf800000,
    parameter K0_C0_W7 = 32'hbf8ccccd,
    parameter K0_C0_W8 = 32'hbf800000,
    parameter K0_C1_W0 = 32'h3f800000,
    parameter K0_C1_W1 = 32'h00000000,
    parameter K0_C1_W2 = 32'hbf800000,
    parameter K0_C1_W3 = 32'h40000000,
    parameter K0_C1_W4 = 32'h00000000,
    parameter K0_C1_W5 = 32'hc0000000,
    parameter K0_C1_W6 = 32'h3f800000,
    parameter K0_C1_W7 = 32'h00000000,
    parameter K0_C1_W8 = 32'hbf800000,
    parameter K0_C2_W0 = 32'h3fc00000,
    parameter K0_C2_W1 = 32'h3f800000,
    parameter K0_C2_W2 = 32'h00000000,
    parameter K0_C2_W3 = 32'h3f800000,
    parameter K0_C2_W4 = 32'h00000000,
    parameter K0_C2_W5 = 32'hbf800000,
    parameter K0_C2_W6 = 32'h00000000,
    parameter K0_C2_W7 = 32'hbf800000,
    parameter K0_C2_W8 = 32'hbfc00000,
    parameter K0_BIAS  = 32'h0,

    parameter K1_C0_W0 = 32'h3f800000,
    parameter K1_C0_W1 = 32'h3f8ccccd,
    parameter K1_C0_W2 = 32'h3f800000,
    parameter K1_C0_W3 = 32'h00000000,
    parameter K1_C0_W4 = 32'h00000000,
    parameter K1_C0_W5 = 32'h00000000,
    parameter K1_C0_W6 = 32'hbf800000,
    parameter K1_C0_W7 = 32'hbf8ccccd,
    parameter K1_C0_W8 = 32'hbf800000,
    parameter K1_C1_W0 = 32'h3f800000,
    parameter K1_C1_W1 = 32'h00000000,
    parameter K1_C1_W2 = 32'hbf800000,
    parameter K1_C1_W3 = 32'h40000000,
    parameter K1_C1_W4 = 32'h00000000,
    parameter K1_C1_W5 = 32'hc0000000,
    parameter K1_C1_W6 = 32'h3f800000,
    parameter K1_C1_W7 = 32'h00000000,
    parameter K1_C1_W8 = 32'hbf800000,
    parameter K1_C2_W0 = 32'h3fc00000,
    parameter K1_C2_W1 = 32'h3f800000,
    parameter K1_C2_W2 = 32'h00000000,
    parameter K1_C2_W3 = 32'h3f800000,
    parameter K1_C2_W4 = 32'h00000000,
    parameter K1_C2_W5 = 32'hbf800000,
    parameter K1_C2_W6 = 32'h00000000,
    parameter K1_C2_W7 = 32'hbf800000,
    parameter K1_C2_W8 = 32'hbfc00000,
    parameter K1_BIAS  = 32'h0,

    parameter K2_C0_W0 = 32'h3f800000,
    parameter K2_C0_W1 = 32'h3f8ccccd,
    parameter K2_C0_W2 = 32'h3f800000,
    parameter K2_C0_W3 = 32'h00000000,
    parameter K2_C0_W4 = 32'h00000000,
    parameter K2_C0_W5 = 32'h00000000,
    parameter K2_C0_W6 = 32'hbf800000,
    parameter K2_C0_W7 = 32'hbf8ccccd,
    parameter K2_C0_W8 = 32'hbf800000,
    parameter K2_C1_W0 = 32'h3f800000,
    parameter K2_C1_W1 = 32'h00000000,
    parameter K2_C1_W2 = 32'hbf800000,
    parameter K2_C1_W3 = 32'h40000000,
    parameter K2_C1_W4 = 32'h00000000,
    parameter K2_C1_W5 = 32'hc0000000,
    parameter K2_C1_W6 = 32'h3f800000,
    parameter K2_C1_W7 = 32'h00000000,
    parameter K2_C1_W8 = 32'hbf800000,
    parameter K2_C2_W0 = 32'h3fc00000,
    parameter K2_C2_W1 = 32'h3f800000,
    parameter K2_C2_W2 = 32'h00000000,
    parameter K2_C2_W3 = 32'h3f800000,
    parameter K2_C2_W4 = 32'h00000000,
    parameter K2_C2_W5 = 32'hbf800000,
    parameter K2_C2_W6 = 32'h00000000,
    parameter K2_C2_W7 = 32'hbf800000,
    parameter K2_C2_W8 = 32'hbfc00000,
    parameter K2_BIAS  = 32'h0,

    parameter K3_C0_W0 = 32'h3f800000,
    parameter K3_C0_W1 = 32'h3f8ccccd,
    parameter K3_C0_W2 = 32'h3f800000,
    parameter K3_C0_W3 = 32'h00000000,
    parameter K3_C0_W4 = 32'h00000000,
    parameter K3_C0_W5 = 32'h00000000,
    parameter K3_C0_W6 = 32'hbf800000,
    parameter K3_C0_W7 = 32'hbf8ccccd,
    parameter K3_C0_W8 = 32'hbf800000,
    parameter K3_C1_W0 = 32'h3f800000,
    parameter K3_C1_W1 = 32'h00000000,
    parameter K3_C1_W2 = 32'hbf800000,
    parameter K3_C1_W3 = 32'h40000000,
    parameter K3_C1_W4 = 32'h00000000,
    parameter K3_C1_W5 = 32'hc0000000,
    parameter K3_C1_W6 = 32'h3f800000,
    parameter K3_C1_W7 = 32'h00000000,
    parameter K3_C1_W8 = 32'hbf800000,
    parameter K3_C2_W0 = 32'h3fc00000,
    parameter K3_C2_W1 = 32'h3f800000,
    parameter K3_C2_W2 = 32'h00000000,
    parameter K3_C2_W3 = 32'h3f800000,
    parameter K3_C2_W4 = 32'h00000000,
    parameter K3_C2_W5 = 32'hbf800000,
    parameter K3_C2_W6 = 32'h00000000,
    parameter K3_C2_W7 = 32'hbf800000,
    parameter K3_C2_W8 = 32'hbfc00000,
    parameter K3_BIAS  = 32'h0,

    parameter K4_C0_W0 = 32'h3f800000,
    parameter K4_C0_W1 = 32'h3f8ccccd,
    parameter K4_C0_W2 = 32'h3f800000,
    parameter K4_C0_W3 = 32'h00000000,
    parameter K4_C0_W4 = 32'h00000000,
    parameter K4_C0_W5 = 32'h00000000,
    parameter K4_C0_W6 = 32'hbf800000,
    parameter K4_C0_W7 = 32'hbf8ccccd,
    parameter K4_C0_W8 = 32'hbf800000,
    parameter K4_C1_W0 = 32'h3f800000,
    parameter K4_C1_W1 = 32'h00000000,
    parameter K4_C1_W2 = 32'hbf800000,
    parameter K4_C1_W3 = 32'h40000000,
    parameter K4_C1_W4 = 32'h00000000,
    parameter K4_C1_W5 = 32'hc0000000,
    parameter K4_C1_W6 = 32'h3f800000,
    parameter K4_C1_W7 = 32'h00000000,
    parameter K4_C1_W8 = 32'hbf800000,
    parameter K4_C2_W0 = 32'h3fc00000,
    parameter K4_C2_W1 = 32'h3f800000,
    parameter K4_C2_W2 = 32'h00000000,
    parameter K4_C2_W3 = 32'h3f800000,
    parameter K4_C2_W4 = 32'h00000000,
    parameter K4_C2_W5 = 32'hbf800000,
    parameter K4_C2_W6 = 32'h00000000,
    parameter K4_C2_W7 = 32'hbf800000,
    parameter K4_C2_W8 = 32'hbfc00000,
    parameter K4_BIAS  = 32'h0,

    parameter K5_C0_W0 = 32'h3f800000,
    parameter K5_C0_W1 = 32'h3f8ccccd,
    parameter K5_C0_W2 = 32'h3f800000,
    parameter K5_C0_W3 = 32'h00000000,
    parameter K5_C0_W4 = 32'h00000000,
    parameter K5_C0_W5 = 32'h00000000,
    parameter K5_C0_W6 = 32'hbf800000,
    parameter K5_C0_W7 = 32'hbf8ccccd,
    parameter K5_C0_W8 = 32'hbf800000,
    parameter K5_C1_W0 = 32'h3f800000,
    parameter K5_C1_W1 = 32'h00000000,
    parameter K5_C1_W2 = 32'hbf800000,
    parameter K5_C1_W3 = 32'h40000000,
    parameter K5_C1_W4 = 32'h00000000,
    parameter K5_C1_W5 = 32'hc0000000,
    parameter K5_C1_W6 = 32'h3f800000,
    parameter K5_C1_W7 = 32'h00000000,
    parameter K5_C1_W8 = 32'hbf800000,
    parameter K5_C2_W0 = 32'h3fc00000,
    parameter K5_C2_W1 = 32'h3f800000,
    parameter K5_C2_W2 = 32'h00000000,
    parameter K5_C2_W3 = 32'h3f800000,
    parameter K5_C2_W4 = 32'h00000000,
    parameter K5_C2_W5 = 32'hbf800000,
    parameter K5_C2_W6 = 32'h00000000,
    parameter K5_C2_W7 = 32'hbf800000,
    parameter K5_C2_W8 = 32'hbfc00000,
    parameter K5_BIAS  = 32'h0,

    parameter K6_C0_W0 = 32'h3f800000,
    parameter K6_C0_W1 = 32'h3f8ccccd,
    parameter K6_C0_W2 = 32'h3f800000,
    parameter K6_C0_W3 = 32'h00000000,
    parameter K6_C0_W4 = 32'h00000000,
    parameter K6_C0_W5 = 32'h00000000,
    parameter K6_C0_W6 = 32'hbf800000,
    parameter K6_C0_W7 = 32'hbf8ccccd,
    parameter K6_C0_W8 = 32'hbf800000,
    parameter K6_C1_W0 = 32'h3f800000,
    parameter K6_C1_W1 = 32'h00000000,
    parameter K6_C1_W2 = 32'hbf800000,
    parameter K6_C1_W3 = 32'h40000000,
    parameter K6_C1_W4 = 32'h00000000,
    parameter K6_C1_W5 = 32'hc0000000,
    parameter K6_C1_W6 = 32'h3f800000,
    parameter K6_C1_W7 = 32'h00000000,
    parameter K6_C1_W8 = 32'hbf800000,
    parameter K6_C2_W0 = 32'h3fc00000,
    parameter K6_C2_W1 = 32'h3f800000,
    parameter K6_C2_W2 = 32'h00000000,
    parameter K6_C2_W3 = 32'h3f800000,
    parameter K6_C2_W4 = 32'h00000000,
    parameter K6_C2_W5 = 32'hbf800000,
    parameter K6_C2_W6 = 32'h00000000,
    parameter K6_C2_W7 = 32'hbf800000,
    parameter K6_C2_W8 = 32'hbfc00000,
    parameter K6_BIAS  = 32'h0,

    parameter K7_C0_W0 = 32'h3f800000,
    parameter K7_C0_W1 = 32'h3f8ccccd,
    parameter K7_C0_W2 = 32'h3f800000,
    parameter K7_C0_W3 = 32'h00000000,
    parameter K7_C0_W4 = 32'h00000000,
    parameter K7_C0_W5 = 32'h00000000,
    parameter K7_C0_W6 = 32'hbf800000,
    parameter K7_C0_W7 = 32'hbf8ccccd,
    parameter K7_C0_W8 = 32'hbf800000,
    parameter K7_C1_W0 = 32'h3f800000,
    parameter K7_C1_W1 = 32'h00000000,
    parameter K7_C1_W2 = 32'hbf800000,
    parameter K7_C1_W3 = 32'h40000000,
    parameter K7_C1_W4 = 32'h00000000,
    parameter K7_C1_W5 = 32'hc0000000,
    parameter K7_C1_W6 = 32'h3f800000,
    parameter K7_C1_W7 = 32'h00000000,
    parameter K7_C1_W8 = 32'hbf800000,
    parameter K7_C2_W0 = 32'h3fc00000,
    parameter K7_C2_W1 = 32'h3f800000,
    parameter K7_C2_W2 = 32'h00000000,
    parameter K7_C2_W3 = 32'h3f800000,
    parameter K7_C2_W4 = 32'h00000000,
    parameter K7_C2_W5 = 32'hbf800000,
    parameter K7_C2_W6 = 32'h00000000,
    parameter K7_C2_W7 = 32'hbf800000,
    parameter K7_C2_W8 = 32'hbfc00000,
    parameter K7_BIAS  = 32'h0
    )
    (
    input     wire            clk,
    input     wire            resetn,
    input     wire            data_valid_in,
    input     wire   [DATA_WIDTH-1:0]    data_in0,
    input     wire   [DATA_WIDTH-1:0]    data_in1,
    input     wire   [DATA_WIDTH-1:0]    data_in2,
    // input     wire            load_kernel,
    // input     wire   [31:0]   kernel,
    
    output     wire   [DATA_WIDTH-1:0]    data_out_conv0,
    output     wire   [DATA_WIDTH-1:0]    data_out_conv1,
    output     wire   [DATA_WIDTH-1:0]    data_out_conv2,
    output     wire   [DATA_WIDTH-1:0]    data_out_conv3,
    output     wire   [DATA_WIDTH-1:0]    data_out_conv4,
    output     wire   [DATA_WIDTH-1:0]    data_out_conv5,
    output     wire   [DATA_WIDTH-1:0]    data_out_conv6,
    output     wire   [DATA_WIDTH-1:0]    data_out_conv7,

    output     valid_out_pixel, // bi tat sau W*H - (W-2)*(H-2)
    output reg done_img
	// output load_kernel_done
    );

    reg [31:0] counter;
    wire valid_out_conv0, valid_out_conv1, valid_out_conv2, valid_out_conv3, valid_out_conv4, valid_out_conv5, valid_out_conv6, valid_out_conv7; 
	wire done_conv_0, done_conv_1, done_conv_2, done_conv_3, done_conv_4, done_conv_5, done_conv_6, done_conv_7; 

    // reg [31:0] counter_kernel;
    
    // always @ (posedge clk or negedge resetn)begin
    //     if(resetn == 0) counter_kernel <= 0;
    //     else if (load_kernel == 1'b1) begin
    //         if(counter_kernel > SIZE*SIZE*CHANNEL*NUM_KERNEL + NUM_KERNEL) counter_kernel <= counter_kernel;
    //         else counter_kernel <= counter_kernel + 1;
    //     end
    //     else counter_kernel <= counter_kernel;
    // end

    // wire load_kernel0,load_kernel1,load_kernel2,load_kernel3,load_kernel4,load_kernel5,load_kernel6,load_kernel7;
    // // reg load_bias;
    // // reg [31:0] bias;

    // assign load_kernel0 = ((counter_kernel >= 0 & counter_kernel < 28) & load_kernel == 1'b1)?1'b1:1'b0;
    // assign load_kernel1 = ((counter_kernel >= 28 & counter_kernel < 56) & load_kernel == 1'b1)?1'b1:1'b0;
    // assign load_kernel2 = ((counter_kernel >= 56 & counter_kernel < 84) & load_kernel == 1'b1)?1'b1:1'b0;
    // assign load_kernel3 = ((counter_kernel >= 84 & counter_kernel < 112) & load_kernel == 1'b1)?1'b1:1'b0;
    // assign load_kernel4 = ((counter_kernel >= 112 & counter_kernel < 140) & load_kernel == 1'b1)?1'b1:1'b0;
    // assign load_kernel5 = ((counter_kernel >= 140 & counter_kernel < 168) & load_kernel == 1'b1)?1'b1:1'b0;
    // assign load_kernel6 = ((counter_kernel >= 168 & counter_kernel < 196) & load_kernel == 1'b1)?1'b1:1'b0;
    // assign load_kernel7 = ((counter_kernel >= 196 & counter_kernel < 224) & load_kernel == 1'b1)?1'b1:1'b0;

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
		conv1_0(
		clk,
		resetn,
		data_valid_in,
		data_in0,
        data_in1,
        data_in2,
		// load_kernel0,
		// kernel,            
		data_out_conv0,
		valid_out_conv0,
		done_conv_0
		// load_kernel_done_0
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
		conv1_1(
		clk,
		resetn,
		data_valid_in,
		data_in0,
        data_in1,
        data_in2,
		// load_kernel1,
		// kernel,            
		data_out_conv1,
		valid_out_conv1,
		done_conv_1
		// load_kernel_done_1
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
		conv1_2(
		clk,
		resetn,
		data_valid_in,
		data_in0,
        data_in1,
        data_in2,
		// load_kernel2,
		// kernel,            
		data_out_conv2,
		valid_out_conv2,
		done_conv_2
		// load_kernel_done_2
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
		conv1_3(
		clk,
		resetn,
		data_valid_in,
		data_in0,
        data_in1,
        data_in2,
		// load_kernel3,
		// kernel,            
		data_out_conv3,
		valid_out_conv3,
		done_conv_3
		// load_kernel_done_3
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
		conv1_4(
		clk,
		resetn,
		data_valid_in,
		data_in0,
        data_in1,
        data_in2,
		// load_kernel4,
		// kernel,            
		data_out_conv4,
		valid_out_conv4,
		done_conv_4
		// load_kernel_done_4
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
		conv1_5(
		clk,
		resetn,
		data_valid_in,
		data_in0,
        data_in1,
        data_in2,
		// load_kernel5,
		// kernel,            
		data_out_conv5,
		valid_out_conv5,
		done_conv_5
		// load_kernel_done_5
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
		conv1_6(
		clk,
		resetn,
		data_valid_in,
		data_in0,
        data_in1,
        data_in2,
		// load_kernel6,
		// kernel,            
		data_out_conv6,
		valid_out_conv6,
		done_conv_6
		// load_kernel_done_6
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
		conv1_7(
		clk,
		resetn,
		data_valid_in,
		data_in0,
        data_in1,
        data_in2,
		// load_kernel7,
		// kernel,            
		data_out_conv7,
		valid_out_conv7,
		done_conv_7
		// load_kernel_done_7
		);

    assign valid_out_pixel = valid_out_conv7;
    // assign load_kernel_done = load_kernel_done_7;

    always @ (posedge clk or negedge resetn) 
    begin
        if(resetn == 1'b0) 
            counter <= 0;
        else 
            if (done_img == 1'b1) begin
                counter <= 0;
            end
            else 
                if(valid_out_pixel == 1'b1) 
                begin
                    if(counter == (IMG_WIDTH)*(IMG_HEIGHT) -1 ) 
                        counter <= 0;
                    else 
                        counter <= counter + 1;
                end
                else 
                    counter <= counter;
    end

    always @ (posedge clk or negedge resetn) 
    begin
        if(resetn == 1'b0) 
            done_img <= 0;
        else 
            if(counter == (IMG_WIDTH)*(IMG_HEIGHT) -2) 
                done_img <= (valid_out_pixel)?1'b1:1'b0;
            else 
                done_img <= 0;
    end

endmodule