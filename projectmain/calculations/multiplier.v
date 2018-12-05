module multiplier(ap, bp, c, ex);
    input [31:0] ap, bp;

    output [31:0] c;
	 wire [63:0] out;
	 output ex;
	 
	 assign c[30:0] = out[30:0];
	 assign c[31] = out[63];
	 
	 lmult _lmult(ap, bp, out);
	 
	 assign ex = (|out[63:31])&&(~&out[63:31]);

//    wire [63:0] l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, l26, l27, l28, l29, l30, l31;
//	 wire [31:0] an, bn, a, b, cn;
//	 wire aignore, bignore, cignore;
//	 wire negans;
//	 
//	 
//	subtractor _an(32'b0, ap, an, aignore);
//	subtractor _bn(32'b0, bp, bn, bignore);
//	
//	assign a = ap[31] ? an : ap;
//	assign b = bp[31] ? bn : bp;
//	
//   assign l0[63:32] = 32'b0;
//   assign l1[63:33] = 31'b0;
//   assign l2[63:34] = 30'b0;
//   assign l3[63:35] = 29'b0;
//   assign l4[63:36] = 28'b0;
//   assign l5[63:37] = 27'b0;
//   assign l6[63:38] = 26'b0;
//   assign l7[63:39] = 25'b0;
//   assign l8[63:40] = 24'b0;
//   assign l9[63:41] = 23'b0;
//   assign l10[63:42] = 22'b0;
//   assign l11[63:43] = 21'b0;
//   assign l12[63:44] = 20'b0;
//   assign l13[63:45] = 19'b0;
//   assign l14[63:46] = 18'b0;
//   assign l15[63:47] = 17'b0;
//   assign l16[63:48] = 16'b0;
//   assign l17[63:49] = 15'b0;
//   assign l18[63:50] = 14'b0;
//   assign l19[63:51] = 13'b0;
//   assign l20[63:52] = 12'b0;
//   assign l21[63:53] = 11'b0;
//   assign l22[63:54] = 10'b0;
//   assign l23[63:55] = 9'b0;
//   assign l24[63:56] = 8'b0;
//   assign l25[63:57] = 7'b0;
//   assign l26[63:58] = 6'b0;
//   assign l27[63:59] = 5'b0;
//   assign l28[63:60] = 4'b0;
//   assign l29[63:61] = 3'b0;
//   assign l30[63:62] = 2'b0;
//   assign l31[63] = 1'b0;
//	
//	assign l1[0] = 1'b0;
//	assign l2[1:0] = 2'b0;
//	assign l3[2:0] = 3'b0;
//	assign l4[3:0] = 4'b0;
//	assign l5[4:0] = 5'b0;
//	assign l6[5:0] = 6'b0;
//	assign l7[6:0] = 7'b0;
//	assign l8[7:0] = 8'b0;
//	assign l9[8:0] = 9'b0;
//	assign l10[9:0] = 10'b0;
//	assign l11[10:0] = 11'b0;
//	assign l12[11:0] = 12'b0;
//	assign l13[12:0] = 13'b0;
//	assign l14[13:0] = 14'b0;
//	assign l15[14:0] = 15'b0;
//	assign l16[15:0] = 16'b0;
//	assign l17[16:0] = 17'b0;
//	assign l18[17:0] = 18'b0;
//	assign l19[18:0] = 19'b0;
//	assign l20[19:0] = 20'b0;
//	assign l21[20:0] = 21'b0;
//	assign l22[21:0] = 22'b0;
//	assign l23[22:0] = 23'b0;
//	assign l24[23:0] = 24'b0;
//	assign l25[24:0] = 25'b0;
//	assign l26[25:0] = 26'b0;
//	assign l27[26:0] = 27'b0;
//	assign l28[27:0] = 28'b0;
//	assign l29[28:0] = 29'b0;
//	assign l30[29:0] = 30'b0;
//	assign l31[30:0] = 31'b0;
//
//	 
//	 genvar i;
//	 generate
//	 for(i = 0; i < 32; i=i+1) begin : gen_and0
//		and _and(l0[i], a[0], b[i]);
//		end
//	 endgenerate
//	 
//	 generate
//	 for(i = 1; i < 33; i=i+1) begin : gen_and1
//		and _and(l1[i], a[1], b[i-1]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 2; i < 34; i=i+1) begin : gen_and2
//		and _and(l2[i], a[2], b[i-2]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 3; i < 35; i=i+1) begin : gen_and3
//		and _and(l3[i], a[3], b[i-3]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 4; i < 36; i=i+1) begin : gen_and4
//		and _and(l4[i], a[4], b[i-4]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 5; i < 37; i=i+1) begin : gen_and5
//		and _and(l5[i], a[5], b[i-5]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 6; i < 38; i=i+1) begin : gen_and6
//		and _and(l6[i], a[6], b[i-6]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 7; i < 39; i=i+1) begin : gen_and7
//		and _and(l7[i], a[7], b[i-7]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 8; i < 40; i=i+1) begin : gen_and8
//		and _and(l8[i], a[8], b[i-8]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 9; i < 41; i=i+1) begin : gen_and9
//		and _and(l9[i], a[9], b[i-9]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 10; i < 42; i=i+1) begin : gen_and10
//		and _and(l10[i], a[10], b[i-10]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 11; i < 43; i=i+1) begin : gen_and11
//		and _and(l11[i], a[11], b[i-11]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 12; i < 44; i=i+1) begin : gen_and12
//		and _and(l12[i], a[12], b[i-12]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 13; i < 45; i=i+1) begin : gen_and13
//		and _and(l13[i], a[13], b[i-13]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 14; i < 46; i=i+1) begin : gen_and14
//		and _and(l14[i], a[14], b[i-14]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 15; i < 47; i=i+1) begin : gen_and15
//		and _and(l15[i], a[15], b[i-15]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 16; i < 48; i=i+1) begin : gen_and16
//		and _and(l16[i], a[16], b[i-16]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 17; i < 49; i=i+1) begin : gen_and17
//		and _and(l17[i], a[17], b[i-17]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 18; i < 50; i=i+1) begin : gen_and18
//		and _and(l18[i], a[18], b[i-18]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 19; i < 51; i=i+1) begin : gen_and19
//		and _and(l19[i], a[19], b[i-19]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 20; i < 52; i=i+1) begin : gen_and20
//		and _and(l20[i], a[20], b[i-20]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 21; i < 53; i=i+1) begin : gen_and21
//		and _and(l21[i], a[21], b[i-21]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 22; i < 54; i=i+1) begin : gen_and22
//		and _and(l22[i], a[22], b[i-22]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 23; i < 55; i=i+1) begin : gen_and23
//		and _and(l23[i], a[23], b[i-23]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 24; i < 56; i=i+1) begin : gen_and24
//		and _and(l24[i], a[24], b[i-24]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 25; i < 57; i=i+1) begin : gen_and25
//		and _and(l25[i], a[25], b[i-25]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 26; i < 58; i=i+1) begin : gen_and26
//		and _and(l26[i], a[26], b[i-26]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 27; i < 59; i=i+1) begin : gen_and27
//		and _and(l27[i], a[27], b[i-27]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 28; i < 60; i=i+1) begin : gen_and28
//		and _and(l28[i], a[28], b[i-28]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 29; i < 61; i=i+1) begin : gen_and29
//		and _and(l29[i], a[29], b[i-29]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 30; i < 62; i=i+1) begin : gen_and30
//		and _and(l30[i], a[30], b[i-30]);
//		end
//	 endgenerate
//
//	 generate
//	 for(i = 31; i < 63; i=i+1) begin : gen_and31
//		and _and(l31[i], a[31], b[i-31]);
//		end
//	 endgenerate
//	 
//	 
//	 wire [63:0] m0, m1, m2, m3, m4, m5, m6, m7, m8, m9, m10, m11, m12, m13, m14, m15;
//	 wire movf[15:0];
//
//	  adder64 _adderm0(l0, l1, 1'b0, m0, movf[0]);
//	  adder64 _adderm1(l2, l3, 1'b0, m1, movf[1]);
//	  adder64 _adderm2(l4, l5, 1'b0, m2, movf[2]);
//	  adder64 _adderm3(l6, l7, 1'b0, m3, movf[3]);
//	  adder64 _adderm4(l8, l9, 1'b0, m4, movf[4]);
//	  adder64 _adderm5(l10, l11, 1'b0, m5, movf[5]);
//	  adder64 _adderm6(l12, l13, 1'b0, m6, movf[6]);
//	  adder64 _adderm7(l14, l15, 1'b0, m7, movf[7]);
//	  adder64 _adderm8(l16, l17, 1'b0, m8, movf[8]);
//	  adder64 _adderm9(l18, l19, 1'b0, m9, movf[9]);
//	  adder64 _adderm10(l20, l21, 1'b0, m10, movf[10]);
//	  adder64 _adderm11(l22, l23, 1'b0, m11, movf[11]);
//	  adder64 _adderm12(l24, l25, 1'b0, m12, movf[12]);
//	  adder64 _adderm13(l26, l27, 1'b0, m13, movf[13]);
//	  adder64 _adderm14(l28, l29, 1'b0, m14, movf[14]);
//	  adder64 _adderm15(l30, l31, 1'b0, m15, movf[15]);
//  
//  
//	 wire [63:0] n0, n1, n2, n3, n4, n5, n6, n7;
//	 wire novf[7:0];
//
//	  adder64 _addern0(m0, m1, 1'b0, n0, novf[0]);
//	  adder64 _addern1(m2, m3, 1'b0, n1, novf[1]);
//	  adder64 _addern2(m4, m5, 1'b0, n2, novf[2]);
//	  adder64 _addern3(m6, m7, 1'b0, n3, novf[3]);
//	  adder64 _addern4(m8, m9, 1'b0, n4, novf[4]);
//	  adder64 _addern5(m10, m11, 1'b0, n5, novf[5]);
//	  adder64 _addern6(m12, m13, 1'b0, n6, novf[6]);
//	  adder64 _addern7(m14, m15, 1'b0, n7, novf[7]);
//	  
//	    
//	 wire [63:0] p0, p1, p2, p3;
//	 wire povf[3:0];
//
//	  adder64 _adderp0(n0, n1, 1'b0, p0, povf[0]);
//	  adder64 _adderp1(n2, n3, 1'b0, p1, povf[1]);
//	  adder64 _adderp2(n4, n5, 1'b0, p2, povf[2]);
//	  adder64 _adderp3(n6, n7, 1'b0, p3, povf[3]);
//	  
//	  	    
//	 wire [63:0] q0, q1;
//	 wire qovf[2:0];
//
//	  adder64 _adderq0(p0, p1, 1'b0, q0, qovf[0]);
//	  adder64 _adderq1(p2, p3, 1'b0, q1, qovf[1]);
//	  
//	 wire [63:0] fin;
//	 wire finovf;
//	  adder64 _adderfin(q0, q1, 1'b0, fin, finovf);
//	  
//	  wire notap31, abovf, notbp31, abex;
//	  not _notap31(notap31, ap[31]);
//	  not _notbp31(notbp31, bp[31]);
//	  and _abovf(abovf, fin[31], notap31, notbp31);
//   or _or(abex, abovf, fin[32], fin[33], fin[34], fin[35], fin[36], fin[37], fin[38], fin[39], fin[40], fin[41], fin[42], fin[43], fin[44], fin[45], fin[46], fin[47], fin[48], fin[49], fin[50], fin[51], fin[52], fin[53], fin[54], fin[55], fin[56], fin[57], fin[58], fin[59], fin[60], fin[61], fin[62], fin[63]);
//	assign ex = abex||((c[31]^(ap[31]^bp[31]))&&(|ap)&&(|bp));
//	  
//	subtractor _cn(32'b0, fin[31:0], cn, cignore);
//	
//	xor _negans(negans, ap[31], bp[31]);
//	  assign c = negans ? cn : fin[31:0];
//	  
	  
endmodule
