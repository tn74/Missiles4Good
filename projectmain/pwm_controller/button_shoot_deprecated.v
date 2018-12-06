`timescale 1ns/100ps
module button_shoot_deprecated (
	signal,
	button
);
	output signal;
	input button;
	
	reg signal;
	
//	initial begin
//		signal = 1'b0;		
//		repeat (100) begin 
//			signal = 1'b1;
//			#1000000; // 1e6, for 1000 us
//			signal = 1'b0;
//			#19000000; //2e7 - 1e6
//		end
//	end
//	
	
	always @(negedge button) begin
		repeat (100) begin 
			signal = 1'b1;
			#1800000; // 1e6, for 1800 us
			signal = 1'b0;
			#18200000; //2e7 - 1e6
		end
		#2000000000;
		repeat (100) begin
			signal = 1'b1;
			#1000000;	// 1.8e6, for 1800 us
			signal = 1'b0;
			#19000000; // 2e7 - 1.8e6
		end
	end

endmodule 