module ps2_processor_module(clock, ascii_char, key_pressed, ps2_line_content, ps2_line_ready);
	input clock, key_pressed;
	input[7:0] ascii_char;
	output reg[255:0] ps2_line_content;
	output reg ps2_line_ready;
	
	reg[31:0] count;
	wire[31:0] start_index, end_index;
	assign start_index = 255 - (8*count);
	assign end_index = start_index - 7;
	
	initial
	begin 
		count <= 32'd0;
	end
	
	always @(key_pressed)
	begin
	if count == 0
		ps2_line_content[start_index: end_index] <= ascii_char;
		count <= count + 1;
	end
endmodule
