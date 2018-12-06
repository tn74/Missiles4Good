module shoot_once (
	clock,
	enable,
	signal
);
	output signal;
	input clock, enable;
	
	reg status, signal;
	reg [31:0] clock_counter, pwm_counter, stop_counter, speed;
	
	initial begin
		signal = 1'b1;
		status = 1'b0;
		clock_counter = 32'b0;
		pwm_counter = 32'b0;
		stop_counter = 32'b0;
		speed = 32'd75000;
	end
	
	always @(posedge clock) begin
		if (enable == 1'b1) begin
			status = 1'b1;
		end
		
		if (status == 1'b1) begin
			if (stop_counter < 32'd12500000) begin
				speed = 32'd80000;
			end
			else if (stop_counter < 32'd37500000) begin
				speed = 32'd50000;
			end
			else if (stop_counter < 32'd50000000) begin
				speed = 32'd80000;
			end
			else begin
				stop_counter = 32'b0;
				status = 1'b0;
			end
			
			if (clock_counter > 32'd1000000) begin // 1e6 for divider
				clock_counter = 32'b0;
				pwm_counter = 32'b0;
				signal = 1'b1;
			end
			// 65000 for 1300 us, 
			// 85000 for 1700 us
			else if (pwm_counter > speed) begin // 75000 for 1500 us
				signal = 1'b0;
			end
			
			clock_counter = clock_counter + 1;
			pwm_counter = pwm_counter + 1;
			stop_counter = stop_counter + 1;		
		end		
	end
	
endmodule 