module ascii6digit_to_number (ascii, number);

	input[47:0] ascii;
	output[31:0] number;
	
	wire[31:0] ones, tens, hundreds, thousands, tenth, hundth;
	
	ascii_to_number a(ones, ascii[7:0]);
	ascii_to_number b(tens, ascii[15:8]);
	ascii_to_number c(hundreds, ascii[23:16]);
	ascii_to_number d(thousands, ascii[31:24]);
	ascii_to_number e(tenth, ascii[39:32]);
	ascii_to_number f(hundth, ascii[47:40]);
	
	assign number = ones + tens + hundreds + thousands + tenth + hundth;
		
endmodule
