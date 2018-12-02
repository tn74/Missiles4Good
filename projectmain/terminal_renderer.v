module terminal_renderer(
	clock,
	bgr_data,
	address,
	character_array
);

input clock;
input[18:0] address;
input[32*7*8 - 1:0] character_array;
output[24:0] bgr_data;

wire[7:0] charray[6:0][31:0];

reg[31:0] icrow, iccol, chrow, chcol, pr, pc, addr, offset;
reg[599:0] character_data;
reg[7:0] character_byteval;

parameter WIDTH = 640;
parameter HEIGHT = 440;

parameter CHAR_HEIGHT = 30;
parameter CHAR_WIDTH = 20;

parameter CHARRAY_HEIGHT = 7;
parameter CHARRAY_WIDTH = 32;

// Address to Character Translation

typer_data typer_data_inst(
	.address(character_byteval),
	.clock(~clock),
	.q(character_data)
);

always@(posedge clock)
begin
	addr <= address;
	pc <= addr % WIDTH;
	pr <= addr / WIDTH;
	chrow <= pr - (HEIGHT - CHARRAY_HEIGHT * CHAR_HEIGHT) / CHAR_HEIGHT;
	chcol <= pc / CHAR_WIDTH;
	icrow = pr - (HEIGHT - CHARRAY_HEIGHT * CHAR_HEIGHT) % CHAR_HEIGHT;
	iccol <= pc % CHAR_WIDTH;
	
	character_byteval <= charray[chrow][chcol];
end

always@(negedge clock)
begin
	offset <= icrow * CHAR_WIDTH + iccol;
	if (offset)
		bgr_data<=24'hffffff;
	else
		bgr_data<=24'hffffff;
end

endmodule
