module sra(
	in,
	shift,
	out
);

input [31:0] in;
input [4:0] shift;

output [31:0] out;


wire [31:0] step0;
genvar i;
generate
for(i = 0; i < 31; i=i+1) begin : gen_step0
	assign step0[i] = shift[0] ? in[i+1] : in[i];
	end
endgenerate
assign step0[31] = in[31];


wire [31:0] step1;
generate
for(i = 0; i < 30; i=i+1) begin : gen_step1_1
	assign step1[i] = shift[1] ? step0[i+2] : step0[i];
	end
endgenerate
generate
for(i = 30; i < 32; i=i+1) begin : gen_step1_0
	assign step1[i] = shift[1] ? in[31] : step0[i];
	end
endgenerate

wire [31:0] step2;
generate
for(i = 0; i < 28; i=i+1) begin : gen_step2_1
	assign step2[i] = shift[2] ? step1[i+4] : step1[i];
	end
endgenerate
generate
for(i = 28; i < 32; i=i+1) begin : gen_step2_0
	assign step2[i] = shift[2] ? in[31] : step1[i];
	end
endgenerate

wire [31:0] step3;
generate
for(i = 0; i < 24; i=i+1) begin : gen_step3_1
	assign step3[i] = shift[3] ? step2[i+8] : step2[i];
	end
endgenerate
generate
for(i = 24; i < 32; i=i+1) begin : gen_step3_0
	assign step3[i] = shift[3] ? in[31] : step2[i];
	end
endgenerate

generate
for(i = 0; i < 16; i=i+1) begin : gen_step4_1
	assign out[i] = shift[4] ? step3[i+16] : step3[i];
	end
endgenerate
generate
for(i = 16; i < 32; i=i+1) begin : gen_step4_0
	assign out[i] = shift[4] ? in[31] : step3[i];
	end
endgenerate

endmodule