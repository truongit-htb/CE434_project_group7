module tb_generator_3d (
    clk,
    resetn,
    // num_data,
    // fifo write bus
    // fifo_full,
    fifo_data_0,
    fifo_data_1,
    fifo_data_2,

    fifo_wrreq
);
    // paramenters
    parameter DWIDTH = 8;
    parameter input_file_0 = "";
    parameter input_file_1 = "";
    parameter input_file_2 = "";
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

    output reg fifo_wrreq;
    // output reg [7:0] num_data;

    integer file_in_0;
    integer file_in_1;
    integer file_in_2;    
    integer  s_data;
    initial begin
        file_in_0 <= $fopen(input_file_0,"r"); // Read image file 
        file_in_1 <= $fopen(input_file_1,"r"); // Read image file    
        file_in_2 <= $fopen(input_file_2,"r"); // Read image file    

    end 

    
    // parameter READ_CFG_STATE = 0;
    // parameter WR_DATA_STATE = 1;
    //
    reg [11:0] data_cnt;
    reg [DWIDTH-1:0] data_channel_0;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_1;          // dung de doc gia tri pixel tu file
    reg [DWIDTH-1:0] data_channel_2;          // dung de doc gia tri pixel tu file

    reg [DWIDTH-1:0] data_read_0;             // dung de lay data tren cac channel           
    reg [DWIDTH-1:0] data_read_1;             // dung de lay data tren cac channel
    reg [DWIDTH-1:0] data_read_2;             // dung de lay data tren cac channel
    // reg [DWIDTH-1:0] data_read;     // dung de lay data tren cac channel

    // reg [1:0] state;

    //
    assign fifo_data_0 = data_read_0;
    assign fifo_data_1 = data_read_1;
    assign fifo_data_2 = data_read_2;


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
        end
        else 
        begin
            if (data_valid_in==1 /* && fifo_full == 0 */) 
            begin
                data_cnt <= data_cnt + 1;
                s_data = $fscanf(file_in_0, "%h", data_channel_0);
                s_data = $fscanf(file_in_1, "%h", data_channel_1);
                s_data = $fscanf(file_in_2, "%h", data_channel_2);

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
                        end
                        else
                        begin
                            if (data_cnt < num_data+WIDTH+2) begin
                                fifo_wrreq <= 1;
                                // data_read <= 32'bz;
                                data_read_0 <= 32'bz;
                                data_read_1 <= 32'bz;
                                data_read_2 <= 32'bz;
                            end
                            else
                            begin
                                fifo_wrreq <= 0;
                                // data_read <= 32'bz;
                                data_read_0 <= 32'bz;
                                data_read_1 <= 32'bz;
                                data_read_2 <= 32'bz;
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
            end
        end
    end

endmodule