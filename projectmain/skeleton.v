module skeleton(resetn, 
	ps2_clock, ps2_data, 										// ps2 related I/O
	debug_data_in, debug_addr, leds, 						// extra debugging ports
	lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon,// LCD info
	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8,		// seven segements
	VGA_CLK,   														//	VGA Clock
	VGA_HS,															//	VGA H_SYNC
	VGA_VS,															//	VGA V_SYNC
	VGA_BLANK,														//	VGA BLANK
	VGA_SYNC,														//	VGA SYNC
	VGA_R,   														//	VGA Red[9:0]
	VGA_G,	 														//	VGA Green[9:0]
	VGA_B,															//	VGA Blue[9:0]
	CLOCK_50,
	arm_signal,
	theta_signal,
	motor_signal
	);  													// 50 MHz clock
	
	
		
	////////////////////////	VGA	////////////////////////////
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK;				//	VGA BLANK
	output			VGA_SYNC;				//	VGA SYNC
	output	[7:0]	VGA_R;   				//	VGA Red[9:0]
	output	[7:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[7:0]	VGA_B;   				//	VGA Blue[9:0]
	input				CLOCK_50;

	////////////////////////	PS2	////////////////////////////
	input 			resetn;
	inout 			ps2_data, ps2_clock;
	
	////////////////////////	LCD and Seven Segment	////////////////////////////
	output 			   lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon;
	output 	[7:0] 	leds, lcd_data;
	output 	[6:0] 	seg1, seg2, seg3, seg4, seg5, seg6, seg7, seg8;
	output 	[31:0] 	debug_data_in;
	output   [11:0]   debug_addr;
		
	wire			 clock;
	wire			 lcd_write_en;
	wire 	[31:0] lcd_write_data;
	wire	[7:0]	 ps2_key_data;
	wire			 ps2_key_pressed;
	wire	[7:0]	 ps2_out;	
	
	
	
	/////////////////////// PROJECT TOP LEVEL ITEMS ////////////////////////////////
	wire[31:0] VELOCITY, ANGLE;
	wire[255:0] PS2_LINE_CONTENT;
	wire PS2_LINE_READY;
	wire[31:0] X0, X1, X2, X3, Y0, Y1, Y2, Y3;
	wire FIRE, QUEUE;
	
	
	
	
	// clock divider (by 5, i.e., 10 MHz)
	pll div(CLOCK_50,inclock);
	assign clock = CLOCK_50;
	
	// UNCOMMENT FOLLOWING LINE AND COMMENT ABOVE LINE TO RUN AT 50 MHz
	//assign clock = inclock;
	
	// your processor
	//processor myprocessor(clock, ~resetn, /*ps2_key_pressed, ps2_out, lcd_write_en, lcd_write_data,*/ debug_data_in, debug_addr);
	
	// keyboard controller
	PS2_Interface myps2(clock, resetn, ps2_clock, ps2_data, ps2_key_data, ps2_key_pressed, ps2_out);
	ps2_cleaner cleaner(clock, ps2_key_data, ps2_out, input_character, input_made);
	ps2_processor_module ps2process(clock, input_character, input_made, PS2_LINE_CONTENT, PS2_LINE_READY, VELOCITY, ANGLE, FIRE, reset);
	
	// example for sending ps2 data to the first two seven segment displays
	Hexadecimal_To_Seven_Segment hex1(ps2_out[3:0], seg1);
	Hexadecimal_To_Seven_Segment hex2(ps2_out[7:4], seg2);
	
	// the other seven segment displays are currently set to 0
	Hexadecimal_To_Seven_Segment hex3(4'b0, seg3);
	Hexadecimal_To_Seven_Segment hex4(4'b0, seg4);
	Hexadecimal_To_Seven_Segment hex5(4'b0, seg5);
	Hexadecimal_To_Seven_Segment hex6(4'b0, seg6);
	Hexadecimal_To_Seven_Segment hex7(4'b0, seg7);
	Hexadecimal_To_Seven_Segment hex8(4'b0, seg8);
	
	// some LEDs that you could use for debugging if you wanted
	assign leds = 8'b00101011;
	
	wire input_made;
	wire[7:0] input_character;
	
	wire [7:0] typer_row_num, typer_col_num, typer_character_input;
	wire	typer_start_writing_char, finished_saving_char;
	
	
	// lcd controller
//	lcd mylcd(clock, ~resetn, ps2_key_pressed, ps2_out, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	lcd mylcd(clock, ~resetn, input_made, input_character, lcd_data, lcd_rw, lcd_en, lcd_rs, lcd_on, lcd_blon);
	input_brain inpbr(
		.clock(clock),
	
		.input_character(input_character), 
		.input_made(input_made),

		.row_num(typer_row_num),
		.col_num(typer_col_num),
		.vga_character_in(typer_character_input),
		.vga_start_write(typer_start_writing_char)
	);
	
	// VGA
	Reset_Delay			r0	(.iCLK(CLOCK_50),.oRESET(DLY_RST)	);
	VGA_Audio_PLL 		p1	(.areset(~DLY_RST),.inclk0(CLOCK_50),.c0(VGA_CTRL_CLK),.c1(AUD_CTRL_CLK),.c2(VGA_CLK)	);
	
	display_controller display_controller_inst(
		.clock(clock),
		.iRST_n(DLY_RST),
		.iVGA_CLK(VGA_CLK),
		.oBLANK_n(VGA_BLANK),
		.oHS(VGA_HS),
		.oVS(VGA_VS),
		.b_data(VGA_B),
		.g_data(VGA_G),
		.r_data(VGA_R),
				
		.velocity(VELOCITY),
	   .fire(FIRE),
	   .angle(ANGLE),
		.queue(QUEUE),
	   .targetx_0(reg23),
	   .targetx_1(reg24),
	   .targetx_2(reg25),
	   .targetx_3(reg26),
	   .targety_0(reg19),
	   .targety_1(reg20),
	   .targety_2(reg21),
	   .targety_3(reg22),
		.ps2_line_content(PS2_LINE_CONTENT),
		.ps2_line_ready(PS2_LINE_READY),
	   .trajectory_memloc(reg18),
	   .trajectory_memloc_enable(reg17),
		.reset(reset)
	);
		
	angle_to_trig angle_to_trig(ANGLE, reg27, reg28);
	
   wire [31:0] reg29, reg28, reg27, reg26, reg25, reg24, reg23, reg22, reg21, reg20, reg19, reg18, reg17;
	assign reg29 = VELOCITY;

	wire reset;
    /** IMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_imem;
    wire [31:0] q_imem;
    imem my_imem(
        .address    (address_imem),            // address of data
        .clock      (~inclock),                  // you may need to invert the clock
        .q          (q_imem)                   // the raw instruction
    );

    /** DMEM **/
    // Figure out how to generate a Quartus syncram component and commit the generated verilog file.
    // Make sure you configure it correctly!
    wire [11:0] address_dmem;
    wire [31:0] data;
    wire wren;
    wire [31:0] q_dmem;
    dmem my_dmem(
        .address    (address_dmem),       // address of data
        .clock      (~inclock),                  // may need to invert the clock
        .data	    (data),    // data you want to write
        .wren	    (wren),      // write enable
        .q          (q_dmem)    // data from dmem
    );

    /** REGFILE **/
    // Instantiate your regfile
    wire ctrl_writeEnable;
    wire [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    wire [31:0] data_writeReg;
    wire [31:0] data_readRegA, data_readRegB;
    regfile my_regfile(
        inclock,
        ctrl_writeEnable,
        reset,
        ctrl_writeReg,
        ctrl_readRegA,
        ctrl_readRegB,
        data_writeReg,
        data_readRegA,
        data_readRegB,
        reg29, reg28, reg27, reg26, reg25, reg24,
		  reg23, reg22, reg21, reg20, reg19, reg18, reg17
    );
	 
	 
    /** PROCESSOR **/
    processor my_processor(
        // Control signals
        inclock,                          // I: The master clock
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
//
	output arm_signal, theta_signal, motor_signal;
//	
	pwm_controller pwm_controller(
		arm_signal,
		theta_signal,
		motor_signal,
		clock,
		FIRE,
		ANGLE,
		VELOCITY
	);

endmodule
