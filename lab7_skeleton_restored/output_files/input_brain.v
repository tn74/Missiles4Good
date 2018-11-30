module input_brain(
	clock,
	
	// PS2
	ps2_key_pressed, 
	ps2_out,
	
	// VGA
	row_num,
	col_num,
	character_input,
	start_writing_character
);

input ps2_key_pressed, clock;
input[7:0] ps2_out;

output reg[7:0] row_num, col_num;
output[7:0] character_input;
output reg start_writing_character;

wire[7:0] ascii_char;
reg[7:0] row_reg, col_reg;

ps2_to_ascii converter(ps2_out, character_input);

initial
begin
	row_reg <= 8'h00;
	col_reg <= 8'h00;
end


always @(posedge clock)
begin
	if (ps2_key_pressed && !(ascii_char == 8'h00)) // Ascii New Line
	begin
		if (ascii_char == 8'h0A)
		begin
			col_num <= 8'h00;
			row_num <= row_num + 1;
		end
		
		else // Else Write to terminal
		begin
			start_writing_character <= 1'b1;
			if (row_reg < 8'h20)
				col_num <= col_num + 1;
			else
				row_num <= row_num + 1;
				col_num <= 8'h00;
		end
	end
	
	else
		start_writing_character <= 1'b0;
end

endmodule
