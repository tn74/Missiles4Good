module ps2_interpreter (clock, input_line, line_ready, velocity,  angle, fire, reset, queue, launch, autonomous_mode);
	
	input[255:0] input_line;
	input line_ready, clock;
	
	output[31:0] velocity, angle;
	output fire, autonomous_mode;
	output reg reset, queue, launch;
	
	reg[31:0] velocity_user, angle_user;
	wire[31:0] velocity_auto, angle_auto;
	reg fire_user;
	wire fire_auto;
	
	reg vready, aready;
	wire[47:0] vascii, aascii;
	wire[31:0] vt, at;
	
	initial
	begin
		velocity_user <= 32'd60;
		angle_user <= 32'd70;
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
			
		if (line_ready & input_line[255: 255 - 31] == 32'h46495245) // FIRE
			fire_user <= 1'b1;
		else
			fire_user <= 1'b0;
			
		if (line_ready & input_line[255: 255 - 39] == 40'h5245534554) // RESET
			reset <= 1'b1;
		else
			reset <= 1'b0;
			
		if (line_ready & input_line[255: 255 - 47] == 48'h4c41554e4348) // LAUNCH
			launch <= 1'b1;
		else
			launch <= 1'b0;
			
		if (line_ready & input_line[255: 255 - 39] == 40'h5155455545) // QUEUE
			queue <= 1'b1;
		else
			queue <= 1'b0;
	end
	
	
	// Velocity 
	assign vascii[47:40] = 8'h30;
	assign vascii[39:0] = input_line[255 - 6 * 8: 255 - 11 * 8 + 1];
	ascii6digit_to_number(vascii, vt);
	always @(posedge vready) begin
		velocity_user <= vt;
	end
	
	// Angle
	assign aascii[47:24] = 24'h303030;
	assign aascii[23:0] = input_line[255 - 6 * 8: 255 - 9 * 8 + 1];
	ascii6digit_to_number(aascii, at);
	always @(posedge aready) begin
		angle_user <= at;
	end
	
	
	// Autonomus Launcher
	multi_launcher auto_launch(
	.clock(clock), 
	.queue(queue),
	.takeover(launch),
	.angle_in(angle_user), .velocity_in(velocity_user), 
	
	.angle_out(angle_auto), .velocity_out(velocity_auto), .fire_out(fire_auto),
//	target0, target1, target2,
	.autonomous_mode(autonomous_mode)
	); 
	
	assign velocity = autonomous_mode ? velocity_auto : velocity_user;
	assign angle = autonomous_mode ? angle_auto : angle_user;
	assign fire = autonomous_mode ? fire_auto : fire_user;
	
	
endmodule
