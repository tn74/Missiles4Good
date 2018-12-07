module ps2_cleaner(clock, ps2_key_received, ps2_last_key_received, ascii_character_out, key_just_pressed);
	input[7:0] ps2_key_received, ps2_last_key_received;
	input clock;
	
	output[7:0] ascii_character_out;
	output key_just_pressed;
	
	wire key_released, counter_finished;
	assign key_released = (ps2_last_key_received == 8'hf0);
	
	reg key_released_reg;
	reg counter_start;
	
	counter2 counter(.clock(clock), .start(counter_start), .finish(counter_finished));
	
	initial
	begin
		counter_start <= 1'b0;
		key_released_reg <= 1'b0;
	end
	
	always @(posedge clock)
	begin
		key_released_reg <= key_released;
		counter_start <= (key_released_reg & key_released);
	end
	
	assign key_just_pressed = counter_finished;
		
	ps2_to_ascii converter(ps2_key_received, ascii_character_out);
endmodule
