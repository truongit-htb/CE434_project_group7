`timescale 1ns/1ps
module testbench ();
parameter Infile = "/v_env/ce434/demo_vivado/rgb2hsv/python_code/data_input.txt";
parameter Outfile = "/v_env/ce434/demo_vivado/rgb2hsv/python_code/data_out_modelsim.txt";
parameter Width = 60, Height = 50;
parameter Total_Pixel = Width * Height;
parameter k = 20;

//reg Enable;
reg rst_n, clk;
reg [95:0] In;
wire [31:0] H, S, V;
wire Valid_Out;

reg [32*3-1:0] In_Memory [0:Total_Pixel-1];
reg [32*3-1:0] HSV_Memory [0:Total_Pixel-1];

initial begin
  $readmemh(Infile, In_Memory);
end

integer i;
initial begin 
  i = 0;
  #(k*2) In = In_Memory[i];
  #(k*7/2);
  if(Valid_Out == 1'b1) 
    HSV_Memory[0] = {H,S,V};
  else 
    HSV_Memory[0] = 96'hx;

  for (i = 1; i < Total_Pixel; i = i + 1) begin
    In = In_Memory[i];
    #(k*2);
    if(Valid_Out == 1'b1) 
	HSV_Memory[i] = {H,S,V};
    else 
	HSV_Memory[i] = 96'hx;
  end
  #(2*k) $writememh(Outfile, HSV_Memory);
  #k $finish;
end

initial begin
  clk = 1'b0;
  rst_n = 1'b1;
  #(k/2) rst_n = 1'b0;
  #k rst_n = 1'b1;
end

always #k clk = ~clk;

RGBtoHSV ins0(H, S, V, Valid_Out, In, rst_n, clk);

endmodule





