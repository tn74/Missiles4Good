module trajectory_mif_writer(
	clock,
	trajectory_memloc,
	trajectory_memloc_enable,
	rd_draw_add,
	rd_draw_clk,
	rd_draw_out
);

	input clock;
	input[18:0] trajectory_memloc;
	input trajectory_memloc_enable;
	input[8:0] rd_draw_add;
	input rd_draw_clk;
	
	output[18:0] rd_draw_out;


	reg[31:0] count;
	
	initial begin
		count <= 32'd0;
	end
	
	always @(posedge clock) begin
	if (trajectory_memloc_enable) begin
		if (count < 300) begin
			count <= count + 32'd1;
		end else 
			count <= 32'd0;
		end
	end

	draw_trajectories_mem draw_traj_inst(
		.rdaddress(rd_draw_add),
		.rdclock(rd_draw_clk),
		.q(rd_draw_out),

		.data(trajectory_memloc),
		.wraddress(count[8:0]),
		.wrclock(clock),
		.wren(trajectory_memloc_enable),
	);


endmodule
