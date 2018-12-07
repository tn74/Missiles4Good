module ps2_processor_module(
	clock, 
	ascii_char, 
	key_pressed, 
	ps2_line_content, 
	ps2_line_ready,
	
	velocity, 
	angle,
	fire,
	queue,
	reset
);
	input clock, key_pressed;
	input[7:0] ascii_char;
	output reg[255:0] ps2_line_content;
	output reg ps2_line_ready;
	output[31:0] velocity, angle;
	output fire, reset, queue;
	
	reg[31:0] count;
	
	initial
	begin 
		count <= 32'h00000000;
	end
	
	wire last_cycle_backspace;
	assign last_cycle_backspace = key_pressed & (ascii_char == 8'h08);
	
	always @(posedge clock)
	begin
		if (key_pressed & (ascii_char == 8'h0a)) begin
			count <= 32'h00000000;
		end else if (key_pressed & (ascii_char == 8'h08)) begin
			count <= count - 1;	
		end else if (key_pressed & ~(ascii_char == 8'h00)) begin
			count <= count + 1;	
		end
	end
	
	always @(negedge clock)
	begin
		if (key_pressed & (ascii_char == 8'h0a)) begin
			ps2_line_ready <= 1'b1;
		end else begin
			ps2_line_ready <= 1'b0;
		end
	end
	
	
	always @(posedge clock)
	begin
		if (key_pressed) begin
			if (ascii_char == 8'h0a) or last_cycle_backspace begin
				ps2_line_content[255:0] <= 255'd0;
			end else if (count == 32'd0) | last_cycle_backspace begin
				ps2_line_content[255:248] <= ascii_char;
			end else if (count == 32'd1) | last_cycle_backspace begin
				ps2_line_content[247:240] <= ascii_char;
			end else if (count == 32'd2) | last_cycle_backspace begin
				ps2_line_content[239:232] <= ascii_char;
			end else if (count == 32'd3) | last_cycle_backspace begin
				ps2_line_content[231:224] <= ascii_char;
			end else if (count == 32'd4) | last_cycle_backspace begin
				ps2_line_content[223:216] <= ascii_char;
			end else if (count == 32'd5) | last_cycle_backspace begin
				ps2_line_content[215:208] <= ascii_char;
			end else if (count == 32'd6) | last_cycle_backspace begin
				ps2_line_content[207:200] <= ascii_char;
			end else if (count == 32'd7) | last_cycle_backspace begin
				ps2_line_content[199:192] <= ascii_char;
			end else if (count == 32'd8) | last_cycle_backspace begin
				ps2_line_content[191:184] <= ascii_char;
			end else if (count == 32'd9) | last_cycle_backspace begin
				ps2_line_content[183:176] <= ascii_char;
			end else if (count == 32'd10) | last_cycle_backspace begin
				ps2_line_content[175:168] <= ascii_char;
			end else if (count == 32'd11) | last_cycle_backspace begin
				ps2_line_content[167:160] <= ascii_char;
			end else if (count == 32'd12) | last_cycle_backspace begin
				ps2_line_content[159:152] <= ascii_char;
			end else if (count == 32'd13) | last_cycle_backspace begin
				ps2_line_content[151:144] <= ascii_char;
			end else if (count == 32'd14) | last_cycle_backspace begin
				ps2_line_content[143:136] <= ascii_char;
			end else if (count == 32'd15) | last_cycle_backspace begin
				ps2_line_content[135:128] <= ascii_char;
			end else if (count == 32'd16) | last_cycle_backspace begin
				ps2_line_content[127:120] <= ascii_char;
			end else if (count == 32'd17) | last_cycle_backspace begin
				ps2_line_content[119:112] <= ascii_char;
			end else if (count == 32'd18) | last_cycle_backspace begin
				ps2_line_content[111:104] <= ascii_char;
			end else if (count == 32'd19) | last_cycle_backspace begin
				ps2_line_content[103:96] <= ascii_char;
			end else if (count == 32'd20) | last_cycle_backspace begin
				ps2_line_content[95:88] <= ascii_char;
			end else if (count == 32'd21) | last_cycle_backspace begin
				ps2_line_content[87:80] <= ascii_char;
			end else if (count == 32'd22) | last_cycle_backspace begin
				ps2_line_content[79:72] <= ascii_char;
			end else if (count == 32'd23) | last_cycle_backspace begin
				ps2_line_content[71:64] <= ascii_char;
			end else if (count == 32'd24) | last_cycle_backspace begin
				ps2_line_content[63:56] <= ascii_char;
			end else if (count == 32'd25) | last_cycle_backspace begin
				ps2_line_content[55:48] <= ascii_char;
			end else if (count == 32'd26) | last_cycle_backspace begin
				ps2_line_content[47:40] <= ascii_char;
			end else if (count == 32'd27) | last_cycle_backspace begin
				ps2_line_content[39:32] <= ascii_char;
			end else if (count == 32'd28) | last_cycle_backspace begin
				ps2_line_content[31:24] <= ascii_char;
			end else if (count == 32'd29) | last_cycle_backspace begin
				ps2_line_content[23:16] <= ascii_char;
			end else if (count == 32'd30) | last_cycle_backspace begin
				ps2_line_content[15:8] <= ascii_char;
			end else if (count == 32'd31) | last_cycle_backspace begin
				ps2_line_content[7:0] <= ascii_char;
			end
		end
	end	
	
	
	reg ready_delay;
	reg[255:0] saved_content_line;
	always @(posedge ps2_line_ready) begin
		saved_content_line <= ps2_line_content;
	end
	always @(posedge clock) begin
		ready_delay <= ps2_line_ready;
	end
	
	ps2_interpreter ps2int(
		.clock(clock),
		.input_line(saved_content_line), 
		.line_ready(ready_delay), 
		.velocity(velocity), 
		.angle(angle),
		.fire(fire),
		.queue(queue),
		.reset(reset)
	);
endmodule
