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
			if (count < 256) begin
				if (count % 32 < 11) begin
					char_index <= count;
					char_data <= ps2_lines[count / 32][count % 32];
//					char_data <= 8'h41;
				end else begin
					count <= (count + 32) / 32;
				end
				count <= count + 1;
			end
			
		end
	end
	
	
	always @(posedge ps2_line_ready)
	begin
	
	end

	
// ----------------------------------- Updating Bottom line of PS2 -----------------
	initial
	begin
		count <= 32'd256;
		char_index <= 8'h00;
		char_data <= 8'h00;
		ps2_lines[0][0] <= 8'h00;
		ps2_lines[0][1] <= 8'h00;
		ps2_lines[0][2] <= 8'h00;
		ps2_lines[0][3] <= 8'h00;
		ps2_lines[0][4] <= 8'h00;
		ps2_lines[0][5] <= 8'h00;
		ps2_lines[0][6] <= 8'h00;
		ps2_lines[0][7] <= 8'h00;
		ps2_lines[0][8] <= 8'h00;
		ps2_lines[0][9] <= 8'h00;
		ps2_lines[0][10] <= 8'h00;
		ps2_lines[0][11] <= 8'h00;
		ps2_lines[0][12] <= 8'h00;
		ps2_lines[0][13] <= 8'h00;
		ps2_lines[0][14] <= 8'h00;
		ps2_lines[0][15] <= 8'h00;
		ps2_lines[0][16] <= 8'h00;
		ps2_lines[0][17] <= 8'h00;
		ps2_lines[0][18] <= 8'h00;
		ps2_lines[0][19] <= 8'h00;
		ps2_lines[0][20] <= 8'h00;
		ps2_lines[0][21] <= 8'h00;
		ps2_lines[0][22] <= 8'h00;
		ps2_lines[0][23] <= 8'h00;
		ps2_lines[0][24] <= 8'h00;
		ps2_lines[0][25] <= 8'h00;
		ps2_lines[0][26] <= 8'h00;
		ps2_lines[0][27] <= 8'h00;
		ps2_lines[0][28] <= 8'h00;
		ps2_lines[0][29] <= 8'h00;
		ps2_lines[0][30] <= 8'h00;
		ps2_lines[0][31] <= 8'h00;
		ps2_lines[1][0] <= 8'h00;
		ps2_lines[1][1] <= 8'h00;
		ps2_lines[1][2] <= 8'h00;
		ps2_lines[1][3] <= 8'h00;
		ps2_lines[1][4] <= 8'h00;
		ps2_lines[1][5] <= 8'h00;
		ps2_lines[1][6] <= 8'h00;
		ps2_lines[1][7] <= 8'h00;
		ps2_lines[1][8] <= 8'h00;
		ps2_lines[1][9] <= 8'h00;
		ps2_lines[1][10] <= 8'h00;
		ps2_lines[1][11] <= 8'h00;
		ps2_lines[1][12] <= 8'h00;
		ps2_lines[1][13] <= 8'h00;
		ps2_lines[1][14] <= 8'h00;
		ps2_lines[1][15] <= 8'h00;
		ps2_lines[1][16] <= 8'h00;
		ps2_lines[1][17] <= 8'h00;
		ps2_lines[1][18] <= 8'h00;
		ps2_lines[1][19] <= 8'h00;
		ps2_lines[1][20] <= 8'h00;
		ps2_lines[1][21] <= 8'h00;
		ps2_lines[1][22] <= 8'h00;
		ps2_lines[1][23] <= 8'h00;
		ps2_lines[1][24] <= 8'h00;
		ps2_lines[1][25] <= 8'h00;
		ps2_lines[1][26] <= 8'h00;
		ps2_lines[1][27] <= 8'h00;
		ps2_lines[1][28] <= 8'h00;
		ps2_lines[1][29] <= 8'h00;
		ps2_lines[1][30] <= 8'h00;
		ps2_lines[1][31] <= 8'h00;
		ps2_lines[2][0] <= 8'h00;
		ps2_lines[2][1] <= 8'h00;
		ps2_lines[2][2] <= 8'h00;
		ps2_lines[2][3] <= 8'h00;
		ps2_lines[2][4] <= 8'h00;
		ps2_lines[2][5] <= 8'h00;
		ps2_lines[2][6] <= 8'h00;
		ps2_lines[2][7] <= 8'h00;
		ps2_lines[2][8] <= 8'h00;
		ps2_lines[2][9] <= 8'h00;
		ps2_lines[2][10] <= 8'h00;
		ps2_lines[2][11] <= 8'h00;
		ps2_lines[2][12] <= 8'h00;
		ps2_lines[2][13] <= 8'h00;
		ps2_lines[2][14] <= 8'h00;
		ps2_lines[2][15] <= 8'h00;
		ps2_lines[2][16] <= 8'h00;
		ps2_lines[2][17] <= 8'h00;
		ps2_lines[2][18] <= 8'h00;
		ps2_lines[2][19] <= 8'h00;
		ps2_lines[2][20] <= 8'h00;
		ps2_lines[2][21] <= 8'h00;
		ps2_lines[2][22] <= 8'h00;
		ps2_lines[2][23] <= 8'h00;
		ps2_lines[2][24] <= 8'h00;
		ps2_lines[2][25] <= 8'h00;
		ps2_lines[2][26] <= 8'h00;
		ps2_lines[2][27] <= 8'h00;
		ps2_lines[2][28] <= 8'h00;
		ps2_lines[2][29] <= 8'h00;
		ps2_lines[2][30] <= 8'h00;
		ps2_lines[2][31] <= 8'h00;
		ps2_lines[3][0] <= 8'h00;
		ps2_lines[3][1] <= 8'h00;
		ps2_lines[3][2] <= 8'h00;
		ps2_lines[3][3] <= 8'h00;
		ps2_lines[3][4] <= 8'h00;
		ps2_lines[3][5] <= 8'h00;
		ps2_lines[3][6] <= 8'h00;
		ps2_lines[3][7] <= 8'h00;
		ps2_lines[3][8] <= 8'h00;
		ps2_lines[3][9] <= 8'h00;
		ps2_lines[3][10] <= 8'h00;
		ps2_lines[3][11] <= 8'h00;
		ps2_lines[3][12] <= 8'h00;
		ps2_lines[3][13] <= 8'h00;
		ps2_lines[3][14] <= 8'h00;
		ps2_lines[3][15] <= 8'h00;
		ps2_lines[3][16] <= 8'h00;
		ps2_lines[3][17] <= 8'h00;
		ps2_lines[3][18] <= 8'h00;
		ps2_lines[3][19] <= 8'h00;
		ps2_lines[3][20] <= 8'h00;
		ps2_lines[3][21] <= 8'h00;
		ps2_lines[3][22] <= 8'h00;
		ps2_lines[3][23] <= 8'h00;
		ps2_lines[3][24] <= 8'h00;
		ps2_lines[3][25] <= 8'h00;
		ps2_lines[3][26] <= 8'h00;
		ps2_lines[3][27] <= 8'h00;
		ps2_lines[3][28] <= 8'h00;
		ps2_lines[3][29] <= 8'h00;
		ps2_lines[3][30] <= 8'h00;
		ps2_lines[3][31] <= 8'h00;
		ps2_lines[4][0] <= 8'h00;
		ps2_lines[4][1] <= 8'h00;
		ps2_lines[4][2] <= 8'h00;
		ps2_lines[4][3] <= 8'h00;
		ps2_lines[4][4] <= 8'h00;
		ps2_lines[4][5] <= 8'h00;
		ps2_lines[4][6] <= 8'h00;
		ps2_lines[4][7] <= 8'h00;
		ps2_lines[4][8] <= 8'h00;
		ps2_lines[4][9] <= 8'h00;
		ps2_lines[4][10] <= 8'h00;
		ps2_lines[4][11] <= 8'h00;
		ps2_lines[4][12] <= 8'h00;
		ps2_lines[4][13] <= 8'h00;
		ps2_lines[4][14] <= 8'h00;
		ps2_lines[4][15] <= 8'h00;
		ps2_lines[4][16] <= 8'h00;
		ps2_lines[4][17] <= 8'h00;
		ps2_lines[4][18] <= 8'h00;
		ps2_lines[4][19] <= 8'h00;
		ps2_lines[4][20] <= 8'h00;
		ps2_lines[4][21] <= 8'h00;
		ps2_lines[4][22] <= 8'h00;
		ps2_lines[4][23] <= 8'h00;
		ps2_lines[4][24] <= 8'h00;
		ps2_lines[4][25] <= 8'h00;
		ps2_lines[4][26] <= 8'h00;
		ps2_lines[4][27] <= 8'h00;
		ps2_lines[4][28] <= 8'h00;
		ps2_lines[4][29] <= 8'h00;
		ps2_lines[4][30] <= 8'h00;
		ps2_lines[4][31] <= 8'h00;
		ps2_lines[5][0] <= 8'h00;
		ps2_lines[5][1] <= 8'h00;
		ps2_lines[5][2] <= 8'h00;
		ps2_lines[5][3] <= 8'h00;
		ps2_lines[5][4] <= 8'h00;
		ps2_lines[5][5] <= 8'h00;
		ps2_lines[5][6] <= 8'h00;
		ps2_lines[5][7] <= 8'h00;
		ps2_lines[5][8] <= 8'h00;
		ps2_lines[5][9] <= 8'h00;
		ps2_lines[5][10] <= 8'h00;
		ps2_lines[5][11] <= 8'h00;
		ps2_lines[5][12] <= 8'h00;
		ps2_lines[5][13] <= 8'h00;
		ps2_lines[5][14] <= 8'h00;
		ps2_lines[5][15] <= 8'h00;
		ps2_lines[5][16] <= 8'h00;
		ps2_lines[5][17] <= 8'h00;
		ps2_lines[5][18] <= 8'h00;
		ps2_lines[5][19] <= 8'h00;
		ps2_lines[5][20] <= 8'h00;
		ps2_lines[5][21] <= 8'h00;
		ps2_lines[5][22] <= 8'h00;
		ps2_lines[5][23] <= 8'h00;
		ps2_lines[5][24] <= 8'h00;
		ps2_lines[5][25] <= 8'h00;
		ps2_lines[5][26] <= 8'h00;
		ps2_lines[5][27] <= 8'h00;
		ps2_lines[5][28] <= 8'h00;
		ps2_lines[5][29] <= 8'h00;
		ps2_lines[5][30] <= 8'h00;
		ps2_lines[5][31] <= 8'h00;
		ps2_lines[6][0] <= 8'h00;
		ps2_lines[6][1] <= 8'h00;
		ps2_lines[6][2] <= 8'h00;
		ps2_lines[6][3] <= 8'h00;
		ps2_lines[6][4] <= 8'h00;
		ps2_lines[6][5] <= 8'h00;
		ps2_lines[6][6] <= 8'h00;
		ps2_lines[6][7] <= 8'h00;
		ps2_lines[6][8] <= 8'h00;
		ps2_lines[6][9] <= 8'h00;
		ps2_lines[6][10] <= 8'h00;
		ps2_lines[6][11] <= 8'h00;
		ps2_lines[6][12] <= 8'h00;
		ps2_lines[6][13] <= 8'h00;
		ps2_lines[6][14] <= 8'h00;
		ps2_lines[6][15] <= 8'h00;
		ps2_lines[6][16] <= 8'h00;
		ps2_lines[6][17] <= 8'h00;
		ps2_lines[6][18] <= 8'h00;
		ps2_lines[6][19] <= 8'h00;
		ps2_lines[6][20] <= 8'h00;
		ps2_lines[6][21] <= 8'h00;
		ps2_lines[6][22] <= 8'h00;
		ps2_lines[6][23] <= 8'h00;
		ps2_lines[6][24] <= 8'h00;
		ps2_lines[6][25] <= 8'h00;
		ps2_lines[6][26] <= 8'h00;
		ps2_lines[6][27] <= 8'h00;
		ps2_lines[6][28] <= 8'h00;
		ps2_lines[6][29] <= 8'h00;
		ps2_lines[6][30] <= 8'h00;
		ps2_lines[6][31] <= 8'h00;
		ps2_lines[7][0] <= 8'h00;
		ps2_lines[7][1] <= 8'h00;
		ps2_lines[7][2] <= 8'h00;
		ps2_lines[7][3] <= 8'h00;
		ps2_lines[7][4] <= 8'h00;
		ps2_lines[7][5] <= 8'h00;
		ps2_lines[7][6] <= 8'h00;
		ps2_lines[7][7] <= 8'h00;
		ps2_lines[7][8] <= 8'h00;
		ps2_lines[7][9] <= 8'h00;
		ps2_lines[7][10] <= 8'h00;
		ps2_lines[7][11] <= 8'h00;
		ps2_lines[7][12] <= 8'h00;
		ps2_lines[7][13] <= 8'h00;
		ps2_lines[7][14] <= 8'h00;
		ps2_lines[7][15] <= 8'h00;
		ps2_lines[7][16] <= 8'h00;
		ps2_lines[7][17] <= 8'h00;
		ps2_lines[7][18] <= 8'h00;
		ps2_lines[7][19] <= 8'h00;
		ps2_lines[7][20] <= 8'h00;
		ps2_lines[7][21] <= 8'h00;
		ps2_lines[7][22] <= 8'h00;
		ps2_lines[7][23] <= 8'h00;
		ps2_lines[7][24] <= 8'h00;
		ps2_lines[7][25] <= 8'h00;
		ps2_lines[7][26] <= 8'h00;
		ps2_lines[7][27] <= 8'h00;
		ps2_lines[7][28] <= 8'h00;
		ps2_lines[7][29] <= 8'h00;
		ps2_lines[7][30] <= 8'h00;
		ps2_lines[7][31] <= 8'h00;	
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
