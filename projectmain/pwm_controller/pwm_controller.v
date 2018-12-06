module pwm_controller(
	arm_signal,
	theta_signal,
	motor_signal,
	clock,
	shoot_enable,
	angle_in,
	velocity_in
);

	output arm_signal, theta_signal, motor_signal;
	input clock, shoot_enable;
	input [31:0] angle_in, velocity_in;
	
	arm_controller arm(.signal(arm_signal), .clock(clock), .enable(shoot_enable));
	theta_rotate theta(.signal(theta_signal), .clock(clock), .angle(angle_in));
	shooter_pwm_controller motor(.signal(motor_signal), .clock(clock), .velocity(velocity_in));
	
endmodule 