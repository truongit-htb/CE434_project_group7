`ifndef LINEBUFFER_INCLUDED
    `include "line_buffer.v"
    `define LINEBUFFER_INCLUDED
`endif
`ifndef FPMULT_INCLUDED
    // `include "FP_multiplier.v"
    `include "FP_Top_Mult.v"
    `define FPMULT_INCLUDED
`endif
`ifndef FPADD_INCLUDED
    // `include "fpadd.v"
    `include "FP_Top_AddSub.v"
    `define FPADD_INCLUDED
`endif
`ifndef DELAY_CLOCK_INCLUDED
    `include "delay_clock.v"
    `define DELAY_CLOCK_INCLUDED
`endif
`ifndef DELAY_VALID_INCLUDED
    `include "delay_valid.v"
    `define DELAY_VALID_INCLUDED
`endif
module full_connected_16 # (
		parameter WIDTH = 4, // after maxpool
		parameter HEIGHT = 4 // after maxpool
		)
	(
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
	input clk;
	input resetn;
	// input ack;
	input load_weight;
	//input load_bias;
	input valid_in;
	input [31:0] data_in;
	input [31:0] weight;
	// input [31:0] bias;
	output [31:0] feature;
	output valid_out;
	output load_weight_done;
	//output load_bias_done;

	localparam NUM_OPERANDs = WIDTH*HEIGHT+1;
	localparam STAGES = 5; 
	localparam NUM_DELAY = 4; 


	wire enable_2;
	function integer clogb2;
   input [31:0] value;
   integer 	i;
   begin
      clogb2 = 0;
      for(i = 0; 2**i < value; i = i + 1)
	clogb2 = i + 1;
   end
endfunction
  localparam COUNTER_WIDTH = clogb2(WIDTH*HEIGHT+1);
	reg [COUNTER_WIDTH-1:0] counter,counter_1,counter_2;
	output reg full;
	//reg load_bias_done;
	reg load_weight_done;
	//reg [31:0] biasR;
	reg [31:0] tmp [WIDTH*HEIGHT:0];
	wire [31:0] product [0:WIDTH*HEIGHT-1];
	output wire valid_out_mult;
	//wire [31:0] biasW;

	//assign biasW = biasR;
	
	//wire [31:0] in_buffer;
	//reg [31:0] counter_top;
// 	/*
// 	always @(posedge clk or negedge resetn) begin
// 		if (resetn == 1'b0) counter_top <= 0;
// 		else begin																	//
//         if(ack == 1'b1) counter_top <= 32'd50 + 32'd168 + 32'd48;
// 				else if (valid_in == 1'b1) counter_top <= 32'b1;
// 		    else if(valid_in == 1'b0) begin
// 			    if(counter_top == 32'b0) counter_top <= 0;
// 			    else counter_top <= counter_top - 32'b1;
// 		    end
//         end
// 		//else counter_out <= counter_out;
// 	end

//     always @(posedge clk or negedge resetn) begin
// 		if (resetn == 1'b0) enable <= 1'b0;
// 		else if(counter_top > 0) enable <= 1'b1;
// 		else enable <= 1'b0;
//     end
// 	*/
// 	//assign enable = valid_in | enable_2;
	
//   /*
//   always @(posedge clk or negedge resetn) begin
// 		if (resetn == 1'b0) counter_top <= 0;
// 		else if(valid_in == 1'b1) counter_top <= 32'd51;
//     else if (valid_in == 1'b0) begin
//           if(counter_top == 32'b0) counter_top <= 0;
// 			    else counter_top <= counter_top - 32'b1;
//     end
//   end

// 	assign enable = (counter_top > 0 | valid_in == 1'b1)?1'b1:1'b0;
// 	/*
//     always @(posedge clk or negedge resetn) begin
// 		if (resetn == 1'b0) enable_2 <= 1'b0;
// 		else if(counter_top > 0) enable_2 <= 1'b1;
// 		else enable_2 <= 1'b0;
//     end
// 	*/
	// always @ (posedge clk or negedge resetn)begin
    //     if (resetn == 1'b0) begin 
	// 		  biasR <= 0;
    //           load_bias_done <= 0;
    //     end
	// 	    else if (resetn == 1'b1) begin
    //       if (load_bias == 1'b1) begin  
    //           biasR <= bias;
    //           load_bias_done <= 1'b1;
    //         end
    //       else if (load_bias == 1'b0) begin
    //           biasR <= biasR;
    //           load_bias_done <= load_bias_done;
    //       end
	// 	    end
    // end
	
	//generate function
	//assign in_buffer = (relapse)?tmp[168]:weight;
	genvar i;
	/*
	generate
	for (i = 0; i < 255; i=i+1) begin
		if(i == 0) nbit_dff #(32) nbit_dff_ins(clk,resetn,load_weight,weight,tmp[i]);
		else if (i < 169) nbit_dff#(32) nbit_dff_ins(clk,resetn,load_weight,tmp[i-1],tmp[i]);
		else nbit_dff#(32) nbit_dff_ins(clk,resetn,load_weight,32'b0,tmp[i]);
	end
	endgenerate
	*/
	// generate
	// for (i = WIDTH*HEIGHT; i >= 0; i=i-1) begin
	// 	//if(i > 168) nbit_dff#(32) nbit_dff_ins(clk,resetn,load_weight,32'b0,tmp[i]);
	// 	if (i == WIDTH*HEIGHT) nbit_dff#(32) nbit_dff_ins(clk,resetn,load_weight,weight,tmp[i]);
	// 	else nbit_dff#(32) nbit_dff_ins(clk,resetn,load_weight,tmp[i+1],tmp[i]);
	// end
	// endgenerate
	always @(posedge clk)
      if (load_weight)
        tmp[counter] <= weight;
	always @ (posedge clk or negedge resetn) begin
		if(resetn == 1'b0) begin
			counter <= 32'b0;
		end
		else if (load_weight == 1'b1) begin
			counter <= counter + 1;
		end
		else if (load_weight == 1'b0) begin
			counter <= counter;
		end
	end
	always @ (posedge clk or negedge resetn) begin
		if(resetn == 1'b0) begin
			load_weight_done <= 1'b0;
		end
		else if (counter == WIDTH*HEIGHT) begin
			load_weight_done <= 1'b1;
		end
		else begin
			load_weight_done <= load_weight_done;
		end
	end

	// /*
	// wire [31:0] decode_1 [0:63];
	// generate
	// for (i = 0; i < 256; i=i+4) begin
	// 	mux41 #(32) mux_1(tmp[i],tmp[i+1],tmp[i+2],tmp[i+3],counter_1[1:0],decode_1[i>>2]);
	// end
	// endgenerate
	
	// wire [31:0] decode_2 [0:15];
	// generate
	// for (i = 0; i < 64; i=i+4) begin
	// 	mux41 #(32) mux_2(decode_1[i],decode_1[i+1],decode_1[i+2],decode_1[i+3],counter_1[3:2],decode_2[i>>2]);
	// end
	// endgenerate
	
	// wire [31:0] decode_3 [0:3];
	// generate
	// for (i = 0; i < 16; i=i+4) begin
	// 	mux41 #(32) mux_3(decode_2[i],decode_2[i+1],decode_2[i+2],decode_2[i+3],counter_1[5:4],decode_3[i>>2]);
	// end
	// endgenerate
	
	// wire [31:0] decode_4;
	// mux41 #(32) mux_4(decode_3[0],decode_3[1],decode_3[2],decode_3[3],counter_1[7:6],decode_4);
	// */

	wire [31:0] result;
	
	//wire [31:0] temp1,temp2;
	//wire [31:0] in1,in2;
	//delay_clock #(.DATA_WIDTH(32),.N_CLOCKs(48)) check_1(clk,resetn,1'b1,tmp[counter_1],temp1);
	//delay_clock #(.DATA_WIDTH(32),.N_CLOCKs(48)) check_2(clk,resetn,1'b1,data_in,temp2);
	//assign in1=(valid_out_mult)?temp1:32'b0;
	//assign in2=(valid_out_mult)?temp2:32'b0;
// 	`ifdef XILINX
// 	floating_point_mult mult_weight (
//   .aclk(clk),                                  // input wire aclk
//   .aresetn(resetn),                            // input wire aresetn
//   .s_axis_a_tvalid(valid_in),            // input wire s_axis_a_tvalid
//   .s_axis_a_tdata(data_in),              // input wire [31 : 0] s_axis_a_tdata
//   .s_axis_b_tvalid(valid_in),            // input wire s_axis_b_tvalid
//   .s_axis_b_tdata(tmp[counter_1]),              // input wire [31 : 0] s_axis_b_tdata
//   .m_axis_result_tvalid(valid_out_mult),  // output wire m_axis_result_tvalid
//   .m_axis_result_tdata(result)    // output wire [31 : 0] m_axis_result_tdata
// );
// `else
	// FP_multiplier mult_weight(clk,resetn,valid_in,data_in,tmp[counter_1],result,valid_out_mult);
	// `endif
	FP_Top_Mult mult_weight(clk,resetn,valid_in,data_in,tmp[counter_1],result,valid_out_mult);
	generate
	for (i = 0; i < WIDTH*HEIGHT; i=i+1) begin
		if(i == 0) nbit_dff #(32) nbit_dff_ins_result_mult(clk,resetn,valid_out_mult,result,product[i]);
		else nbit_dff#(32) nbit_dff_ins_result_mul(clk,resetn,valid_out_mult,product[i-1],product[i]);
	end
	endgenerate
	
	always @ (posedge clk or negedge resetn) begin
		if(resetn == 1'b0) begin
			counter_1 <= 10'b0;
		end
		else if (valid_in == 1'b1) begin
			if(counter_1 == WIDTH*HEIGHT - 1) counter_1 <= 0; //0 to 15
			else counter_1 <= counter_1 + 10'b1;
			
		end
		else if (valid_in == 1'b0) begin
			counter_1 <= counter_1;
		end
	end
	// /*
	// always @ (posedge clk or negedge resetn) begin
	// 	if(resetn == 1'b0) begin
	// 		relapse <= 1'b0;
	// 	end
	// 	else if (counter_1 == WIDTH*HEIGHT -1) begin
	// 		relapse <= 1'b1;
	// 	end
	// 	else begin
	// 		relapse <= relapse;
	// 	end
	// end
	// */
	always @ (posedge clk or negedge resetn) begin
		if(resetn == 1'b0) begin
			counter_2 <= 10'b0;
		end
		else if (valid_out_mult == 1'b1) begin
			if(counter_2 == WIDTH*HEIGHT-1) counter_2 <= 0;
			else counter_2 <= counter_2 + 10'b1;
			
		end
		else if (valid_out_mult == 1'b0) begin
			counter_2 <= counter_2;
		end
	end
	//assign full = (counter_2 == WIDTH*HEIGHT -1)?1'b1:1'b0;
	
	always @ (posedge clk or negedge resetn) begin
		if(resetn == 1'b0) begin
			full <= 1'b0;
		end
		else if(full == 1'b1) full <= 1'b0;
		else if (counter_2 == WIDTH*HEIGHT-1) begin
			if(valid_out_mult==1'b1)
				full <= 1'b1;
			else full <= 1'b0;
		end
		else begin
			full <= 1'b0;
		end
	end
	
	reg [31:0] counter_top_2;
	always @(posedge clk or negedge resetn) begin
		if (resetn == 1'b0) counter_top_2 <= 0;
		else if(full == 1'b1) counter_top_2 <= STAGES * 6 ; //8*6
    else if (full == 1'b0) begin
          if(counter_top_2 == 32'b0) counter_top_2 <= 0;
			    else counter_top_2 <= counter_top_2 - 32'b1;
    end
  end
	assign enable_2 = (counter_top_2 > 0 | full == 1'b1)?1'b1:1'b0;
	
	wire [31:0] add_this [0:NUM_OPERANDs-1];
	generate
	for (i = 0; i < NUM_OPERANDs; i=i+1) 
	 begin :assign_addthis
		//j=j+1;
		if(i == NUM_OPERANDs -1 ) assign add_this[i]=tmp[WIDTH*HEIGHT];
		else assign add_this[i] = product[i];
	end
	endgenerate
	
	
//////////////////////
	wire [NUM_OPERANDs-2:0] valid_in_add;
	wire [NUM_OPERANDs-2:0] valid_out_add;
	wire [31:0] output_add [0:NUM_OPERANDs-2];
	wire [31:0] op_1 [0:NUM_OPERANDs-2];
	wire [31:0] op_2 [0:NUM_OPERANDs-2];

	generate
	for (i = 0; i < NUM_OPERANDs-1; i=i+1) 
	 begin :initial_adders // needs (NUM_OPERANDs - 1) adders
		//j=j+1;
		
		
// // 		`ifdef XILINX
// // 		floating_point_add fp_adders (
// //   .aclk(clk),                                  // input wire aclk
// //   .aresetn(resetn),                            // input wire aresetn
// //   .s_axis_a_tvalid(valid_in_add[i]),            // input wire s_axis_a_tvalid
// //   .s_axis_a_tdata(op_1[i]),              // input wire [31 : 0] s_axis_a_tdata
// //   .s_axis_b_tvalid(valid_in_add[i]),            // input wire s_axis_b_tvalid
// //   .s_axis_b_tdata(op_2[i]),              // input wire [31 : 0] s_axis_b_tdata
// //   .m_axis_result_tvalid(valid_out_add[i]),  // output wire m_axis_result_tvalid
// //   .m_axis_result_tdata(output_add[i])    // output wire [31 : 0] m_axis_result_tdata
// // );
// 	`else
// 	fpadd fp_adders(clk,resetn,valid_in_add[i],op_1[i],op_2[i],output_add[i],valid_out_add[i]);
// 	`endif
	FP_Top_AddSub fp_adders(clk,resetn,valid_in_add[i],op_1[i],op_2[i],output_add[i],valid_out_add[i]);
	end
	endgenerate


	wire [31:0] in_delay [0:NUM_DELAY-1];
wire [31:0] out_delay [0:NUM_DELAY-1];
generate 
	for (i = 0; i < NUM_DELAY; i=i+1) 
	begin :delay_clocksssss
	//  `ifdef XILINX
	// 	delay_clock #(.DATA_WIDTH(32),.N_CLOCKs(`XILINX_ADDER_LATENCY)) delay_xxx(clk,resetn,enable_2,in_delay[i],out_delay[i]);
	// 	`else
	// 	delay_clock #(.DATA_WIDTH(32),.N_CLOCKs(`ADDER_LATENCY)) delay_xxx(clk,resetn,enable_2,in_delay[i],out_delay[i]);
	// 	`endif
	delay_clock #(.DATA_WIDTH(32),.N_CLOCKs(4)) delay_xxx(clk,resetn,enable_2,in_delay[i],out_delay[i]);
	end
endgenerate
assign op_1[0] = add_this[0];
assign op_2[0] = add_this[1];
assign valid_in_add[0] = full;
assign op_1[1] = add_this[2];
assign op_2[1] = add_this[3];
assign valid_in_add[1] = full;
assign op_1[2] = add_this[4];
assign op_2[2] = add_this[5];
assign valid_in_add[2] = full;
assign op_1[3] = add_this[6];
assign op_2[3] = add_this[7];
assign valid_in_add[3] = full;
assign op_1[4] = add_this[8];
assign op_2[4] = add_this[9];
assign valid_in_add[4] = full;
assign op_1[5] = add_this[10];
assign op_2[5] = add_this[11];
assign valid_in_add[5] = full;
assign op_1[6] = add_this[12];
assign op_2[6] = add_this[13];
assign valid_in_add[6] = full;
assign op_1[7] = add_this[14];
assign op_2[7] = add_this[15];
assign valid_in_add[7] = full;
assign in_delay[0] = add_this[16];
assign op_1[8] = output_add[0];
assign op_2[8] = output_add[1];
assign valid_in_add[8] = valid_out_add[1];
assign op_1[9] = output_add[2];
assign op_2[9] = output_add[3];
assign valid_in_add[9] = valid_out_add[3];
assign op_1[10] = output_add[4];
assign op_2[10] = output_add[5];
assign valid_in_add[10] = valid_out_add[5];
assign op_1[11] = output_add[6];
assign op_2[11] = output_add[7];
assign valid_in_add[11] = valid_out_add[7];
assign in_delay[1] = out_delay[0];
assign op_1[12] = output_add[8];
assign op_2[12] = output_add[9];
assign valid_in_add[12] = valid_out_add[9];
assign op_1[13] = output_add[10];
assign op_2[13] = output_add[11];
assign valid_in_add[13] = valid_out_add[11];
assign in_delay[2] = out_delay[1];
assign op_1[14] = output_add[12];
assign op_2[14] = output_add[13];
assign valid_in_add[14] = valid_out_add[13];
assign in_delay[3] = out_delay[2];
assign op_1[15] = output_add[14];
assign op_2[15] = out_delay[3];
assign valid_in_add[15] = valid_out_add[14];


	//assign valid_out = valid_out_add[NUM_OPERANDs-2];
	//assign feature = output_add[NUM_OPERANDs-2];
	wire valid_out_0;
	wire [31:0] feature_0;
	dff valid_out_delay_inst (clk, resetn, 1'b1, valid_out_add[NUM_OPERANDs-2],valid_out_0);
	nbit_dff #(32) data_delay_inst (clk, resetn, valid_out_add[NUM_OPERANDs-2], output_add[NUM_OPERANDs-2],feature_0);
	FP_Top_AddSub add_bias (clk, resetn, valid_out_0, feature_0, tmp[16], feature, valid_out);
// /*
// 	exponential expo_ins(
// 						clk,
// 						resetn,
// 						enable,
// 						valid_add_8,
// 						stage8,
// 						feature,
// 						valid_out
// 						);
// 	*/
	
endmodule