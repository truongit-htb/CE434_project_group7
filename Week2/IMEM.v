module IMEM(Img, Addr);
	parameter height = 400;
	parameter width = 400;

	output [23:0]Img;
	input [17:0]Addr;
	
	reg [23:0] rom [160000-1:0];
	
	initial begin
		$readmemh("text.txt", rom);
	end
	
	assign Img = rom[Addr];
endmodule
