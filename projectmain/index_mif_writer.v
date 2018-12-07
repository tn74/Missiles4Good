module index_mif_writer(
	clock, reset,
	
	character_address,
	character_clock,
	character,
	
	draw_address,
	draw_clock,
	draw_pixelad,
	
	mem_waddr,
	mem_wdata,
	mem_wenable,
	
	// Debug
	typer_start_out,
   typer_finish_out,
   typer_busy_out,
   count_out,
	
);

input clock, reset;

output reg[18:0] mem_waddr;
output reg[2:0] mem_wdata;
output reg mem_wenable; 


reg typer_busy;


wire[18:0] 		typer_waddr, 		draw_waddr;
wire[2:0] 		typer_wdata, 		draw_wdata;
wire 				typer_wenable, 	draw_wenable;
reg 				typer_start, 		draw_start;
wire 				typer_finish, 		draw_finish;


reg[31:0] count;
reg resetting;

initial
begin
	typer_start <= 1'b0;
	typer_busy <= 1'b0;
	count <= 32'h00000000;
	resetting <= 1'b0;
end

// ---------------------------------------------------------- Main Loop -----------------------------------------------------------


always@(posedge clock) begin
	// Resetting logic
	if (reset) begin
		resetting <= 1'b1;
		count <= 32'd0;
	end else if (resetting) begin
		if (count < 32'h25800) begin
			mem_waddr <= count;
			mem_wdata <= 3'b000;
			mem_wenable <= 1'b1;
			count <= count + 32'd1;
		end else begin
			resetting <= 1'b0;
		end
	
	// Normal Logic
	end else if (count < 32'd256) begin
		if (typer_finish) begin
			typer_start <= 1'b1;
			count <= count + 1;
		end else begin
			typer_start <= 1'b0;
		end
		mem_waddr <= typer_waddr;
		mem_wdata <= typer_wdata;
		mem_wenable <= typer_wenable;
		
	end else if (count < 32'd656) begin
		if (draw_finish) begin
			draw_start <= 1'b1;
			count <= count + 1;
		end else begin
			draw_start <= 1'b0;
		end
		mem_waddr <= draw_waddr;
		mem_wdata <= 3'b010;
		mem_wenable <= ~draw_finish;

		
	end else begin
		count <= 32'h00000000;
	end
end

// ---------------------------------------------------------- Character Printing -----------------------------------------------------------

output[7:0] character_address;
output character_clock;
input[7:0] character;

assign character_address = count[7:0];
assign character_clock = ~clock;
wire[18:0] top_left_corner_address;

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

// ---------------------------------------------------------- Trajectory Drawing -----------------------------------------------------------


output[8:0] draw_address;
output draw_clock;
input[18:0] draw_pixelad;

assign draw_clock = ~clock;
assign draw_address = count - 32'd256;

draw_logic draw_logic_inst(
	.clock(clock),
	
	.pixeladdress(draw_pixelad),
	
	.start_drawing(draw_start),
	.finished_drawing(draw_finish),
	
	.mem_waddr(draw_waddr),
	.mem_wdata(draw_wdata),
	.mem_wenable(draw_wenable)
);




// Debugging

output typer_start_out, typer_finish_out, typer_busy_out;
output[31:0] count_out;

assign typer_start_out = typer_start;
assign typer_finish_out = typer_finish;
assign typer_busy_out = typer_busy;
assign count_out = count;

endmodule
