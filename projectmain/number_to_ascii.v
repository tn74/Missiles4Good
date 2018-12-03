module number_to_ascii(number, ascii_code);
	input[3:0] number;
	output[7:0] ascii_code;
	
	wire[7:0] eight_bit_number;
	assign eight_bit_number[3:0] = number;
	
	assign ascii_code = 8'h30 + eight_bit_number;
endmodule
