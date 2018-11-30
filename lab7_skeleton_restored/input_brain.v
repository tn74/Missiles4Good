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
wire do_read_key;

ps2_to_ascii converter(ps2_out, character_input);


initial
begin
	start_writing_character <= 1'b0;
end


parameter TARGET_DELAY = 5000000; // 0.01 seconds
reg[31:0] read_delay_counter;
assign do_read_key = (read_delay_counter == TARGET_DELAY + 1);

always @(posedge clock)
begin
	if (!(read_delay_counter == TARGET_DELAY + 2))
		read_delay_counter <= read_delay_counter + 1;
	else if (ps2_key_pressed == 1'b1)
		read_delay_counter <= 32'd1;
end




always @(posedge clock)
begin
	if (ps2_key_pressed && !(ascii_char == 8'h00)) 
	begin
		if (ascii_char == 8'h0A) // Ascii New Line
		begin
			col_num <= 8'h00;
			row_num <= row_num + 1;
		end
		
		else // Else Write to terminal
		begin
			start_writing_character <= 1'b1;
//			col_num <= col_num + 1;
			if (col_num < 8'h20)
			begin
				col_num <= col_num + 1;
			end
			
			else
			begin
			if (row_num < 8'h06)
				row_num <= row_num + 1;
			else
				row_num <= 8'h00;
			col_num <= 8'h00;
			end
		end
	end
	
	else
		start_writing_character <= 1'b0;
end

endmodule
