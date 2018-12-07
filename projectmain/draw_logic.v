module draw_logic(
	clock,
	
	pixeladdress,
	
	start_drawing,
	finished_drawing,
	
	mem_waddr,
	mem_wdata,
	mem_wenable
	
);

input clock;
input [18:0] pixeladdress;
input start_drawing;

output finished_drawing;
output reg [18:0] mem_waddr;
output reg [2:0] mem_wdata;
output reg mem_wenable;


// --------------------------------------- Main Loop -------------------------------------------------------

reg [31:0] count;

always @(negedge clock) begin
	if (start_drawing) begin
		count <= 32'h0;
	end else if (count < 5) begin
		mem_waddr <= pixeladdress + count;
		mem_wdata <= 3'b001;
		mem_wenable <= 1'b1;
		count <= count + 32'd1;
	end else if (count < 10) begin
		mem_waddr <= pixeladdress + count + 635;
		mem_wdata <= 3'b001;
		mem_wenable <= 1'b1;
		count <= count + 32'd1;
	end
end
assign finished_drawing = (count == 32'd10);

// --------------------------------------- Initial -------------------------------------------------------
initial
begin
	count <= 32'd10;
end

endmodule
