module shooter_pwm_button (
	clock,
	speed,
	up,
	down,
	signal
);

	input clock, up, down;
	input [31:0] speed; // between 0 and 255
	output signal;
	
	reg signal;
	reg [31:0] clock_counter, pwm_counter, duty_cycle, speed_counter;
	
	initial begin
		signal = 1'b1;
		clock_counter = 32'b0;
		pwm_counter = 32'b0;
		speed_counter = 32'b0;
//		speed = 32'd75000;
		duty_cycle = 32'd50000;
	end
	
	always @(posedge clock) begin
		if (speed_counter > 32'd100000000) begin
			speed_counter = 32'b0;
			duty_cycle = duty_cycle + 32'd5000;
			if (duty_cycle > 32'd100000) begin
				duty_cycle = 32'd40000;
			end
		end
		if (clock_counter > 32'd102000) begin // 500ish hz is 98000, 102000 for 490 hz
			signal = 1'b1;
			clock_counter = 32'b0;
			pwm_counter = 32'b0;
		end
		
		else if (pwm_counter > duty_cycle) begin
			signal = 1'b0;
		end
		
		clock_counter = clock_counter + 1;
		pwm_counter = pwm_counter + 1;
		speed_counter = speed_counter + 1;
	end
	

endmodule 