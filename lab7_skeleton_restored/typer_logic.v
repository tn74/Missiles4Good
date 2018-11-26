module typer_logic (
	 clock,
	 
	 row_num,
	 col_num,
	 character_input,
	 start_writing_character,
	 
	 finished_saving_char,
	 
	 mem_waddr,
	 mem_wdata,
	 mem_wenable
);

input [7:0] row_num, col_num, character_input;
input start_writing_character, clock;

output finished_saving_char;

output[18:0] mem_waddr;
output[2:0] mem_wdata;
output mem_wenable;

parameter SCREEN_WIDTH = 640;
parameter SCREEN_HEIGHT = 480;
parameter CHAR_HEIGHT = 30;
parameter CHAR_WIDTH = 20;

wire[599:0] character_bit_data;

reg busy;
reg[7:0] writing_char;
reg[10:0] char_count;
reg[18:0] character_start_index;
reg[18:0] character_pixel_index;
reg[4:0] row_count;
reg[18:0] mem_waddr_reg;
reg[2:0] mem_wdata_reg;
reg mem_wenable_reg;

assign mem_waddr = mem_waddr_reg;
assign mem_wdata = mem_wdata_reg;
assign mem_wenable = busy;


character_data character_data_inst(
	.address(writing_char),
	.q(character_bit_data),
	.clock(clock)
);


assign finished_saving_char = ~busy;

initial 
begin
	busy <= 1'b0;
end

always @(posedge clock)
begin
	mem_wdata_reg[2:1] <= 2'b00; 
//	mem_wenable_reg <= busy;
	
	if (!busy && start_writing_character)
	begin
		busy <= 1'b1;
		character_pixel_index <= (270 + row_num * CHAR_HEIGHT) * SCREEN_WIDTH + col_num * CHAR_WIDTH;
		writing_char <= character_input;
		char_count <= 0;
		row_count <= 0;
	end
	
	else if (busy && char_count < 600)
	begin
		mem_waddr_reg <= character_pixel_index;
		mem_wdata_reg[0] <= character_bit_data[char_count];
		if(row_count == CHAR_WIDTH)
		begin
			row_count <= 0;
			character_pixel_index <= character_pixel_index + SCREEN_WIDTH - CHAR_WIDTH;
		end
		else
		begin
			character_pixel_index <= character_pixel_index + 1;
		end
		row_count <= row_count + 1;
		char_count <= char_count + 1;
		
	end
	
	else
	begin
		busy <= 1'b0;
	end
	
end


endmodule
