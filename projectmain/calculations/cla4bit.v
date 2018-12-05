module cla4bit(
	p,
	g,
	cin,
	c,
	np,
	ng
);

	input [3:0] p, g;
	input cin;
	
	output [3:0] c;
	output np, ng;
	
	//np
	and _and0(np, p[3], p[2], p[1], p[0]);
	
	//ng
	wire and1, and2, and3;
	and _and1(and1, p[3], p[2], p[1], g[0]);
	and _and2(and2, p[3], p[2], g[1]);
	and _and3(and3, p[3], g[2]);
	or _or0(ng, and1, and2, and3, g[3]);
	
	//c0
	wire and4;
	and _and4(and4, p[0], cin);
	or _or1(c[0], g[0], and4);
	
	//c1
	wire and5, and6;
	and _and5(and5, p[1], p[0], cin);
	and _and6(and6, p[1], g[0]);
	or _or2(c[1], g[1], and5, and6);
	
	//c2
	wire and7, and8, and9;
	and _and7(and7, p[2], p[1], p[0], cin);
	and _and8(and8, p[2], p[1], g[0]);
	and _and9(and9, p[2], g[1]);
	or _or3(c[2], g[2], and7, and8, and9);
	
	//c3
	wire and10, and11, and12, and13;
	and _and10(and10, p[3], p[2], p[1], p[0], cin);
	and _and11(and11, p[3], p[2], p[1], g[0]);
	and _and12(and12, p[3], p[2], g[1]);
	and _and13(and13, p[3], g[2]);
	or _or4(c[3], g[3], and10, and11, and12, and13);
	
	
endmodule