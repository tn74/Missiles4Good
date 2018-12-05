module ascii6digit_to_number (ascii, number);

	input[47:0] ascii;
	output reg[31:0] number;
	
	wire[31:0] ones, tens, hundreds, thousands, tenth, hundth;
	
	ascii_to_number a(ascii[7:0], ones,);
	ascii_to_number b(ascii[15:8], tens);
	ascii_to_number c(ascii[23:16], hundreds);
	ascii_to_number d(ascii[31:24], thousands);
	ascii_to_number e(ascii[39:32], tenth);
	ascii_to_number f(ascii[47:40], hundth);
	
	always @(ascii) begin
		number <= ones + (tens * 32'd10) + (hundreds * 32'd100) + (thousands * 32'd1000) + (tenth * 10000) + (hundth * 32'd100000);
	end
		
endmodule
