`timescale 1ns/1ps
module testbench ();
parameter Infile = "text.txt", Outfile = "hsv_text.txt";
parameter Width = 437, Height = 350;
parameter Total_Pixel = Width * Height;
parameter k = 10;

reg clk;
reg [95:0] In;
wire [31:0] H, S, V;
wire Out_Flag;


reg [32*3-1:0] In_Memory [0:Total_Pixel-1];
reg [32*3-1:0] HSV_Memory [0:Total_Pixel-1];

initial begin
  $readmemh(Infile, In_Memory);
end

integer i;
initial begin 
  clk <= 1'b1;
  for (i=0; i<Total_Pixel; i=i+1) begin
   	In <= In_Memory[i];
    #(k*10);
    HSV_Memory[i] = {H,S,V};
  end
  #(2*k) $writememh(Outfile, HSV_Memory);
  #k $finish;
end

always @(clk) begin
  #k clk <= ~clk;
end

rgbtohsv inst0 (H, S, V, Out_Flag, In, clk);

endmodule





