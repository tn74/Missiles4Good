/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB                   // I: Data from port B of regfile
);
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;
    input [31:0] q_imem;

    // Dmem
    output [11:0] address_dmem;
    output [31:0] data;
    output wren;
    input [31:0] q_dmem;

    // Regfile
    output ctrl_writeEnable;
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 
	 // Instructions latches
	 wire [31:0] d_latch, x_latch, m_latch, w_latch; //Latches Containing Instructions
	 
	 
	 
	 // Bypass logic
	 wire wm, wxa, wxb, mxa, mxb, wda, wdb;
	 
	 wire [31:0] w_data, m_in_dataO; // data used in w, data into m
	 
	 
	 
	 // Stall logic
	 wire stall, md_stall;
	 
	 
	 // Exception logic
	 wire aluovf, x_ovf, m_ovf, w_ovf, addiovf;
	 
	 wire ne, lt; // not equals, less than, and alu ovf;
	 wire [31:0] x_sel;
	 wire branch;
	 assign branch = x_sel[1]||(ne&&x_sel[2])||x_sel[3]||x_sel[4]||(lt&&x_sel[6])||((|x_alu_inB)&&x_sel[22]);
	 
	 wire d_nop, x_nop;
	 assign d_nop = stall||branch;
	 assign x_nop = branch;
	 
	 
	 wire [31:0] f_sel; // select for d stage
	 decoder ddecoder(q_imem[31:27], f_sel); // set d select
	 
	 /* Start F Section */
	 wire [31:0] pc_out, pc_in, pc_from_x; // PC into imem, PC out from imem, PC from x stage
	 
	 register pc(clock, (~stall&&~md_stall), reset, pc_in, pc_out); // Store PC for next cycle
	 
	 wire [31:0] pc_next; // pc_next
	 wire pcovf; //ignore pc ovf
	 
	 adder pcadder(pc_out, 32'b0, 1'b1, pc_next, pcovf); //pc_next = pc_out + 1
	 
	 assign pc_in = branch ? pc_from_x : pc_next; //select next pc or branch from x
	 
	 assign address_imem = pc_out[11:0]; //set next address for imem
	 /* End F Section */
	 
	 
	 wire [31:0] d_pc; // pc in d stage
	 register registerdpc(clock, ~md_stall, reset, pc_next , d_pc);  // store pc+1 in d_pc
	 
	 
	 wire [31:0] d_pre;
	 assign d_pre = d_nop ? 32'b0 : q_imem;
	 register registerfd(clock, ~md_stall, reset, d_pre, d_latch); // latch F/D
	 
	 wire [31:0] d_sel; // select for d stage
	 decoder fdecoder(d_latch[31:27], d_sel); // set d select
	 
	 
	 
	 /* Start D Section */
	 assign ctrl_readRegA = d_latch[21:17]; // pull $rs from d stage inst
	 assign ctrl_readRegB = d_sel[0] ? d_latch[16:12] : (d_sel[22] ? 5'd30 : d_latch[26:22]); // pull $rt (or $rd for I type) from d stage inst
	 
	 wire [31:0] d_out_dataA, d_out_dataB; //data from regfile
	 
	 assign d_out_dataA = wda ? w_data : data_readRegA;
	 assign d_out_dataB = wdb ? w_data : data_readRegB;
	 /* End D Section */
	 
	 
	 
	 wire [31:0] x_pc, x_pc_n; // pc + 1 in x stage, pc + 1 + n
	 register registerxpc(clock, ~md_stall, reset, d_pc , x_pc);  // store pc+1 in x_pcs
	 
	 wire [31:0] x_pre;
	 assign x_pre = x_nop ? 32'b0 : d_latch;
	 register registerdx(clock, ~md_stall, reset, x_pre, x_latch); // latch D/X
	 
	 wire [31:0] x_in_dataA, x_in_dataB; // data into x
	 register registerxdataA(clock, ~md_stall, reset, d_out_dataA, x_in_dataA); // dataA latch D/X
	 register registerxdataB(clock, ~md_stall, reset, d_out_dataB, x_in_dataB); // dataB latch D/X
	 
	 decoder xdecoder(x_latch[31:27], x_sel); // set x select
	 
	 
	 
	 /* Start X Section */
	 // PC Part
	 wire pcnovf; //ignore pc ovf
	 
	 adder pcnadder(x_pc, x_latch[16:0], 1'b0, x_pc_n, pcnovf); // pc+1+n stored in x_pc_n
	 
	 wire [31:0] t_pc;
	 
	 assign t_pc[26:0] = x_latch[26:0];
	 assign t_pc[31:27] = 5'b0;
	 
	 assign pc_from_x = x_sel[4] ? x_alu_inB : (x_sel[2]||x_sel[6] ? x_pc_n : t_pc); // send back $rd, pc+1+n, T
	 
	 // Data Part
	 wire [31:0] x_alu_inA, x_alu_inB, x_result; // alu inputs and result
	 
	 wire [31:0] x_bpA, x_bpB;
	 
	 assign x_bpA = wxa||mxa ? (wxa ? w_data : m_in_dataO) : x_in_dataA;
	 assign x_bpB = wxb||mxb ? (wxb ? w_data : m_in_dataO) : x_in_dataB;
	 
	 assign x_alu_inA = x_sel[6] ? x_bpB : x_bpA; // select between dataA latch and bypass
	 assign x_alu_inB = x_sel[6] ? x_bpA : x_bpB; // select between dataB latch and bypass
	 
	 alu alu(x_alu_inA, x_alu_inB, x_latch[6:2], x_latch[11:7], x_result, ne, lt, aluovf); // alu with opcode and shamt
	 
	 wire [31:0] addi_result, addi_in; //result from addi
	 
	 assign addi_in[15:0] = x_latch[15:0];
	 
	 genvar i;
	 generate
	 for(i = 16; i < 32; i=i+1) begin : gen_signextend
		  assign addi_in[i] = x_latch[16];
		  end
	 endgenerate
	 
	 adder addi(x_alu_inA, addi_in, 1'b0, addi_result, addiovf); // addi $rs+N
	 
	 wire [31:0] x_out_dataA; // data out from x
	 
	 
	 
	 // multdiv
	 wire [31:0] md_out, rg_out, rem_out;
	 wire md_ex, md, mult, div, ctrl_mult, ctrl_div, ctrl_md, md_rdy, rg, ctrl_rg, rg_rdy, rem;
	 
	 assign mult = (~|(x_latch[6:2]^5'b00110))&&x_sel[0];
	 assign div = ((~|(x_latch[6:2]^5'b00111))||(~|(x_latch[6:2]^5'b01011)))&&x_sel[0];
	 assign rg = (~|(x_latch[6:2]^5'b01000))&&x_sel[0];
	 assign rem = (~|(x_latch[6:2]^5'b01011))&&x_sel[0];
	 
	 assign ctrl_mult = (~|(d_latch[6:2]^5'b00110))&&d_sel[0];
	 assign ctrl_div = ((~|(d_latch[6:2]^5'b00111))||(~|(d_latch[6:2]^5'b01011)))&&d_sel[0];
	 assign ctrl_rg = (~|(d_latch[6:2]^5'b01000))&&d_sel[0];
	 
	 assign md = mult||div;
	 
	 assign ctrl_md = ctrl_mult||ctrl_div;
	 
	 multdiv multdiv(x_alu_inA, x_alu_inB, ctrl_mult, ctrl_div, clock, md_out, md_ex, md_rdy, rem_out);
	 
	 range range(x_alu_inA, x_alu_inB, rg_out, ctrl_rg, clock, rg_rdy);
	 
	 assign md_stall = (md&&~md_rdy)||(rg&~rg_rdy);
	 
	 
	 
	 
	 assign x_out_dataA = x_sel[0] ? ((md&&md_rdy) ? (rem ? rem_out : md_out) : ((rg&rg_rdy) ? rg_out : x_result)) : addi_result; // select between alu and addi
	 
	 assign x_ovf = x_sel[0] ? ((md&&md_rdy) ? md_ex : ((rg&rg_rdy) ? 1'b0 : aluovf)) : addiovf;
	 /* End X Section */
	 
	 
	 dffe_ref m_dffe(m_ovf, x_ovf, clock, ~md_stall, reset);
	 
	 wire [31:0] m_pc; // pc + 1 in m stage
	 register registermpc(clock, ~md_stall, reset, x_pc , m_pc);  // store pc+1 in m_pc
	 
	 register registerxm(clock, ~md_stall, reset, x_latch, m_latch); // latch X/M
	 
	 wire [31:0] m_in_dataB; // data into m
	 
	 register registermdataO(clock, ~md_stall, reset, x_out_dataA, m_in_dataO); // dataA latch X/M
	 register registermdataB(clock, ~md_stall, reset, x_in_dataB, m_in_dataB);  // dataB latch X/M
	 
	 wire [31:0] m_sel; // select for m stage
	 decoder mdecoder(m_latch[31:27], m_sel); // set m select
	 
	 
	 
	 /* Start M Section */
	 assign address_dmem = m_in_dataO[11:0]; // set address as $rs+N
	 assign data = wm ? w_data : m_in_dataB; // set data as $rd
	 
	 assign wren = m_sel[7]; // TODO: when to write to mem
	 /* End M Section */
	 
	 dffe_ref w_dffe(w_ovf, m_ovf, clock, ~md_stall, reset);
	 
	 wire [31:0] w_pc; // pc + 1 in m stage
	 register registerwpc(clock, ~md_stall, reset, m_pc , w_pc);  // store pc+1 in m_pc
	 
	 register registermw(clock, ~md_stall, reset, m_latch, w_latch); // latch M/W
	 
	 wire [31:0] w_in_dataO, w_in_dataD; // data into w
	 
	 register registerwdataO(clock, ~md_stall, reset, m_in_dataO, w_in_dataO); // data latch M/W
	 register registerwdataD(clock, ~md_stall, reset, q_dmem, w_in_dataD); // data latch M/W
	 
	 wire [31:0] w_sel; // select for w stage
	 decoder wdecoder(w_latch[31:27], w_sel); // set w select
	
	 assign w_data = w_sel[8] ? w_in_dataD : w_in_dataO; // select between O pass through, and from mem $rd
	 
	 /* Begin W Section */
	 wire [31:0] error_data, alu_error_data;
	 wire error;
	 assign alu_error_data = w_sel[1] ? 32'd2 : (~|(w_latch[6:2]^5'b00000) ? 32'd1 : (~|(w_latch[6:2]^5'b00001) ? 32'd3 : (~|(w_latch[6:2]^5'b00110) ? 32'd4 : (~|(w_latch[6:2]^5'b00111) ? 32'd5 : 32'd0))));
	 
	 assign error = w_sel[21]||(w_ovf&&(w_sel[0]||w_sel[5]));
	 assign error_data = w_sel[21] ? w_latch[26:0] : (w_sel[5] ? 32'd2 : alu_error_data);
	 
	 assign ctrl_writeReg = w_sel[3] ? 5'd31 : (error ? 5'd30 : w_latch[26:22]); //set to $rd
	 assign data_writeReg = w_sel[3] ? w_pc : (error ? error_data : w_data); // data into $rd
	 
	 assign ctrl_writeEnable = (w_sel[0] || w_sel[3] || w_sel[5] || w_sel[8] || w_sel[21])&&(|w_latch); // TODO: when to write to register
	 /* End W Section */
	 
	 
	 
	 /* Bypass logic */
	 wire m_we, m_error;
	 wire [4:0] m_wr;
	 assign m_we = (m_sel[0] || m_sel[3] || m_sel[5] || m_sel[8] || m_sel[21])&&(|m_latch);
	 assign m_error = m_sel[21]||(m_ovf&&(m_sel[0]||m_sel[5]));
	 assign m_wr= m_sel[3] ? 5'd31 : (m_error ? 5'd30 : m_latch[26:22]); //set to $rd
	 
	 wire [4:0] x_rrA, x_rrB;
	 assign x_rrA = x_latch[21:17];
	 assign x_rrB = x_sel[0] ? x_latch[16:12] : (x_sel[22] ? 5'd30 : x_latch[26:22]);
	 
	 assign wm = (~|(ctrl_writeReg^m_latch[26:22]))&&ctrl_writeEnable&&(wren);
	 assign wxa = (~|(ctrl_writeReg^x_rrA))&&ctrl_writeEnable&&(|x_latch);
	 assign wxb = (~|(ctrl_writeReg^x_rrB))&&ctrl_writeEnable&&(|x_latch);
	 assign mxa =  (~|(m_wr^x_rrA))&&m_we&&(|x_latch);
	 assign mxb =  (~|(m_wr^x_rrB))&&m_we&&(|x_latch);
	 
	 assign wda = (~|(ctrl_writeReg^ctrl_readRegA))&&ctrl_writeEnable&&(|d_latch);
	 assign wdb = (~|(ctrl_writeReg^ctrl_readRegB))&&ctrl_writeEnable&&(|d_latch);
	 /* Bypass logic */
	 
	 
	 // Stall logic
	 assign stall = ctrl_md||ctrl_rg||(d_sel[8]&&(~|((q_imem[21:17]^d_latch[26:22]))||(~|(q_imem[16:12]^d_latch[26:22])))&&~f_sel[7]);

endmodule
