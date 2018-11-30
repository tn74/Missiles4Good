module ps2_to_ascii (in, out);
	input[7:0] in;
	output reg[7:0] out;
	
	always @(in)
	begin
		if (in == 8'h1c) // A
			out = 8'h41;
		else if (in == 8'h32) // B
			out = 8'h42;
		else if (in == 8'h21) // C
			out = 8'h43;
			
		else if (in == 8'h23) // D
			out = 8'h44;
			
		else if (in == 8'h24) // E
			out = 8'h45;
			
		else if (in == 8'h26) // F
			out = 8'h46;
		
		else 
			out = 8'h00;
	end

endmodule
