module typer_logic (
	 clock,
	 
	 row_num,
	 col_num,
	 character_input,
	 start_writing_character,
	 
	 finished_saving_char,
	 
	 mem_waddr,
	 mem_wdata,
	 mem_wenable,
	 
	 //Debug
	 charcount_out,
	 start_row_counter_out,
	 finish_row_counter_out
	 
);

input [7:0] row_num, col_num, character_input;
input start_writing_character, clock;

output finished_saving_char;

output[18:0] mem_waddr;
output[2:0] mem_wdata;
output mem_wenable;

// Debug 
output[18:0] charcount_out;
output start_row_counter_out, finish_row_counter_out;

parameter SCREEN_WIDTH = 640;
parameter SCREEN_HEIGHT = 480;
parameter CHAR_HEIGHT = 30;
parameter CHAR_WIDTH = 20;

wire[599:0] character_bit_data;

reg busy;
reg[7:0] writing_char;
reg[18:0] char_count;
reg[18:0] character_pixel_index;
reg[18:0] row_count;
reg[18:0] mem_waddr_reg;
reg[2:0] mem_wdata_reg;
reg mem_wenable_reg;

assign mem_waddr = mem_waddr_reg;
assign mem_wdata = mem_wdata_reg;
assign mem_wenable = busy;

// Debug
assign charcount_out = char_count;

character_data character_data_inst(
	.address(writing_char),
	.q(character_bit_data),
	.clock(clock)
);


assign finished_saving_char = ~busy;

initial 
begin
	busy <= 1'b0;
	start_row_counter <= 1'b0;
end

reg start_row_counter;
wire finish_row_counter;

assign start_row_counter_out = start_row_counter;
assign finish_row_counter_out = finish_row_counter;

screen_row_counter src (
	.clock(clock), 
	.start(start_row_counter), 
	.finish(finish_row_counter)
);
always @(negedge clock)
begin
	mem_wdata_reg[2:1] <= 2'b00; 
//	mem_wenable_reg <= busy;
	
	if (!busy && start_writing_character)
	begin
		busy <= 1'b1;
		character_pixel_index <= (270 + row_num * CHAR_HEIGHT) * SCREEN_WIDTH + col_num * CHAR_WIDTH;
		writing_char <= character_input;
		char_count <= 19'd0;
		start_row_counter <= 1'b1;
	end
	
	else if (busy && char_count < 600)
	begin
		mem_waddr_reg <= character_pixel_index;
		mem_wdata_reg[0] <= ~character_bit_data[char_count];
		
		if(finish_row_counter)
		begin
			start_row_counter <= 1'b1;
			character_pixel_index <= character_pixel_index + SCREEN_WIDTH - (CHAR_WIDTH - 1) ;
		end
		
		else
		begin
			start_row_counter <= 1'b0;
			character_pixel_index <= character_pixel_index + 1;
		end
		char_count <= char_count + 1;
		
	end
	
	else
	begin
		busy <= 1'b0;
	end
	
end


endmodule
