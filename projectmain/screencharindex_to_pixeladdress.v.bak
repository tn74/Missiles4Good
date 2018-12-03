module screencharindex_to_pixeladdress(clock, count, address);
	
	input[31:0] count;
	output reg[18:0] address;
	
	parameter CHAR_HEIGHT = 30;
	parameter SCREEN_WIDTH = 680;
	parameter CHAR_WIDTH = 20;
	
	
	if (count < 240) begin
		assign address = (240 + (count / 32) * CHAR_HEIGHT) * SCREEN_WIDTH + (count % 32) * CHAR_WIDTH;
	end else begin
		assign address = 19'h00000;
	end
	
endmodule
