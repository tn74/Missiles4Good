module commands_printer_tracker(clock, start, ps2_line_content, ps2_line_ready, char_index, char_data, finish);
	input clock, start;
	input[255:0] ps2_line_content;
	input ps2_line_ready;
	
	output finish;
	output reg[7:0] char_index, char_data;
	reg[7:0] ps2_lines[7:0][31:0];
	
	
	
// ----------------------------- Loop for printing to screen ---------------------
	reg[31:0] count;
	assign finish = (count == 32'd256);
	always @(posedge clock)
	begin
		if (start) begin
			count <= 32'd0;
		end else begin
			if (count < 236) begin
				if (count % 32 < 12) begin
					char_index <= count;
					char_data <= ps2_lines[count / 32][count % 32];
				end else begin
					char_index <= (char_index + 32) / 32;
				end
			end
			count <= count + 1;
		end
	end
	
// ----------------------------------- Updating Bottom line of PS2 -----------------
	initial
	begin
		char_index <= 8'h00;
		char_idata <= 8'h00;
		ps2_lines[6] = 255'h0;
		ps2_lines[5] = 255'h0;
		ps2_lines[4] = 255'h0;
		ps2_lines[3] = 255'h0;
		ps2_lines[2] = 255'h0;
		ps2_lines[1] = 255'h0;
		ps2_lines[0] = 255'h0;		
	end
	
	always @(posedge clock)
	begin
		ps2_lines[7][0] <= ps2_line_content[255 : 248];
		ps2_lines[7][1] <= ps2_line_content[247 : 240];
		ps2_lines[7][2] <= ps2_line_content[239 : 232];
		ps2_lines[7][3] <= ps2_line_content[231 : 224];
		ps2_lines[7][4] <= ps2_line_content[223 : 216];
		ps2_lines[7][5] <= ps2_line_content[215 : 208];
		ps2_lines[7][6] <= ps2_line_content[207 : 200];
		ps2_lines[7][7] <= ps2_line_content[199 : 192];
		ps2_lines[7][8] <= ps2_line_content[191 : 184];
		ps2_lines[7][9] <= ps2_line_content[183 : 176];
		ps2_lines[7][10] <= ps2_line_content[175 : 168];
		ps2_lines[7][11] <= ps2_line_content[167 : 160];
		ps2_lines[7][12] <= ps2_line_content[159 : 152];
		ps2_lines[7][13] <= ps2_line_content[151 : 144];
		ps2_lines[7][14] <= ps2_line_content[143 : 136];
		ps2_lines[7][15] <= ps2_line_content[135 : 128];
		ps2_lines[7][16] <= ps2_line_content[127 : 120];
		ps2_lines[7][17] <= ps2_line_content[119 : 112];
		ps2_lines[7][18] <= ps2_line_content[111 : 104];
		ps2_lines[7][19] <= ps2_line_content[103 : 96];
		ps2_lines[7][20] <= ps2_line_content[95 : 88];
		ps2_lines[7][21] <= ps2_line_content[87 : 80];
		ps2_lines[7][22] <= ps2_line_content[79 : 72];
		ps2_lines[7][23] <= ps2_line_content[71 : 64];
		ps2_lines[7][24] <= ps2_line_content[63 : 56];
		ps2_lines[7][25] <= ps2_line_content[55 : 48];
		ps2_lines[7][26] <= ps2_line_content[47 : 40];
		ps2_lines[7][27] <= ps2_line_content[39 : 32];
		ps2_lines[7][28] <= ps2_line_content[31 : 24];
		ps2_lines[7][29] <= ps2_line_content[23 : 16];
		ps2_lines[7][30] <= ps2_line_content[15 : 8];
		ps2_lines[7][31] <= ps2_line_content[7 : 0];
	end
	
endmodule
