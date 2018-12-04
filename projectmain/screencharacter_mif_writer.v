module screencharacter_mif_writer (
	clock,
	velocity,
	fire,
	angle,
	targetx,
	targety,
	ps2_line_content,
	ps2_line_ready,
		
	rd_add, 
	rd_clk,		
	rd_out,
	
	//Debug
	count_out,
	char_index_out,
	char_data_out
);

input clock, fire;
input[31:0] velocity, angle;
input[31:0] targetx, targety;
input[255:0] ps2_line_content;
input ps2_line_ready;

input[7:0] rd_add;
input rd_clk;
output[7:0] rd_out;

reg[31:0] count;
reg[7:0] write_char, char_index;
reg write_en;

wire[47:0] velocity_digits, angle_digits;


wire terminal_display_finish;
reg terminal_display_start, terminal_display_busy;
wire[7:0] terminal_display_char_index, terminal_display_char_data;


always @(posedge clock)
begin
	// Writing Velocity Characters
	if (count == 32'd0) begin
		write_char <= velocity_digits[7:0];
		char_index <= 8'b00111111;
		count <= count + 1;
	end else if (count == 32'd1) begin
		write_char <= velocity_digits[15:8];
		char_index <= 8'b00111110;
		count <= count + 1;
	end else if (count == 32'd2) begin
		write_char <= velocity_digits[23:16];
		char_index <= 8'b00111101;
		count <= count + 1;
	end else if (count == 32'd3) begin
		write_char <= velocity_digits[31:24];
		char_index <= 8'b00111100;
		count <= count + 1;
	end
	
	// Writing Angle Characters
	else if (count == 32'd4) begin
		write_char <= angle_digits[7:0];
		char_index <= 8'b01011111;
		count <= count + 1;
	end else if (count == 32'd5) begin
		write_char <= angle_digits[15:8];
		char_index <= 8'b01011110;
		count <= count + 1;
	end else if (count == 32'd6) begin
		write_char <= angle_digits[23:16];
		char_index <= 8'b01011101;
		count <= count + 1;
	end 
	
	// Writing All Terminal
	else if (count == 32'd7) begin
		if(terminal_display_finish && ~terminal_display_busy) begin
			terminal_display_start <= 1'b1;
			terminal_display_busy <= 1'b1;
		end else if (terminal_display_finish && terminal_display_busy) begin
			terminal_display_busy <= 1'b0;
			count <= count + 1;
		end else begin
			write_char <= terminal_display_char_data;
			char_index <= terminal_display_char_index;
			terminal_display_start <= 1'b0;
		end
	end
		
	// Else Reset
	else begin
		count <= 32'd0;
	end

end


// --------------------------------------- Subciruits ----------------------
number_to_six_digit velconvert(velocity, velocity_digits);
number_to_six_digit angconvert(angle, angle_digits);


commands_printer_tracker cpt(
	.clock(clock), 
	.start(terminal_display_start),
	.ps2_line_content(ps2_line_content),
	.ps2_line_ready(ps2_line_ready),
	
	.finish(terminal_display_finish),
	.char_index(terminal_display_char_index), 
	.char_data(terminal_display_char_data)
);

screenchar_mem smem (
	.rdaddress(rd_add),
	.rdclock(rd_clk),
	.q(rd_out),
	
	.data(write_char),
	.wraddress(char_index),
	.wrclock(~clock),
	.wren(1'b1),
);

// Debug

output[31:0] count_out;
output[7:0] char_index_out, char_data_out;
assign count_out = count;
assign char_index_out = char_index;
assign char_data_out = write_char;


// Initialization
initial
begin
	write_en <= 1'b1;
end

endmodule
