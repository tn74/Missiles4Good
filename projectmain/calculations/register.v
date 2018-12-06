module register(
	clock,
	enable,
	reset,
	write,
   read
);

   input clock, enable, reset;
   input [31:0] write;

   output [31:0] read;
	
	genvar i;
	generate
	for(i = 0; i < 32; i=i+1) begin : gen_dffe
		dffe_ref dffe(read[i], write[i], clock, enable, reset);
		end
	endgenerate
	
endmodule 