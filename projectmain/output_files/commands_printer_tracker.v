module commands_printer_tracker(clock, start, ps2_line_content, ps2_line_ready, char_index, char_data, finish);
	input clock, start;
	input[255:0] ps2_line_content;
	input ps2_line_ready;
	
	output finish;
	output[7:0] char_index, char_data;

	
	reg[7:0] ps2_lines[7:0][31:0];
	
	
	genvar c;
	generate
		for (c = 0; c < 31; c = c + 1) begin update_bottom_ps2line
			always @(posedge clock) begin ps2lineupdater
				ps2_lines[7][c] <= ps2_line_ready[255 - c*8 : 255 - c*8 - 7];
			end
		end
	endgenerate
	
	// ----------------------------- Loop for printing to screen ---------------------
	reg[31:0] count;
	assign finish = (count == 32'd256);
	always @(posedge clock)
	begin
		if (start) begin
			count <= 32'd0;
		end else begin
			if (count < 236) begin
				if (count % 32 < 12) begin
					char_index <= count;
					char_data <= ps2_lines[count / 32][count % 32];
				end else begin
					char_index <= (char_index + 32) / 32;
				end
			end
		end
	end
	
endmodule
