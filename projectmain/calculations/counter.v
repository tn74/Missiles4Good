module counter(clk, reset, start, tic);

	input clk, reset, start;
	output tic;
	wire [31:0] q;

	assign tic = q[10];
	
	wire resetn;
	
	not _not(resetn, reset);
	
	dflipflop _dffe0(start, clk, 1'b1, 1'b1, 1'b1, q[0]);
	genvar i;
	generate
	for(i = 1; i<32; i=i+1) begin : gen_dffe
		dflipflop _dffe(q[i-1], clk, resetn, 1'b1, 1'b1, q[i]);
		end
	endgenerate
	
endmodule