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
	end else if (count < 3) begin
		mem_waddr <= pixeladdress + count + -5*640;
		mem_wdata <= 3'b001;
		mem_wenable <= 1'b1;
		count <= count + 32'd1;
	end else if (count < 6) begin
		mem_waddr <= pixeladdress + count + 637 + -5*640;
		mem_wdata <= 3'b001;
		mem_wenable <= 1'b1;
		count <= count + 32'd1;
	end else if (count < 9) begin
		mem_waddr <= pixeladdress + count + 634 + -4*640;
		mem_wdata <= 3'b001;
		mem_wenable <= 1'b1;
		count <= count + 32'd1;
	end
end
assign finished_drawing = (count == 32'd9);

// --------------------------------------- Initial -------------------------------------------------------
initial
begin
	count <= 32'd9;
end

endmodule
