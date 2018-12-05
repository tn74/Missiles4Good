module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB,
	 reg29, reg28, reg27, reg26, reg25, reg24,
	 reg23, reg22, reg21, reg20, reg19, reg18, reg17
);

   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
	
	//shared registers
	input [31:0] reg29, reg28, reg27;
	output [31:0] reg26, reg25, reg24, reg23, reg22, reg21, reg20, reg19, reg18, reg17;

   output [31:0] data_readRegA, data_readRegB;
	
	wire [31:0] writeSelect, readASelect, readBSelect;
	
	decoder dec(ctrl_writeReg,writeSelect);
	decoder muxA(ctrl_readRegA,readASelect);
	decoder muxB(ctrl_readRegB,readBSelect);
	
	assign data_readRegA = readASelect[0] ? 32'b0 : 32'bz;
	assign data_readRegB = readBSelect[0] ? 32'b0 : 32'bz;
	
   genvar i;
	generate
	for(i = 1; i < 32; i=i+1) begin : gen_dffe
		wire [31:0] read, write;
		wire enable, en;
		and andenable(en, writeSelect[i], ctrl_writeEnable);
		assign enable = ((i==29)||(i==28)||(i==27)) ? 1'b1 : en;
		assign write = (i==29) ? reg29 : ((i==28) ? reg28 : ((i==27) ? reg27 : data_writeReg));
		register register(clock, enable, ctrl_reset, write, read);
		assign data_readRegA = readASelect[i] ? read : 32'bz;
		assign data_readRegB = readBSelect[i] ? read : 32'bz;
		assign reg26 = (i==26) ? read : 32'bz;
		assign reg25 = (i==25) ? read : 32'bz;
		assign reg24 = (i==24) ? read : 32'bz;
		assign reg23 = (i==23) ? read : 32'bz;
		assign reg22 = (i==22) ? read : 32'bz;
		assign reg21 = (i==21) ? read : 32'bz;
		assign reg20 = (i==20) ? read : 32'bz;
		assign reg19 = (i==19) ? read : 32'bz;
		assign reg18 = (i==18) ? read : 32'bz;
		assign reg17 = (i==17) ? read : 32'bz;
		end
	endgenerate
	
endmodule

                                             