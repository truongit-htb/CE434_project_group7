`include "conv3d_kernel_{{n_channel}}_channel_size_3.v"

module conv3d_{{n_kernel}}_kernel_{{n_channel}}_channel_size_3 #(
	parameter DATA_WIDTH = 32,
    parameter IMG_WIDTH = 56,
    parameter IMG_HEIGHT = 56,
    parameter CHANNEL = {{n_channel}},
    parameter NUM_KERNEL = {{n_kernel}},

    // Kx_Cy_Wz = KERNELx_CHANNELy_WEIGHTz
    {{param_weight_bias}}
    )
    (
    {{port}}
    );

    // reg [31:0] counter;
    wire [NUM_KERNEL-1:0] valid_out_conv;
	wire [NUM_KERNEL-1:0] done_conv; 

    {{conv}}


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