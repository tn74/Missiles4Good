module input_brain(
	clock,
	
	// PS2
	input_made, 
	input_character,
	
	// VGA
	row_num,
	col_num,
	vga_character_in,
	vga_start_write
);

input input_made, clock;
input[7:0] input_character;

output reg[7:0] row_num, col_num;
output[7:0] vga_character_in;
output vga_start_write;




assign vga_start_write = input_made;

//initial
//begin
//	vga_start_write <= 1'b0;
//end
//always @(posedge clock)
//begin
//	if (input_made && !(input_character == 8'h00)) 
//	begin
//		if (input_character == 8'h0A) // Ascii New Line
//		begin
//			col_num <= 8'h00;
//			row_num <= row_num + 1;
//		end
//		
//		else // Else Write to terminal
//		begin
//			vga_start_write <= 1'b1;
//			if (col_num < 8'h20)
//			begin
//				col_num <= col_num + 1;
//			end
//			
//			else
//			begin
//			if (row_num < 8'h06)
//				row_num <= row_num + 1;
//			else
//				row_num <= 8'h00;
//			col_num <= 8'h00;
//			end
//		end
//	end
//	
//	else
//		vga_start_write <= 1'b0;
//end

assign vga_character_in = input_character;


endmodule
