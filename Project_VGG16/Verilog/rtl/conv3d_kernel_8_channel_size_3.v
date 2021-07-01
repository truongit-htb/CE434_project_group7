`ifndef CONV_2D_KERNEL_SIZE_3_INCLUDED
  `include "conv2d_kernel_size_3.v"
  `define CONV_2D_KERNEL_SIZE_3_INCLUDED
`endif

module conv3d_kernel_8_channel_size_3 #(
  parameter DATA_WIDTH = 32,
  parameter IMG_WIDTH = 56,
  parameter IMG_HEIGHT = 56,
  parameter SIZE = 3,
  parameter CHANNEL = 8
  )
  (
    input     wire            clk,
    input     wire            resetn,
    // input     wire            eof,
    input     wire            data_valid_in,
    input     wire   [DATA_WIDTH-1:0]    data_in0,
input     wire   [DATA_WIDTH-1:0]    data_in1,
input     wire   [DATA_WIDTH-1:0]    data_in2,
input     wire   [DATA_WIDTH-1:0]    data_in3,
input     wire   [DATA_WIDTH-1:0]    data_in4,
input     wire   [DATA_WIDTH-1:0]    data_in5,
input     wire   [DATA_WIDTH-1:0]    data_in6,
input     wire   [DATA_WIDTH-1:0]    data_in7,

    // input     wire   [DATA_WIDTH-1:0]    data_in,
    input     wire            load_kernel,
    input     wire   [31:0]   kernel,
    //input     wire            enable_cvt,
    
    output    wire   [31:0]    data_out,
    output     valid_out_pixel, // bi tat sau W*H - (W-2)*(H-2)
    output reg done_img,
	output reg load_kernel_done
  );
    localparam NUM_OPERANDs = CHANNEL+1;
    localparam NUM_DELAY = 0;
    
    reg [31:0] counter_kernel;
    always @ (posedge clk or negedge resetn)begin
      if(resetn == 0) counter_kernel <= 0;
      else if (load_kernel == 1'b1) begin
        if(counter_kernel > SIZE*SIZE*CHANNEL+CHANNEL) counter_kernel <= counter_kernel;
        else counter_kernel <= counter_kernel + 1;
      end
      else counter_kernel <= counter_kernel;
    end

    wire load_kernel0,load_kernel1,load_kernel2,load_kernel3,load_kernel4,load_kernel5,load_kernel6,load_kernel7;
    wire load_bias;
    reg [31:0] bias;
    reg [31:0] counter;

    wire [31:0] data_out_conv_kernel [0:CHANNEL-1];

    assign load_kernel0 = ((counter_kernel >= 0 & counter_kernel < 10) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel1 = ((counter_kernel >= 10 & counter_kernel < 20) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel2 = ((counter_kernel >= 20 & counter_kernel < 30) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel3 = ((counter_kernel >= 30 & counter_kernel < 40) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel4 = ((counter_kernel >= 40 & counter_kernel < 50) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel5 = ((counter_kernel >= 50 & counter_kernel < 60) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel6 = ((counter_kernel >= 60 & counter_kernel < 70) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_kernel7 = ((counter_kernel >= 70 & counter_kernel < 80) & load_kernel == 1'b1)?1'b1:1'b0;
assign load_bias = (counter_kernel == 80 & load_kernel == 1'b1)?1'b1:1'b0;


    // always @ (posedge clk or negedge resetn) begin
    //   if(resetn == 0) begin
    //     <load_kernel_resetn>load_bias <= 1'b0;
    //   end
    //   else
    //   <load_kernel>
    //   if(counter_kernel == SIZE*SIZE*CHANNEL) begin
    //   <load_kernel_resetn>load_bias <= 1'b1;

    //   end else begin
    //   <load_kernel_resetn>load_bias <= 1'b0;
    //   end
    // end
    always @(posedge clk or negedge resetn) begin
      if(resetn == 0)begin
        load_kernel_done <=0;
        bias <= 0;
      end
      else if(load_bias == 1'b1)begin
        load_kernel_done <=load_bias;
        bias <= kernel;
        end
      else begin
        load_kernel_done <=load_bias;
        bias <= bias;
      end
    end

    conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT)
		)
		conv2_0(
		clk,
		resetn,
		data_vaid_in,
		data_in0,             
		load_kernel0,
		kernel,            
		data_out_conv_kernel[0],
		valid_out_conv_kernel_0,
		done_conv_0,
		load_kernel_done_0
		);
conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT)
		)
		conv2_1(
		clk,
		resetn,
		data_vaid_in,
		data_in1,             
		load_kernel1,
		kernel,            
		data_out_conv_kernel[1],
		valid_out_conv_kernel_1,
		done_conv_1,
		load_kernel_done_1
		);
conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT)
		)
		conv2_2(
		clk,
		resetn,
		data_vaid_in,
		data_in2,             
		load_kernel2,
		kernel,            
		data_out_conv_kernel[2],
		valid_out_conv_kernel_2,
		done_conv_2,
		load_kernel_done_2
		);
conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT)
		)
		conv2_3(
		clk,
		resetn,
		data_vaid_in,
		data_in3,             
		load_kernel3,
		kernel,            
		data_out_conv_kernel[3],
		valid_out_conv_kernel_3,
		done_conv_3,
		load_kernel_done_3
		);
conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT)
		)
		conv2_4(
		clk,
		resetn,
		data_vaid_in,
		data_in4,             
		load_kernel4,
		kernel,            
		data_out_conv_kernel[4],
		valid_out_conv_kernel_4,
		done_conv_4,
		load_kernel_done_4
		);
conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT)
		)
		conv2_5(
		clk,
		resetn,
		data_vaid_in,
		data_in5,             
		load_kernel5,
		kernel,            
		data_out_conv_kernel[5],
		valid_out_conv_kernel_5,
		done_conv_5,
		load_kernel_done_5
		);
conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT)
		)
		conv2_6(
		clk,
		resetn,
		data_vaid_in,
		data_in6,             
		load_kernel6,
		kernel,            
		data_out_conv_kernel[6],
		valid_out_conv_kernel_6,
		done_conv_6,
		load_kernel_done_6
		);
conv2d_kernel_size_3 #(
		.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT)
		)
		conv2_7(
		clk,
		resetn,
		data_vaid_in,
		data_in7,             
		load_kernel7,
		kernel,            
		data_out_conv_kernel[7],
		valid_out_conv_kernel_7,
		done_conv_7,
		load_kernel_done_7
		);


  wire [SIZE*SIZE-2:0] valid_in_add;
    wire [SIZE*SIZE-2:0] valid_out_add;
    wire [31:0] output_add [0:SIZE*SIZE-2];
    wire [31:0] op_1 [0:SIZE*SIZE-2];
    wire [31:0] op_2 [0:SIZE*SIZE-2];
genvar i;
    generate
    for (i = 0; i < NUM_OPERANDs-1; i=i+1) 
    begin :initial_adders // needs (NUM_OPERANDs - 1) adders
      //j=j+1;
      fpadd fp_adders(clk,resetn,valid_in_add[i],op_1[i],op_2[i],output_add[i],valid_out_add[i]);
    end
    endgenerate

    wire [31:0] in_delay [0:NUM_DELAY-1];
  wire [31:0] out_delay [0:NUM_DELAY-1];
  generate 
    for (i = 0; i < NUM_DELAY; i=i+1) 
    begin :delay_clocksssss
      delay_clock #(.DATA_WIDTH(32),.N_CLOCKs(6)) delay_xxx(clk,resetn,enable_2,in_delay[i],out_delay[i]);
	end
	endgenerate
    assign op_1[0] =data_out_conv_kernel[0];
assign op_2[0] = data_out_conv_kernel[1];
assign valid_in_add[0] = valid_out_conv_kernel_7;
assign op_1[1] =data_out_conv_kernel[2];
assign op_2[1] = data_out_conv_kernel[3];
assign valid_in_add[1] = valid_out_conv_kernel_7;
assign op_1[2] =data_out_conv_kernel[4];
assign op_2[2] = data_out_conv_kernel[5];
assign valid_in_add[2] = valid_out_conv_kernel_7;
assign op_1[3] =data_out_conv_kernel[6];
assign op_2[3] = data_out_conv_kernel[7];
assign valid_in_add[3] = valid_out_conv_kernel_7;
assign op_1[4] = output_add[0];
assign op_2[4] = output_add[1];
assign valid_in_add[4] = valid_out_add[1];
assign op_1[5] = output_add[2];
assign op_2[5] = output_add[3];
assign valid_in_add[5] = valid_out_add[3];
assign op_1[6] = output_add[4];
assign op_2[6] = output_add[5];
assign valid_in_add[6] = valid_out_add[5];

    wire valid_temp;
    wire [31:0] data_temp;
    assign valid_temp = valid_out_add[NUM_OPERANDs-2];
	assign data_temp = output_add[NUM_OPERANDs-2];

  wire temp_valid;
  fpadd add_bias(clk,resetn,valid_temp,data_temp,bias,data_out,temp_valid);

  assign valid_out_pixel = temp_valid;

  
	
    always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) counter <= 0;
      else if (done_img == 1'b1) begin
        counter <= 0;
      end
      else if(temp_valid == 1'b1) begin
        if(counter == (IMG_WIDTH)*(IMG_HEIGHT) -1 ) counter <= 0;
        else counter <= counter + 1;
      end
      else counter <= counter;
    end
    always @ (posedge clk or negedge resetn) begin
      if(resetn == 1'b0) done_img <= 0;
      else if(counter == (IMG_WIDTH)*(IMG_HEIGHT) -2) done_img <= (temp_valid)?1'b1:1'b0;
      else done_img <= 0;
    end


    //float2int result(clk,resetn,enable,res8,valid_add8,data_out,valid_out_pixel);
    
  

  


  endmodule
