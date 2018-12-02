module vga_controller_typer(
							 clock, 
							 iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 
							 row_num,
							 col_num,
							 character_input,
							 start_writing_character,
							 
							 finished_saving_char
							 );

// Typing Inputs and Outputs
input[7:0] row_num, col_num, character_input;
input start_writing_character, clock;
output finished_saving_char;

// VGA Inputs and Outputs	
input iRST_n;
input iVGA_CLK;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        

// Address to Index Memory File Writing
wire[18:0] mem_waddr;
wire[2:0] mem_wdata;
wire mem_wenable;

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


// Typer Logic for writing to memory from which address to index translation is done
typer_logic typer_logic_inst (
	 .clock(iVGA_CLK),
	 .row_num(row_num),
	 .col_num(col_num),
	 .character_input(character_input),
	 .start_writing_character(start_writing_character),
	 .finished_saving_char(finished_saving_char),
	 .mem_waddr(mem_waddr),
	 .mem_wdata(mem_wdata),
	 .mem_wenable(mem_wenable)
);



//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
//typer_data_2 typer_data_inst (
//	.rdclock( VGA_CLK_n ),
//	.rdaddress( ADDR ),
//	.q( index ),
//	
//	.wrclock( clock ),
//	.wren( mem_wenable ),
//	.wraddress( mem_waddr ), 
//	.data( mem_wdata )
//);

typer_data typer_data_inst (
	.clock( VGA_CLK_n ),
	.rdaddress( ADDR ),
	.q( index ),
	
	.wren( mem_wenable ),
	.wraddress( mem_waddr ), 
	.data( mem_wdata )
);

	
//////Color table output
typer_index typer_index_inst (
	.address ( index ),
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
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

endmodule
 	















