module targets_printer_tracker(clock, start, targetx, targety, char_index, char_data, finish);
	input clock, start;
	input[32:0] targetx, targety;
	
	output finish;
	output reg[7:0] char_index, char_data;
	reg[7:0] ps2_lines[7:0][31:0];
	
	wire[7:0] x_3, x_2, x_1, x_0, y_3, y_2, y_1, y_0;
	number_to_ascii(targetx[3:0], x_0);
	number_to_ascii(targetx[11:8], x_1);
	number_to_ascii(targetx[19:16], x_2);
	number_to_ascii(targetx[27:24], x_3);
	number_to_ascii(targety[3:0], y_0);
	number_to_ascii(targety[11:8], y_1);
	number_to_ascii(targety[19:16], y_2);
	number_to_ascii(targety[27:24], y_3);
	
	
// ----------------------------- Loop for printing to screen ---------------------
	reg[31:0] count;
	assign finish = (count == 32'd9);
	always @(posedge clock)
	begin
		if (start) begin
			count <= 32'd1;
		end else begin
			if (count < 9) begin
				if (count == 32'd1) begin
					char_index <= 32'd116;
					char_data <= x_3;
				end else if (count == 32'd2) begin
					char_index <= 32'd117;
					char_data <= x_2;
				end else if (count == 32'd3) begin
					char_index <= 32'd119;
					char_data <= x_1;
				end else if (count == 32'd4) begin
					char_index <= 32'd120;
					char_data <= x_0;
				end else if (count == 32'd5) begin
					char_index <= 32'd122;
					char_data <= y_3;
				end else if (count == 32'd6) begin
					char_index <= 32'd123;
					char_data <= y_2;
				end else if (count == 32'd7) begin
					char_index <= 32'd125;
					char_data <= y_1;
				end else if (count == 32'd8) begin
					char_index <= 32'd126;
					char_data <= y_0;
				end
				count <= count + 32'd1;
			end
			
		end
	end

	
// ----------------------------------- Updating Bottom line of PS2 -----------------
	
	initial
	begin
		count <= 32'd9;
	end
	
endmodule
