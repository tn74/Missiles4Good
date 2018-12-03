module number_to_six_digit(number, digits);
	input[31:0] number;
	output[47:0] digits;
	
	wire[31:0] d1, d2, d3, d4, d5, d6;
	
	assign d1 = (number % 10);
	assign d2 = ((number/ 10) % 10);
	assign d3 = ((number/ 100) % 10);
	assign d4 = ((number/ 1000) % 10);
	assign d5 = ((number/ 10000) % 10);
	assign d6 = ((number/ 100000) % 10);
	
	number_to_ascii(d1, digits[7:0]);
	number_to_ascii(d2, digits[15:8]);
	number_to_ascii(d3, digits[23:16]);
	number_to_ascii(d4, digits[31:24]);
	number_to_ascii(d5, digits[39:32]);
	number_to_ascii(d6, digits[47:40]);
	
endmodule
