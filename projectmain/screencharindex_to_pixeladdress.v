module screencharindex_to_pixeladdress(clock, count, address);
	
	input clock;
	input[31:0] count;
	output reg[18:0] address;
	
	parameter CHAR_HEIGHT = 30;
	parameter SCREEN_WIDTH = 640;
	parameter CHAR_WIDTH = 20;
	
	always @(posedge clock)
	begin
		if (count < 256) begin
			address <= (240 + (count / 32) * CHAR_HEIGHT) * SCREEN_WIDTH + (count % 32) * CHAR_WIDTH;
//			address <= 19'h2cd30;
		end else begin
			address <= (240 * SCREEN_WIDTH);
		end
	end
	
endmodule
