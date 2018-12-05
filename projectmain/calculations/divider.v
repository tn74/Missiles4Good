module divider(ddp, dsp, qout, ex, rem);
	
	input [31:0] ddp, dsp;
	output [31:0] qout, rem;
	output ex;
	
	ldiv _ldiv(dsp, ddp, qout, rem);
	
//	wire [31:0] rqb0, rqb1, rqb2, rqb3, rqb4, rqb5, rqb6, rqb7, rqb8, rqb9, rqb10, rqb11, rqb12, rqb13, rqb14, rqb15, rqb16, rqb17, rqb18, rqb19, rqb20, rqb21, rqb22, rqb23, rqb24, rqb25, rqb26, rqb27, rqb28, rqb29, rqb30, rqb31;
//	wire [31:0] sh0, sh1, sh2, sh3, sh4, sh5, sh6, sh7, sh8, sh9, sh10, sh11, sh12, sh13, sh14, sh15, sh16, sh17, sh18, sh19, sh20, sh21, sh22, sh23, sh24, sh25, sh26, sh27, sh28, sh29, sh30, sh31;
//	wire [31:0] q, qn, dd, ddn, ds, dsn, qnoex;
//	wire negans, igqnilt, igddnilt, igdsnilt;
//	
   nor _nor(ex, dsp[0], dsp[1], dsp[2], dsp[3], dsp[4], dsp[5], dsp[6], dsp[7], dsp[8], dsp[9], dsp[10], dsp[11], dsp[12], dsp[13], dsp[14], dsp[15], dsp[16], dsp[17], dsp[18], dsp[19], dsp[20], dsp[21], dsp[22], dsp[23], dsp[24], dsp[25], dsp[26], dsp[27], dsp[28], dsp[29], dsp[30], dsp[31]);
//	
//	subtractor _dsn(32'b0, dsp, dsn, igdsnilt);
//	subtractor _ddn(32'b0, ddp, ddn, igddnilt);
//	
//	assign ds = dsp[31] ? dsn : dsp;
//	assign dd = ddp[31] ? ddn : ddp;
//
//
//	divone _n0(ds, dd, rqb0, 32'h0000001F, sh0, q[31]);
//	divone _n1(ds, rqb0, rqb1, sh0, sh1, q[30]);
//	divone _n2(ds, rqb1, rqb2, sh1, sh2, q[29]);
//	divone _n3(ds, rqb2, rqb3, sh2, sh3, q[28]);
//	divone _n4(ds, rqb3, rqb4, sh3, sh4, q[27]);
//	divone _n5(ds, rqb4, rqb5, sh4, sh5, q[26]);
//	divone _n6(ds, rqb5, rqb6, sh5, sh6, q[25]);
//	divone _n7(ds, rqb6, rqb7, sh6, sh7, q[24]);
//	divone _n8(ds, rqb7, rqb8, sh7, sh8, q[23]);
//	divone _n9(ds, rqb8, rqb9, sh8, sh9, q[22]);
//	divone _n10(ds, rqb9, rqb10, sh9, sh10, q[21]);
//	divone _n11(ds, rqb10, rqb11, sh10, sh11, q[20]);
//	divone _n12(ds, rqb11, rqb12, sh11, sh12, q[19]);
//	divone _n13(ds, rqb12, rqb13, sh12, sh13, q[18]);
//	divone _n14(ds, rqb13, rqb14, sh13, sh14, q[17]);
//	divone _n15(ds, rqb14, rqb15, sh14, sh15, q[16]);
//	divone _n16(ds, rqb15, rqb16, sh15, sh16, q[15]);
//	divone _n17(ds, rqb16, rqb17, sh16, sh17, q[14]);
//	divone _n18(ds, rqb17, rqb18, sh17, sh18, q[13]);
//	divone _n19(ds, rqb18, rqb19, sh18, sh19, q[12]);
//	divone _n20(ds, rqb19, rqb20, sh19, sh20, q[11]);
//	divone _n21(ds, rqb20, rqb21, sh20, sh21, q[10]);
//	divone _n22(ds, rqb21, rqb22, sh21, sh22, q[9]);
//	divone _n23(ds, rqb22, rqb23, sh22, sh23, q[8]);
//	divone _n24(ds, rqb23, rqb24, sh23, sh24, q[7]);
//	divone _n25(ds, rqb24, rqb25, sh24, sh25, q[6]);
//	divone _n26(ds, rqb25, rqb26, sh25, sh26, q[5]);
//	divone _n27(ds, rqb26, rqb27, sh26, sh27, q[4]);
//	divone _n28(ds, rqb27, rqb28, sh27, sh28, q[3]);
//	divone _n29(ds, rqb28, rqb29, sh28, sh29, q[2]);
//	divone _n30(ds, rqb29, rqb30, sh29, sh30, q[1]);
//	divone _n31(ds, rqb30, rqb31, sh30, sh31, q[0]);
//
//	subtractor _qn(32'b0, q, qn, igqnilt);
//
//	
//	xor _negans(negans, ddp[31], dsp[31]);
//	assign qnoex = negans ? qn : q;
//	
//	assign qout = ex ? 32'b0 : qnoex;
	
endmodule