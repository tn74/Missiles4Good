module alu(data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt;

   output [31:0] data_result;
   output isNotEqual, isLessThan, overflow;
	
	wire [31:0] selop;
	decoder _selop(ctrl_ALUopcode, selop);
	
	//add
	wire [31:0] sum;
	wire sumovf;
	adder _sum(data_operandA, data_operandB, 1'b0, sum, sumovf);
	
	//sub
	wire [31:0] negB, diff;
	wire diffovf;
	genvar i;
	generate
	for(i = 0; i < 32; i=i+1) begin : gen_negB
		not _not(negB[i], data_operandB[i]);
		end
	endgenerate
	adder _diff(data_operandA, negB, 1'b1, diff, diffovf);
	xor _ilt(isLessThan, diffovf, diff[31]);
	
	wire [31:0] qdiff;
	generate
	for(i = 0; i < 32; i=i+1) begin : gen_qdiff
		xor _xoreq(qdiff[i], data_operandA[i], data_operandB[i]);
		end
	endgenerate
	
	or _noteq(isNotEqual, qdiff[0], qdiff[1], qdiff[2], qdiff[3], qdiff[4], qdiff[5], qdiff[6], qdiff[7], qdiff[8], 
	qdiff[9], qdiff[10], qdiff[11], qdiff[12], qdiff[13], qdiff[14], qdiff[15], qdiff[16], qdiff[17], qdiff[18], qdiff[19], qdiff[20], 
	qdiff[21], qdiff[22], qdiff[23], qdiff[24], qdiff[25], qdiff[26], qdiff[27], qdiff[28], qdiff[29], qdiff[30], qdiff[31]);
		
	
	//and
	wire [31:0] andop;
	generate
	for(i = 0; i < 32; i=i+1) begin : gen_andop
		and _andop(andop[i], data_operandA[i], data_operandB[i]);
		end
	endgenerate
	
	
	//or
	wire [31:0] orop;
	generate
	for(i = 0; i < 32; i=i+1) begin : gen_orop
		or _orop(orop[i], data_operandA[i], data_operandB[i]);
		end
	endgenerate
	
	//sll
	wire [31:0] sllop;
	sll _sll(data_operandA, ctrl_shiftamt, sllop);
	
	//sra
	wire [31:0] sraop;
	sra _sra(data_operandA, ctrl_shiftamt, sraop);
	
	assign data_result = selop[0] ? sum : (selop[1] ? diff : (selop[2] ? andop : (selop[3] ? orop : (selop[4] ? sllop : (selop[5] ? sraop : 32'b0)))));
	
	
	assign overflow = selop[0] ? sumovf : (selop[1] ? diffovf : 1'b0);
	
	

endmodule
