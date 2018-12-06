module theta_rotate (
	signal,
	clock,
	angle
);

	input clock;
	input [31:0] angle; // between 0 and 180
	output signal;
	
	reg signal;
	reg [31:0] clock_counter, pwm_counter, speed;
	
	initial begin
		signal = 1'b1;
		clock_counter = 32'b0;
		pwm_counter = 32'b0;
		speed = 32'd75000;
	end
	
	always @(posedge clock) begin
		speed = 32'd500 * angle + 32'd30000;
		
		if (clock_counter > 32'd1000000) begin
			signal = 1'b1;
			clock_counter = 32'b0;
			pwm_counter = 32'b0;
		end
		
		else if (pwm_counter > speed) begin
			signal = 1'b0;
		end
		
		clock_counter = clock_counter + 1;
		pwm_counter = pwm_counter + 1;
		
	end
	

endmodule 