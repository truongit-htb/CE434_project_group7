module tb_writer (
    clk,
    resetn,
    data_in,
    data_valid_in,
    done
    
    // fifo_rdreq,
    // fifo_data,
    // fifo_empty,
    // num_data
);
    parameter DWIDTH = 32;
    parameter output_file = "";

    //
    parameter WIDTH = 56;
    parameter HEIGHT = 56;
    localparam num_data = WIDTH*HEIGHT;

    input clk;     
    input resetn;
    input [DWIDTH-1:0] data_in;
    input data_valid_in;
    output reg done;

    integer  file_out;
    initial begin
        file_out = $fopen(output_file,"w");
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
            if(data_valid_in) begin
                // for write data to text
                data_cnt <= data_cnt + 1;
                // 
                // if (data_cnt== 0) begin
                //     // add header file
                //     $fwrite(file_out, "%d\n", num_data); 
                // end

                if (data_cnt < num_data-1) begin               
                    $fwrite(file_out, "%h\n", data_in);
                    done <= 1'b0;
                end
                else
                    // if(data_cnt == num_data-1) 
                    begin
                        $fwrite(file_out, "%h\n", data_in);
                        done <= 1'b1;
                        #5 $fclose(file_out);
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