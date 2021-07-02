module tb_writer_3d (
    clk,
    resetn,

    data_in_0,
    data_in_1,
    data_in_2,
    data_in_3,
    data_in_4,
    data_in_5,
    data_in_6,
    data_in_7,

    data_valid_in,
    done
    
    // fifo_rdreq,
    // fifo_data,
    // fifo_empty,
    // num_data
);
    parameter DWIDTH = 32;
    parameter output_file_0 = "";
    parameter output_file_1 = "";
    parameter output_file_2 = "";
    parameter output_file_3 = "";
    parameter output_file_4 = "";
    parameter output_file_5 = "";
    parameter output_file_6 = "";
    parameter output_file_7 = "";


    //
    parameter WIDTH = 56;
    parameter HEIGHT = 56;
    localparam num_data = WIDTH*HEIGHT;

    input clk;     
    input resetn;
    // input [DWIDTH-1:0] data_in;
    input [DWIDTH-1:0] data_in_0;
    input [DWIDTH-1:0] data_in_1;
    input [DWIDTH-1:0] data_in_2;
    input [DWIDTH-1:0] data_in_3;
    input [DWIDTH-1:0] data_in_4;
    input [DWIDTH-1:0] data_in_5;
    input [DWIDTH-1:0] data_in_6;
    input [DWIDTH-1:0] data_in_7;

    input data_valid_in;
    output reg done;

    integer  file_out_0;
    integer  file_out_1;
    integer  file_out_2;
    integer  file_out_3;
    integer  file_out_4;
    integer  file_out_5;
    integer  file_out_6;
    integer  file_out_7;

    initial begin
        file_out_0 = $fopen(output_file_0,"w");
        file_out_1 = $fopen(output_file_1,"w");
        file_out_2 = $fopen(output_file_2,"w");
        file_out_3 = $fopen(output_file_3,"w");
        file_out_4 = $fopen(output_file_4,"w");
        file_out_5 = $fopen(output_file_5,"w");
        file_out_6 = $fopen(output_file_6,"w");
        file_out_7 = $fopen(output_file_7,"w");

    end

    // input [7:0] num_data;

    // output  reg  fifo_rdreq;
    // input [DWIDTH-1:0]    fifo_data;
    // input fifo_empty;

    // reg data_valid;
    reg [15:0] data_cnt;
    // wire sof; // start of frame
    // assign sof = (data_cnt == 1) && (data_valid==1);

    // // generate ready signal
    // reg[15:0]a;
    // always @(posedge clk) begin
    //     a <=$urandom%10; 
    // end
    // // 
    // wire ready;
    // // assign ready = a[4] | a[0];
    // assign ready = 1;

    // always @(posedge clk or negedge resetn) begin
    //     if(resetn == 1'b0) 
    //     begin
    //         fifo_rdreq <= 0;  
    //     end
    //     else 
    //     begin
    //         data_valid <= fifo_rdreq; // delay 1clk after read fifo
    //         if (fifo_empty==0 && ready == 1) begin
    //             // ly tuong ()
    //             fifo_rdreq <= 1'b1;
            
    //             //
    //         end
    //         else begin
    //             fifo_rdreq <= 1'b0;
    //         end

    //     end
    // end
    // // delay data valid 1 clk


    // wire data to text
    always @(posedge clk or negedge resetn) begin
        if(resetn == 1'b0) begin
            data_cnt <= 0;
            done <= 1'b0;
        end
        else 
        begin
            if(data_valid_in) 
            begin
                // for write data to text
                data_cnt <= data_cnt + 1;
                // 
                // if (data_cnt== 0) begin
                //     // add header file
                //     $fwrite(file_out, "%d\n", num_data); 
                // end

                if (data_cnt < num_data-1) begin               
                    $fwrite(file_out_0, "%h\n", data_in_0);
                    $fwrite(file_out_1, "%h\n", data_in_1);
                    $fwrite(file_out_2, "%h\n", data_in_2);
                    $fwrite(file_out_3, "%h\n", data_in_3);
                    $fwrite(file_out_4, "%h\n", data_in_4);
                    $fwrite(file_out_5, "%h\n", data_in_5);
                    $fwrite(file_out_6, "%h\n", data_in_6);
                    $fwrite(file_out_7, "%h\n", data_in_7);

                    done <= 1'b0;
                end
                else
                    // if(data_cnt == num_data-1) 
                    begin
                        // $fwrite(file_out, "%h\n", data_in);
                        $fwrite(file_out_0, "%h\n", data_in_0);
                        $fwrite(file_out_1, "%h\n", data_in_1);
                        $fwrite(file_out_2, "%h\n", data_in_2);
                        $fwrite(file_out_3, "%h\n", data_in_3);
                        $fwrite(file_out_4, "%h\n", data_in_4);
                        $fwrite(file_out_5, "%h\n", data_in_5);
                        $fwrite(file_out_6, "%h\n", data_in_6);
                        $fwrite(file_out_7, "%h\n", data_in_7);

                        done <= 1'b1;

                        #5;
                        $fclose(file_out_0);
                        $fclose(file_out_1);
                        $fclose(file_out_2);
                        $fclose(file_out_3);
                        $fclose(file_out_4);
                        $fclose(file_out_5);
                        $fclose(file_out_6);
                        $fclose(file_out_7);
                        $display("writed file done");
                        #5 $finish;
                    end
                    // else
                    // // if(data_cnt == num_data)
                    // begin
                    //     $fclose(file_out);
                    //     $display("writed file done");
                    //     $finish;
                    // end
            end
            else
            begin
                data_cnt <= data_cnt;
                done <= 1'b0;
            end
        end
    end

endmodule