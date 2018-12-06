module pwm_controller_deprecated (
	signal,
	status,
	clock_counter,
	pwm_counter,
	button,
	clock
//	angle
);

	output signal, status;
	output [31:0] clock_counter, pwm_counter;
	input clock/*, angle*/, button; // clock should be 20 ns
	
	reg signal, status;
	reg [31:0] clock_counter, pwm_counter, top, bot, delay_counter, speed;
	reg [63:0] timer;
	
	initial begin
		clock_counter <= 32'b0;
		pwm_counter <= 32'b0;
		delay_counter <= 32'd0;
		signal <= 1'b1;
		status <= 1'b0;
		top <= 32'd90000;
		bot <= 32'd50000;
		speed <= 32'd65000;
		timer <= 64'b0;
	end
	
	always @(posedge clock) begin
		if (button == 1'b0) begin
			status = 1'b1;
		end
		
		
		if (status == 1'b1) begin
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
	//		
	//		else begin
				clock_counter = clock_counter + 1;
				pwm_counter = pwm_counter + 1;
				delay_counter = delay_counter + 1;
				timer = timer + 1;
	//		end
			
			if (delay_counter > 32'd10000000) begin
				speed = speed + 2000;
				if (speed >= top) begin
					speed = bot;
				end
				delay_counter = 32'b0;
			end
			
			if (timer >= 64'd250000000) begin
				status = 1'b0;
				timer = 32'b0; 
			end
		end
	end
	
	
	

endmodule 