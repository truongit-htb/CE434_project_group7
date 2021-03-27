`timescale 1ns/1ps
module testbench ();
parameter Infile = "text.txt", Outfile = "hsv_text.txt";
parameter Width = 437, Height = 350;
parameter Total_Pixel = Width * Height;
parameter k = 30;

reg clk, rst_n, In_Valid;
reg [95:0] In;
wire [31:0] H, S, V;
wire Out_Valid;



reg [32*3-1:0] In_Memory [0:Total_Pixel-1];
reg [32*3-1:0] HSV_Memory [0:Total_Pixel-1];

initial begin
  $readmemh(Infile, In_Memory);
end

integer i;
initial begin 
  for (i=0; i<Total_Pixel; i=i+1) begin
   	In = In_Memory[i];
    #(k*4);
    if(Out_Valid == 1'b1) HSV_Memory[i] = {H,S,V};
    else HSV_Memory[i] = 96'hx;
  end
  #(2*k) $writememh(Outfile, HSV_Memory);
  #k $finish;
end

initial begin
	rst_n = 1'b1;
	clk = 1'b1;
	In_Valid = 1'b1;
	#(2*k) rst_n = 1'b0;
	#(2*k) rst_n = 1'b1;
end
always @(clk) begin
  #k clk <= ~clk;
end

rgbtohsv inst0 (H, S, V, Out_Valid, In_Valid, In, rst_n, clk);

endmodule





