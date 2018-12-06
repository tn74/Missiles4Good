module range(speed, init, range, ctrl, clk, rdy);

	//All units in mm

	input [31:0] speed, init;
	input ctrl, clk;
	output rdy;
	
	output [31:0] range;
	
	wire [31:0] radical, q, remainder, rrange;
	
	assign radical = (speed*7/10)*(speed*7/10)+2*9800*init;
	
	sqrt _sqrt(radical, q, remainder);
	
	assign range = (speed*7/98)*((speed*7/10)+q)/1000;
	
	counter _count(clk, ctrl, ctrl, rdy);
	 
endmodule