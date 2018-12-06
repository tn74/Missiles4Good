module adder1bit(
	a,
	b,
	c,
	s,
	p,
	g
);

	input a, b, c;
	
	output s, p, g;
	
	and _and0(g, a, b);
	xor _xor0(p, a, b);
	xor _xor1(s, p, c);
	
endmodule