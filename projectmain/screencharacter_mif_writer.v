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
	rd_out
);

input clock, fire;
input[7:0] velocity, angle;
input[31:0] targetx, targety;
input[255:0] ps2_line_content;
input ps2_line_ready;

input[7:0] rd_add;
input rd_clk;
output[7:0] rd_out;


screenchar_mem smem (
	.rdaddress(rd_add),
	.rdclock(rd_clk),
	.q(rd_out),
	
	.data(8'h50),
	.wraddress(8'h40),
	.wrclock(~clock),
	.wren(1'b0),
);



endmodule
