module multi_launcher(
	clock, queue, takeover,
	angle_in, velocity_in, 
	
	angle_out, velocity_out, fire_out, 
	target0, target1, target2,
	autonomous_mode);
	
input clock, queue, takeover;
input[31:0] angle_in, velocity_in;

output reg[31:0] angle_out, velocity_out;
output reg[31:0] target0, target1, target2;
output reg autonomous_mode, fire_out;

reg[31:0] autonomous_sequence_count;	
reg[31:0] VELS[2:0], ANGS[2:0];
reg[31:0] TARGET_COUNT;


parameter PARAM_TIME = 200000000;
parameter FIRE_TIME = 120000000;
parameter TAKEOVER_CYCLES = 3 * (PARAM_TIME + FIRE_TIME);


initial begin 
	TARGET_COUNT <= 32'd0;
	autonomous_sequence_count <= TAKEOVER_CYCLES;
end


always @(posedge clock) begin
	
	if (takeover) begin
		autonomous_sequence_count <= 32'd0;
		TARGET_COUNT <= 32'd0;
		angle_out <= ANGS[0];
		velocity_out <= VELS[0];
	end else if (autonomous_sequence_count < TAKEOVER_CYCLES) begin
				
		if (autonomous_sequence_count == PARAM_TIME) begin
			fire_out <= 1'b1;
		end else if (autonomous_sequence_count == PARAM_TIME + 1) begin
			fire_out <= 1'b0;
			
		end else if (autonomous_sequence_count == PARAM_TIME + FIRE_TIME) begin
			angle_out <= ANGS[1];
			velocity_out <= VELS[1];
			
		end else if (autonomous_sequence_count ==  2*PARAM_TIME + FIRE_TIME) begin
			fire_out <= 1'b1;
		end else if (autonomous_sequence_count == 2*PARAM_TIME + FIRE_TIME + 1) begin
			fire_out <= 1'b0;
			
		end else if (autonomous_sequence_count == 2*PARAM_TIME + 2*FIRE_TIME) begin
			angle_out <= ANGS[2];
			velocity_out <= VELS[2];
		end else if (autonomous_sequence_count == 3*PARAM_TIME + 2*FIRE_TIME) begin
			fire_out <= 1'b1;
		end else if (autonomous_sequence_count == 3*PARAM_TIME + 2*FIRE_TIME + 1) begin
			fire_out <= 1'b0;
		end
		
		autonomous_sequence_count <= autonomous_sequence_count + 1;
	end else begin
		if (queue) begin
			VELS[TARGET_COUNT] <= velocity_in;
			ANGS[TARGET_COUNT] <= angle_in;
			TARGET_COUNT <= (TARGET_COUNT + 1) % 3;
		end
	end
	autonomous_mode <= (autonomous_sequence_count < TAKEOVER_CYCLES);
end

endmodule
