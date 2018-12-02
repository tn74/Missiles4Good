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
		else if (in == 8'h2b) // F
			out = 8'h46;
		else if (in == 8'h34) // G
			out = 8'h47;
		else if (in == 8'h33) // H
			out = 8'h48;
		else if (in == 8'h43) // I
			out = 8'h49;
		else if (in == 8'h3b) // J
			out = 8'h4A;
		else if (in == 8'h42) // K
			out = 8'h4B;
		else if (in == 8'h4b) // L
			out = 8'h4C;
		else if (in == 8'h3A) // M
			out = 8'h4D;
		else if (in == 8'h31) // N
			out = 8'h4E;
		else if (in == 8'h44) // O
			out = 8'h4F;
		else if (in == 8'h4D) // P
			out = 8'h50;
		else if (in == 8'h15) // Q
			out = 8'h51;
		else if (in == 8'h2D) // R
			out = 8'h52;
		else if (in == 8'h1b) // S
			out = 8'h53;
		else if (in == 8'h2C) // T
			out = 8'h54;
		else if (in == 8'h3C) // U
			out = 8'h55;
		else if (in == 8'h2A) // V
			out = 8'h56;
		else if (in == 8'h1D) // W
			out = 8'h57;
		else if (in == 8'h22) // X
			out = 8'h58;
		else if (in == 8'h35) // Y
			out = 8'h59;
		else if (in == 8'h1A) // z
			out = 8'h5A;
		else if (in == 8'h29) // z
			out = 8'h20;
		else 
			out = 8'h00;
	end

endmodule
