module max4input #(
    parameter DATA_WIDTH=32
    )
    (
        clk/*,enable*/,resetn,valid_in,in1,in2,in3,in4,out,valid_out
    );
    input clk;
    
    input resetn;
    input valid_in;
    input [DATA_WIDTH-1:0] in1;
    input [DATA_WIDTH-1:0] in2;
    input [DATA_WIDTH-1:0] in3;
    input [DATA_WIDTH-1:0] in4;
    output [DATA_WIDTH-1:0] out;
    output valid_out;

    //reg [31:0] A,B,C,D;
    reg [DATA_WIDTH-1:0] maxab,maxcd,max;
    reg [1:0] counter,count_out;
    //reg valid_r;
    assign out = max;
    //reg enable;
   // wire enable;
    //assign enable = (counter > 2'b0)?1'b1:1'b0;


    delay_clock #(.DATA_WIDTH(1),.N_CLOCKs(2)) valid_ins(clk,resetn,1'b1,valid_in,valid_out);
    wire stage1;
    delay_clock #(.DATA_WIDTH(1),.N_CLOCKs(1)) st1_ins(clk,resetn,1'b1,valid_in,stage1);
    // /*
    // always @(posedge clk or negedge resetn) begin
	// 	if (resetn == 1'b0) begin 
    //             counter <= 2'd0;
    //             valid_r<=1'b0;
    //         end
	// 	else if(valid_in == 1'b1) begin
    //             counter <= 2'd3;
    //             valid_r<=1'b1;
    //         end
    //     else if (valid_in == 1'b0) begin
    //             if(counter == 2'b0) begin
    //                 counter <= 0;
    //                 valid_r<=1'b0;
    //             end
	// 		    else begin  
    //                 counter <= counter - 2'b1;
    //                 valid_r<=1'b0;
    //             end
    //         end
    // end
    // */
	
    /*
    always @ (posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            A <= 0;
            B <= 0;
            C <= 0;
            D <= 0;
        end
        else if (valid_in == 1'b1) begin
            A <= in1;
            B <= in2;
            C <= in3;
            D <= in4;
        end 
        else if (valid_in == 1'b0) begin
            A <= A;
            B <= B;
            C <= C;
            D <= D;
        end 
    end
    */
    
    always @ (posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            maxab <= 0;
            //stage1 <= 0;
        end
        else if (valid_in == 1'b1) begin
            if ( $signed(in1) > $signed(in2) ) begin
              maxab <= in1;
            end
            else maxab <= in2;
        end 
        else if (valid_in == 1'b0) begin
            maxab <= maxab;
        end 
    end

    always @ (posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            maxcd <= 0;
        end
        else if (valid_in == 1'b1) begin
            if ( $signed(in3) > $signed(in4) ) begin
              maxcd <= in3;
            end
            else maxcd <= in4;
        end 
        else if (valid_in == 1'b0) begin
            maxcd <= maxcd;
        end 
    end

    always @ (posedge clk or negedge resetn) begin
        if (resetn == 1'b0) begin
            max <= 0;
            //valid_out <= 0;
        end
        else if (stage1 == 1'b1) begin
            if ( $signed(maxab) >= $signed(maxcd) ) begin
              max <= maxab;
              //valid_out <= 1;
            end
            else begin
                max <= maxcd;
                //valid_out <= 1;
            end 
        end 
        else if (stage1 == 1'b0) begin
            max <= max;
            //valid_out <= valid_out;
        end 
    end
endmodule