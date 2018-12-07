module ps2_interpreter (clock, input_line, line_ready, velocity,  angle, fire, reset);
	
	input[255:0] input_line;
	input line_ready, clock;
	
	output reg[31:0] velocity;
	output reg[31:0] angle;
	output reg fire, reset;
	
	reg vready, aready;
	wire[47:0] vascii, aascii;
	wire[31:0] vt, at;
	
	initial
	begin
		velocity <= 32'd60;
		angle <= 32'd70;
	end
	
	// ------------------------- Readys ---------------------------------
	always @(posedge clock) begin
		if(line_ready & input_line[255: 255 - 39] == 40'h5345542041) // SET A XXX
			aready <= 1'b1;
		else 
			aready <= 1'b0;
			
		if(line_ready & input_line[255: 255 - 39] == 40'h5345542056) // SET V XXXXX
			vready <= 1'b1;
		else 
			vready <= 1'b0;
			
		if (line_ready & input_line[255: 255 - 31] == 32'h46495245)
			fire <= 1'b1;
		else
			fire <= 1'b0;
			
		if (line_ready & input_line[255: 255 - 39] == 40'h5245534554)
			reset <= 1'b1;
		else
			reset <= 1'b0;
	end
	
	
	// Velocity 
	assign vascii[47:40] = 8'h30;
	assign vascii[39:0] = input_line[255 - 6 * 8: 255 - 11 * 8 + 1];
	ascii6digit_to_number(vascii, vt);
	always @(posedge vready) begin
		velocity <= vt;
	end
	
	// Angle
	assign aascii[47:24] = 24'h303030;
	assign aascii[23:0] = input_line[255 - 6 * 8: 255 - 9 * 8 + 1];
	ascii6digit_to_number(aascii, at);
	always @(posedge aready) begin
		angle <= at;
	end
	
	
	
	
endmodule
