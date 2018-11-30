module screen_row_counter(clock, start, finish, countreg_out);
	
	input clock, start;
	output finish;
	output[31:0] countreg_out;
	
	wire[31:0] countreg_in;
	reg[31:0] countreg;
	
	assign countreg_out = countreg;
	
	assign finish = countreg[29];
	assign countreg_in[31:1] = countreg[30:0];
	assign countreg_in[0] = 1'b0;
	
	initial
	begin
		countreg <= 32'h0000000f;
	end
	
	always @(posedge clock)
	begin
		if (start)
			countreg <= 29'h00000001;
		else
			countreg <= countreg_in;
	end
	
endmodule
