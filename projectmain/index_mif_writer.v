module index_mif_writer(
	clock,
	velocity,
	fire,
	angle,
	targetx_0,
	targetx_1,
	targetx_2,
	targetx_3,
	targety_0,
	targety_1,
	targety_2,
	targety_3,
	trajectory_memloc,
	trajectory_memloc_enable,
	
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
input[7:0] velocity, angle;
input fire;
input[31:0] targetx_0, targetx_1, targetx_2, targetx_3;
input[31:0] targety_0, targety_1, targety_2, targety_3;
input[31:0] trajectory_memloc, trajectory_memloc_enable;
output[18:0] mem_waddr;
output[2:0] mem_wdata;
output mem_wenable; 


reg typer_busy;
wire[18:0] typer_waddr;
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



//always@(posedge typer_start, negedge typer_finish)
//begin
//	typer_busy <= ~typer_busy;
//end


typer_logic typer_inst(
	 .clock(clock),
	 .row_num(8'h00),
	 .col_num(8'h00),
	 .character_input(8'h41),
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


// Debugging

output typer_start_out, typer_finish_out, typer_busy_out;
output[31:0] count_out;

assign typer_start_out = typer_start;
assign typer_finish_out = typer_finish;
assign typer_busy_out = typer_busy;
assign count_out = count;

endmodule
