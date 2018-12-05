module multdiv(data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY, div_rem);
    input [31:0] data_operandA, data_operandB;
    input ctrl_MULT, ctrl_DIV, clock;

    output [31:0] data_result, div_rem;
    wire [31:0] mult_result, div_result, countind;
    output data_exception, data_resultRDY;
	 
	 wire start;
	 wire div;
	 wire mult_ex, div_ex;
	 
	 or _orstart(start, ctrl_DIV, ctrl_MULT);

	 dflipflop _divyes(ctrl_DIV, clock, 1'b1, 1'b1, start, div);
	 
	 multiplier _mult(data_operandA, data_operandB, mult_result, mult_ex);
	 divider _div(data_operandA, data_operandB, div_result, div_ex, div_rem);
	 
	 counter _count(clock, start, start, data_resultRDY);
	 
	 assign data_result = div ? div_result : mult_result ;
	 
	 assign data_exception = div ? div_ex : mult_ex;
	 
endmodule
