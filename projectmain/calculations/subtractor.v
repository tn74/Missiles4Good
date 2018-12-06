module subtractor(a, b, diff, ilt);
	input [31:0] a, b;
	
	output [31:0] diff;
	output ilt;

	wire [31:0] bn;
	wire diffovf;
	genvar i;
	generate
	for(i = 0; i < 32; i=i+1) begin : gen_bn
		not _not(bn[i], b[i]);
		end
	endgenerate
	adder _diff(a, bn, 1'b1, diff, diffovf);
	xor _ilt(ilt, diffovf, diff[31]);

endmodule