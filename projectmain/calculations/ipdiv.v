module ipdiv(ddp, dsp, qout, ex);


	input [31:0] ddp, dsp;
	output [31:0] qout;
	output ex;
	wire negans, igdsnilt, igddnilt, igqnilt;
	wire [31:0] q, qn, dd, ddn, ds, dsn, qnoex;
	
	subtractor _dsn(32'b0, dsp, dsn, igdsnilt);
	subtractor _ddn(32'b0, ddp, ddn, igddnilt);
	
	assign ds = dsp[31] ? dsn : dsp;
	assign dd = ddp[31] ? ddn : ddp;
	
   nor _nor(ex, dsp[0], dsp[1], dsp[2], dsp[3], dsp[4], dsp[5], dsp[6], dsp[7], dsp[8], dsp[9], dsp[10], dsp[11], dsp[12], dsp[13], dsp[14], dsp[15], dsp[16], dsp[17], dsp[18], dsp[19], dsp[20], dsp[21], dsp[22], dsp[23], dsp[24], dsp[25], dsp[26], dsp[27], dsp[28], dsp[29], dsp[30], dsp[31]);

	assign q = dd/ds;
	
	subtractor _qn(32'b0, q, qn, igqnilt);
	
	xor _negans(negans, ddp[31], dsp[31]);
	assign qnoex = negans ? qn : q;
	
	assign qout = ex ? 32'b0 : qnoex;
	
endmodule