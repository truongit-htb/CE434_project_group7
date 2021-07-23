module tb_generator_3d (
    clk,
    resetn,
    // num_data,
    // fifo write bus
    // fifo_full,
    fifo_data_0,
    fifo_data_1,
    fifo_data_2,
    
    // EXTEND
    fifo_data_3,
    fifo_data_4,
    fifo_data_5,
    fifo_data_6,
    fifo_data_7,

    fifo_data_8,
    fifo_data_9,
    fifo_data_10,
    fifo_data_11,
    fifo_data_12,
    fifo_data_13,
    fifo_data_14,
    fifo_data_15,

    fifo_wrreq
);
    // paramenters
    parameter DWIDTH = 8;
    parameter input_file_0 = "";
    parameter input_file_1 = "";
    parameter input_file_2 = "";
    // EXTEND
    parameter input_file_3 = "";
    parameter input_file_4 = "";
    parameter input_file_5 = "";
    parameter input_file_6 = "";
    parameter input_file_7 = "";

    parameter input_file_8 = "";
    parameter input_file_9 = "";
    parameter input_file_10 = "";
    parameter input_file_11 = "";
    parameter input_file_12 = "";
    parameter input_file_13 = "";
    parameter input_file_14 = "";
    parameter input_file_15 = "";
    //
    parameter WIDTH = 56;
    parameter HEIGHT = 56;
    localparam num_data = WIDTH*HEIGHT;

    //portmap
    input clk;
    input resetn;
    // input fifo_full;
    output [DWIDTH-1:0] fifo_data_0;
    output [DWIDTH-1:0] fifo_data_1;
    output [DWIDTH-1:0] fifo_data_2;
    // EXTEND
    output [DWIDTH-1:0] fifo_data_3;
    output [DWIDTH-1:0] fifo_data_4;
    output [DWIDTH-1:0] fifo_data_5;
    output [DWIDTH-1:0] fifo_data_6;
    output [DWIDTH-1:0] fifo_data_7;

    output [DWIDTH-1:0] fifo_data_8 ;
    output [DWIDTH-1:0] fifo_data_9 ;
    output [DWIDTH-1:0] fifo_data_10;
    output [DWIDTH-1:0] fifo_data_11;
    output [DWIDTH-1:0] fifo_data_12;
    output [DWIDTH-1:0] fifo_data_13;
    output [DWIDTH-1:0] fifo_data_14;
    output [DWIDTH-1:0] fifo_data_15;

    output reg fifo_wrreq;
    // output reg [7:0] num_data;

    integer file_in_0;
    integer file_in_1;
    integer file_in_2; 
    integer  s_data;
    // EXTEND
    integer file_in_3;
    integer file_in_4;
    integer file_in_5;
    integer file_in_6;
    integer file_in_7; 

    integer file_in_8 ;
    integer file_in_9 ;
    integer file_in_10;
    integer file_in_11;
    integer file_in_12;
    integer file_in_13;
    integer file_in_14;
    integer file_in_15;  
    
    initial begin
        file_in_0 <= $fopen(input_file_0,"r"); // Read image file 
        file_in_1 <= $fopen(input_file_1,"r"); // Read image file    
        file_in_2 <= $fopen(input_file_2,"r"); // Read image file    
        // EXTEND
        file_in_3 <= $fopen(input_file_3,"r"); // Read image file 
        file_in_4 <= $fopen(input_file_4,"r"); // Read image file    
        file_in_5 <= $fopen(input_file_5,"r"); // Read image file
        file_in_6 <= $fopen(input_file_6,"r"); // Read image file 
        file_in_7 <= $fopen(input_file_7,"r"); // Read image file 

        file_in_8  <= $fopen(input_file_8 ,"r"); // Read image file 
        file_in_9  <= $fopen(input_file_9 ,"r"); // Read image file    
        file_in_10 <= $fopen(input_file_10,"r"); // Read image file
        file_in_11 <= $fopen(input_file_11,"r"); // Read image file 
        file_in_12 <= $fopen(input_file_12,"r"); // Read image file 
        file_in_13 <= $fopen(input_file_13,"r"); // Read image file 
        file_in_14 <= $fopen(input_file_14,"r"); // Read image file    
        file_in_15 <= $fopen(input_file_15,"r"); // Read image file
    end 

    
    // parameter READ_CFG_STATE = 0;
    // parameter WR_DATA_STATE = 1;
    //
    reg [11:0] data_cnt;
    reg [DWIDTH-1:0] data_channel_0;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_1;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_2;          // dung de doc gia tri pixel tu file
    // EXTEND
    reg [DWIDTH-1:0] data_channel_3;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_4;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_5;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_6;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_7;          // dung de doc gia tri pixel tu file

    reg [DWIDTH-1:0] data_channel_8 ;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_9 ;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_10;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_11;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_12;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_13;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_14;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_15;          // dung de doc gia tri pixel tu file


    reg [DWIDTH-1:0] data_read_0;             // dung de lay data tren cac channel           
    reg [DWIDTH-1:0] data_read_1;             // dung de lay data tren cac channel
    reg [DWIDTH-1:0] data_read_2;             // dung de lay data tren cac channel
    // EXTEND
    reg [DWIDTH-1:0] data_read_3;             // dung de lay data tren cac channel           
    reg [DWIDTH-1:0] data_read_4;             // dung de lay data tren cac channel
    reg [DWIDTH-1:0] data_read_5;             // dung de lay data tren cac channel
    reg [DWIDTH-1:0] data_read_6;             // dung de lay data tren cac channel           
    reg [DWIDTH-1:0] data_read_7;             // dung de lay data tren cac channel

    reg [DWIDTH-1:0] data_read_8 ;             // dung de lay data tren cac channel           
    reg [DWIDTH-1:0] data_read_9 ;             // dung de lay data tren cac channel
    reg [DWIDTH-1:0] data_read_10;             // dung de lay data tren cac channel
    reg [DWIDTH-1:0] data_read_11;             // dung de lay data tren cac channel           
    reg [DWIDTH-1:0] data_read_12;             // dung de lay data tren cac channel
    reg [DWIDTH-1:0] data_read_13;             // dung de lay data tren cac channel           
    reg [DWIDTH-1:0] data_read_14;             // dung de lay data tren cac channel
    reg [DWIDTH-1:0] data_read_15;             // dung de lay data tren cac channel

    // reg [1:0] state;

    //
    assign fifo_data_0 = data_read_0;
    assign fifo_data_1 = data_read_1;
    assign fifo_data_2 = data_read_2;
    // // EXTEND
    assign fifo_data_3 = data_read_3;
    assign fifo_data_4 = data_read_4;
    assign fifo_data_5 = data_read_5;
    assign fifo_data_6 = data_read_6;
    assign fifo_data_7 = data_read_7;

    assign fifo_data_8  = data_read_8 ;
    assign fifo_data_9  = data_read_9 ;
    assign fifo_data_10 = data_read_10;
    assign fifo_data_11 = data_read_11;
    assign fifo_data_12 = data_read_12;
    assign fifo_data_13 = data_read_13;
    assign fifo_data_14 = data_read_14;
    assign fifo_data_15 = data_read_15;


    // // generate random value
    // reg[15:0]a;
    // always @(posedge clk) 
    // begin
    //     a <=$urandom%10; 
    // end
    // wire data_valid_in;
    // // assign data_valid_in = a[3] | a[1];
    assign data_valid_in = 1'b1;


    always @(posedge clk or negedge resetn) begin
        if (resetn == 1'b0) 
        begin
            data_cnt <= 1;
            // data_read <= 0;
            data_read_0 <= 0;
            data_read_1 <= 0;
            data_read_2 <= 0;
            fifo_wrreq <= 0;

            // EXTEND
            data_read_3 <= 0;
            data_read_4 <= 0;
            data_read_5 <= 0;
            data_read_6 <= 0;
            data_read_7 <= 0;

            data_read_8  <= 0;
            data_read_9  <= 0;
            data_read_10 <= 0;
            data_read_11 <= 0;
            data_read_12 <= 0;
            data_read_13 <= 0;
            data_read_14 <= 0;
            data_read_15 <= 0;
        end
        else 
        begin
            if (data_valid_in==1 /* && fifo_full == 0 */) 
            begin
                data_cnt <= data_cnt + 1;
                s_data = $fscanf(file_in_0, "%h", data_channel_0);
                s_data = $fscanf(file_in_1, "%h", data_channel_1);
                s_data = $fscanf(file_in_2, "%h", data_channel_2);
                
                // EXTEND
                s_data = $fscanf(file_in_3, "%h", data_channel_3);
                s_data = $fscanf(file_in_4, "%h", data_channel_4);
                s_data = $fscanf(file_in_5, "%h", data_channel_5);
                s_data = $fscanf(file_in_6, "%h", data_channel_6);
                s_data = $fscanf(file_in_7, "%h", data_channel_7);

                s_data = $fscanf(file_in_8 , "%h", data_channel_8 );
                s_data = $fscanf(file_in_9 , "%h", data_channel_9 );
                s_data = $fscanf(file_in_10, "%h", data_channel_10);
                s_data = $fscanf(file_in_11, "%h", data_channel_11);
                s_data = $fscanf(file_in_12, "%h", data_channel_12);
                s_data = $fscanf(file_in_13, "%h", data_channel_13);
                s_data = $fscanf(file_in_14, "%h", data_channel_14);
                s_data = $fscanf(file_in_15, "%h", data_channel_15);

                // if (s_data) 
                // begin
                //     data_read <= data;
                //     fifo_wrreq <= 1;
                //     if(data_cnt == num_data) 
                //     begin
                //         $display("end read data");
                //     end   
                // end
                // else 
                // begin
                //     // data_cnt <= data_cnt;
                //     data_read <= data_read;
                //     fifo_wrreq <= 0;
                // end

                if (s_data) 
                begin
                    if(data_cnt < num_data)
                    begin
                        // data_read <= data;
                        data_read_0 <= data_channel_0;
                        data_read_1 <= data_channel_1;
                        data_read_2 <= data_channel_2;

                        fifo_wrreq <= 1;

                        // EXTEND
                        data_read_3 <= data_channel_3;
                        data_read_4 <= data_channel_4;
                        data_read_5 <= data_channel_5;
                        data_read_6 <= data_channel_6;
                        data_read_7 <= data_channel_7;

                        data_read_8  <= data_channel_8 ;
                        data_read_9  <= data_channel_9 ;
                        data_read_10 <= data_channel_10;
                        data_read_11 <= data_channel_11;
                        data_read_12 <= data_channel_12;
                        data_read_13 <= data_channel_13;
                        data_read_14 <= data_channel_14;
                        data_read_15 <= data_channel_15;
                    end
                    else
                        if(data_cnt == num_data) 
                        begin
                            // data_read <= data;
                            data_read_0 <= data_channel_0;
                            data_read_1 <= data_channel_1;
                            data_read_2 <= data_channel_2;

                            fifo_wrreq <= 1;
                            $display("end read data");

                            // EXTEND
                            data_read_3 <= data_channel_3;
                            data_read_4 <= data_channel_4;
                            data_read_5 <= data_channel_5;
                            data_read_6 <= data_channel_6;
                            data_read_7 <= data_channel_7;

                            data_read_8  <= data_channel_8 ;
                            data_read_9  <= data_channel_9 ;
                            data_read_10 <= data_channel_10;
                            data_read_11 <= data_channel_11;
                            data_read_12 <= data_channel_12;
                            data_read_13 <= data_channel_13;
                            data_read_14 <= data_channel_14;
                            data_read_15 <= data_channel_15;
                        end
                        else
                        begin
                            if (data_cnt < num_data+WIDTH+2) begin
                                fifo_wrreq <= 1;
                                // data_read <= 32'bz;
                                data_read_0 <= 32'bz;
                                data_read_1 <= 32'bz;
                                data_read_2 <= 32'bz;

                                // EXTEND
                                data_read_3 <= 32'bz;
                                data_read_4 <= 32'bz;
                                data_read_5 <= 32'bz;
                                data_read_6 <= 32'bz;
                                data_read_7 <= 32'bz;

                                data_read_8  <= 32'bz;
                                data_read_9  <= 32'bz;
                                data_read_10 <= 32'bz;
                                data_read_11 <= 32'bz;
                                data_read_12 <= 32'bz;
                                data_read_13 <= 32'bz;
                                data_read_14 <= 32'bz;
                                data_read_15 <= 32'bz;
                            end
                            else
                            begin
                                fifo_wrreq <= 0;
                                // data_read <= 32'bz;
                                data_read_0 <= 32'bz;
                                data_read_1 <= 32'bz;
                                data_read_2 <= 32'bz;

                                // EXTEND
                                data_read_3 <= 32'bz;
                                data_read_4 <= 32'bz;
                                data_read_5 <= 32'bz;
                                data_read_6 <= 32'bz;
                                data_read_7 <= 32'bz;

                                data_read_8  <= 32'bz;
                                data_read_9  <= 32'bz;
                                data_read_10 <= 32'bz;
                                data_read_11 <= 32'bz;
                                data_read_12 <= 32'bz;
                                data_read_13 <= 32'bz;
                                data_read_14 <= 32'bz;
                                data_read_15 <= 32'bz;
                            end
                        end
                end 
                else 
                begin
                    // data_read <= data_read;
                    data_read_0 <= data_read_0;
                    data_read_1 <= data_read_1;
                    data_read_2 <= data_read_2;
                    fifo_wrreq <= 0;
                                
                    // EXTEND
                    data_read_3 <= data_read_3;
                    data_read_4 <= data_read_4;
                    data_read_5 <= data_read_5;
                    data_read_6 <= data_read_6;
                    data_read_7 <= data_read_7;

                    data_read_8  <= data_read_8 ;
                    data_read_9  <= data_read_9 ;
                    data_read_10 <= data_read_10;
                    data_read_11 <= data_read_11;
                    data_read_12 <= data_read_12;
                    data_read_13 <= data_read_13;
                    data_read_14 <= data_read_14;
                    data_read_15 <= data_read_15;
                end 
            end 
            else 
            begin
                data_cnt <= data_cnt;
                // data_read <= data_read;
                data_read_0 <= data_read_0;
                data_read_1 <= data_read_1;
                data_read_2 <= data_read_2;
                fifo_wrreq <= 0;

                // EXTEND
                data_read_3 <= data_read_3;
                data_read_4 <= data_read_4;
                data_read_5 <= data_read_5;
                data_read_6 <= data_read_6;
                data_read_7 <= data_read_7;

                data_read_8  <= data_read_8 ;
                data_read_9  <= data_read_9 ;
                data_read_10 <= data_read_10;
                data_read_11 <= data_read_11;
                data_read_12 <= data_read_12;
                data_read_13 <= data_read_13;
                data_read_14 <= data_read_14;
                data_read_15 <= data_read_15;
            end
        end
    end

endmodule