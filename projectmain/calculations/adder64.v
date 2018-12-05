module adder64(
	a,
	b,
	cin,
	s,
	overflow
);

	input[63:0] a, b;
	input cin;
	
	
	output[63:0] s;
	output overflow;
	wire cout;
	
	
	wire[63:0] p, g, c;
	adder1bit _adder1bit0(a[0], b[0], cin, s[0], p[0], g[0]);
   genvar i;
	generate
	for(i = 1; i < 64; i=i+1) begin : gen_adderbits
		adder1bit _adder1bit1(a[i], b[i], c[i-1], s[i], p[i], g[i]);
		end
	endgenerate
	
	
	wire [15:0] ng, np, nc;
	cla4bit _cla4bit0(p[3:0], g[3:0], cin, c[3:0], np[0], ng[0]);
	generate
	for(i = 4; i < 64; i=i+4) begin : gen_cla16bits
		cla4bit _cla4bit1(p[i+3:i], g[i+3:i], nc[i/4-1], c[i+3:i], np[i/4], ng[i/4]);
		end
	endgenerate
	
	wire [3:0] nng, nnp, nnc;
	cla4bit _cla4bit1(np[3:0], ng[3:0], cin, nc[3:0], nnp[0], nng[0]);	
	generate
	for(i = 4; i < 16; i=i+4) begin : gen_cla4bits
		cla4bit _cla4bit1(np[i+3:i], ng[i+3:i], nnc[i/4-1], nc[i+3:i], nnp[i/4], nng[i/4]);
		end
	endgenerate
	
	wire nnnp, nnng;
	
	cla4bit _cla4bit2(nnp[3:0], nng[3:0], cin, nnc[3:0], nnnp, nnng);
	
	/*cout
	wire and1, and2;
	and _and1(and1, nnp[1], nnp[0], cin);
	and _and2(and2, nnp[1], nng[0]);
	or _or1(cout, nng[1], and1, and2);*/
	
	xor _xor(overflow, c[62], c[63]);

endmodule