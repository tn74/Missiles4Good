module shooter_pwm_controller (
	signal,
	clock,
	velocity
);

	input clock;
	input [31:0] velocity; // between 0 and 20000
	output signal;
	
	reg signal;
	reg [31:0] clock_counter, pwm_counter, duty_cycle;
	
	initial begin
		signal = 1'b1;
		clock_counter = 32'b0;
		pwm_counter = 32'b0;
		duty_cycle = 32'd60000;
	end
	
	always @(posedge clock) begin
		duty_cycle = 32'd5 * velocity;
		
		if (clock_counter > 32'd100000) begin // 500ish hz is 98000, 102000 for 490 hz
			signal = 1'b1;
			clock_counter = 32'b0;
			pwm_counter = 32'b0;
		end
		
		else if (pwm_counter > duty_cycle) begin
			signal = 1'b0;
		end
		
		clock_counter = clock_counter + 1;
		pwm_counter = pwm_counter + 1;
		
	end
	

endmodule 