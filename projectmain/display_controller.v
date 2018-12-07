module display_controller(
	clock,
	iRST_n,
   iVGA_CLK,
   oBLANK_n,
   oHS,
   oVS,
   b_data,
   g_data,
   r_data,
	
	velocity,
	fire,
	angle,
	targetx_0,
	targetx_1,
	targetx_2,
	targetx_3,
	targety_0,
	targety_1,
	targety_2,
	targety_3,
	trajectory_memloc,
	trajectory_memloc_enable,
	
	ps2_line_content,
	ps2_line_ready,
	
	reset
	
   
);

// VGA Inputs and Outputs	
input iRST_n;
input iVGA_CLK;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        

// Control Inputs and Outputs
input clock;
input[31:0] velocity;
input[31:0] angle;
input fire, reset;
	
input[31:0] targetx_0, targetx_1, targetx_2, targetx_3;
input[31:0] targety_0, targety_1, targety_2, targety_3;
input[31:0] trajectory_memloc, trajectory_memloc_enable;
input[255:0] ps2_line_content;
input ps2_line_ready;

// Address to Index Memory File Writing
wire[18:0] mem_waddr;
wire[2:0] mem_wdata;
wire mem_wenable;



// ----------------------------------------------------- INDEX MIF to VGA Information -------------------------------------------------

// VGA Wires                
reg [18:0] ADDR;
reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [2:0] index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;

// Something...
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));

////Addresss generator. 
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end

//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
monitor_index monitor_index_inst (
	.rdclock( VGA_CLK_n ),
	.rdaddress( ADDR ),
	.q( index ),
	
	.wrclock( ~clock ),
	.wren( mem_wenable ),
	.wraddress( mem_waddr ), 
	.data( mem_wdata )
);

	
//////Color table output
monitor_color monitor_color_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw )
);



// Latch valid data at falling edge;
always@(posedge VGA_CLK_n) bgr_data <= bgr_data_raw;
assign b_data = bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0]; 


// Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

// ---------------------------------------------- End Standard VGA Stuff -----------------------------------------------------------------
wire[31:0] x_numbers;
wire[31:0] y_numbers;
assign x_numbers[31:24] = targetx_3[7:0]; assign x_numbers[23:16] = targetx_2[7:0]; assign x_numbers[15:8] = targetx_1[7:0]; assign x_numbers[7:0] = targetx_0[7:0];
assign y_numbers[31:24] = targety_3[7:0]; assign y_numbers[23:16] = targety_2[7:0]; assign y_numbers[15:8] = targety_1[7:0]; assign y_numbers[7:0] = targety_0[7:0];

// ---------------------------------------------- Begin Control Information -----------------------------------------------------------------


wire[7:0] character_address, character;
wire character_clock;

screencharacter_mif_writer smw(
	// Needed write input information
	.clock(clock),
	.velocity(velocity),
	.fire(fire),
	.angle(angle),
	.targetx(x_numbers),
	.targety(y_numbers),
	.ps2_line_content(ps2_line_content),
	.ps2_line_ready(ps2_line_ready),
	
	// Needed read information
	.rd_add(character_address), 	 // Input
	.rd_clk(character_clock),		 // Input
	.rd_out(character)			 // Output
);

wire[18:0] draw_out;
wire[8:0] draw_address;
wire draw_clock;
trajectory_mif_writer tmw (
	.clock(clock),
	.trajectory_memloc(trajectory_memloc),
	.trajectory_memloc_enable(trajectory_memloc_enable),
	.rd_draw_add(draw_address),
	.rd_draw_clk(draw_clock),
	.rd_draw_out(draw_out)
);
	

index_mif_writer imw(
	.clock(clock),
	.mem_waddr(mem_waddr),
	.mem_wdata(mem_wdata),
	.mem_wenable(mem_wenable),
	
	.character_address(character_address),
	.character_clock(character_clock),
	.character(character),
	
	.draw_address(draw_address),
	.draw_clock(draw_clock),
	.draw_pixelad(draw_out),
	
	.reset(reset)
);

endmodule
