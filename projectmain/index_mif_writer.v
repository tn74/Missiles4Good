module index_mif_writer(
	clock,
	character_address,
	character_clock,
	character,
	
	mem_waddr,
	mem_wdata,
	mem_wenable,
	
	// Debug
	typer_start_out,
   typer_finish_out,
   typer_busy_out,
   count_out,
	
);

input clock;

input[7:0] character;
output character_clock;
output[7:0] character_address;

output[18:0] mem_waddr;
output[2:0] mem_wdata;
output mem_wenable; 


reg typer_busy;
wire[18:0] typer_waddr, top_left_corner_address;
wire[2:0] typer_wdata;
wire typer_wenable;
reg typer_start;
wire typer_finish;


reg[31:0] count;

initial
begin
	typer_start <= 1'b0;
	typer_busy <= 1'b0;
	count <= 32'h00000000;
end

screencharindex_to_pixeladdress index2pixel(
	.clock(clock),
	.count(count),
	.address(top_left_corner_address)
);

typer_logic typer_inst(
	 .clock(clock),
	 .top_left_corner_address(top_left_corner_address),
	 .character_input(character),
	 .start_writing_character(typer_start),
	 .finished_saving_char(typer_finish),
	 
	 .mem_waddr(typer_waddr),
	 .mem_wdata(typer_wdata),
	 .mem_wenable(typer_wenable)
);


always@(posedge clock)
begin
	if (count < 32'd238) begin
		if (typer_finish) begin
			typer_start <= 1'b1;
			count <= count + 1;
		end else begin
			typer_start <= 1'b0;
		end
	end
end

assign mem_waddr = typer_waddr;
assign mem_wdata = typer_wdata;
assign mem_wenable = typer_wenable;
assign character_address = count[7:0];
assign character_clock = ~clock;


// Debugging

output typer_start_out, typer_finish_out, typer_busy_out;
output[31:0] count_out;

assign typer_start_out = typer_start;
assign typer_finish_out = typer_finish;
assign typer_busy_out = typer_busy;
assign count_out = count;

endmodule
