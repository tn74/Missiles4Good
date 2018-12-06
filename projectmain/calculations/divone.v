module divone(ds, rqbin, rqbout, shin, shout, q);

	input [31:0] ds, rqbin, shin;
	output [31:0] rqbout, shout;
	output q;
	
	wire igilt0, igilt1, ilt;
	wire [31:0] rqbsra, igdiff, dssll, rqbres;
	
	subtractor _decrsh(shin, 32'h00000001, shout, igilt0);
	
	sra _sra(rqbin, shin[4:0], rqbsra);
	
	subtractor _chilt(rqbsra, ds, igdiff, ilt);
	
	not _getq(q, ilt);
	
	sll _sll(ds, shin[4:0], dssll);
	
	subtractor _calcrqb(rqbin, dssll, rqbres, igilt1);

	assign rqbout = q ? rqbres : rqbin;
	
endmodule



