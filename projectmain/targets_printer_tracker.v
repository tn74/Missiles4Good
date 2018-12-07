module targets_printer_tracker(clock, start, targetx, targety, char_index, char_data, finish, queue);
	input clock, start, queue;
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
	
	reg[7:0] target_regs[3:0][7:0];
	reg[31:0] queue_index;
	
	initial
	begin
		char_data <= 8'd00;
		char_index <= 8'd116;
		queue_index <= 32'd0;
		count <= 32'd32;
	end
	
	
	always @(posedge clock) begin
		target_regs[3][0] <= x_3; 
		target_regs[3][1] <= x_2; 
		target_regs[3][2] <= x_1; 
		target_regs[3][3] <= x_0; 
		target_regs[3][4] <= y_3; 
		target_regs[3][5] <= y_2; 
		target_regs[3][6] <= y_1; 
		target_regs[3][7] <= y_0; 
	end
	
	always @(posedge queue) begin
		target_regs[queue_index][0] <= target_regs[3][0];
		target_regs[queue_index][1] <= target_regs[3][1];
		target_regs[queue_index][2] <= target_regs[3][2];
		target_regs[queue_index][3] <= target_regs[3][3];
		target_regs[queue_index][4] <= target_regs[3][4];
		target_regs[queue_index][5] <= target_regs[3][5];
		target_regs[queue_index][6] <= target_regs[3][6];
		target_regs[queue_index][7] <= target_regs[3][7];
		queue_index <= (queue_index + 1) % 3;
	end
	
// ----------------------------- Loop for printing to screen ---------------------
	reg[31:0] count;
	assign finish = (count == 32'd32);
	always @(posedge clock)
	begin
		if (start) begin
			count <= 32'd0;
		end else begin
			if (count == 0) begin
				char_index <= 8'd176;
				char_data <= target_regs[0][0];
			end else if (count == 1) begin
				char_index <= 8'd177;
				char_data <= target_regs[0][1];
			end else if (count == 2) begin
				char_index <= 8'd179;
				char_data <= target_regs[0][2];
			end else if (count == 3) begin
				char_index <= 8'd180;
				char_data <= target_regs[0][3];
			end else if (count == 4) begin
				char_index <= 8'd182;
				char_data <= target_regs[0][4];
			end else if (count == 5) begin
				char_index <= 8'd183;
				char_data <= target_regs[0][5];
			end else if (count == 6) begin
				char_index <= 8'd185;
				char_data <= target_regs[0][6];
			end else if (count == 7) begin
				char_index <= 8'd186;
				char_data <= target_regs[0][7];
			end else if (count == 8) begin
				char_index <= 8'd208;
				char_data <= target_regs[1][0];
			end else if (count == 9) begin
				char_index <= 8'd209;
				char_data <= target_regs[1][1];
			end else if (count == 10) begin
				char_index <= 8'd211;
				char_data <= target_regs[1][2];
			end else if (count == 11) begin
				char_index <= 8'd212;
				char_data <= target_regs[1][3];
			end else if (count == 12) begin
				char_index <= 8'd214;
				char_data <= target_regs[1][4];
			end else if (count == 13) begin
				char_index <= 8'd215;
				char_data <= target_regs[1][5];
			end else if (count == 14) begin
				char_index <= 8'd217;
				char_data <= target_regs[1][6];
			end else if (count == 15) begin
				char_index <= 8'd218;
				char_data <= target_regs[1][7];
			end else if (count == 16) begin
				char_index <= 8'd240;
				char_data <= target_regs[2][0];
			end else if (count == 17) begin
				char_index <= 8'd241;
				char_data <= target_regs[2][1];
			end else if (count == 18) begin
				char_index <= 8'd243;
				char_data <= target_regs[2][2];
			end else if (count == 19) begin
				char_index <= 8'd244;
				char_data <= target_regs[2][3];
			end else if (count == 20) begin
				char_index <= 8'd246;
				char_data <= target_regs[2][4];
			end else if (count == 21) begin
				char_index <= 8'd247;
				char_data <= target_regs[2][5];
			end else if (count == 22) begin
				char_index <= 8'd249;
				char_data <= target_regs[2][6];
			end else if (count == 23) begin
				char_index <= 8'd250;
				char_data <= target_regs[2][7];
			end else if (count == 24) begin
				char_index <= 8'd116;
				char_data <= target_regs[3][0];
			end else if (count == 25) begin
				char_index <= 8'd117;
				char_data <= target_regs[3][1];
			end else if (count == 26) begin
				char_index <= 8'd119;
				char_data <= target_regs[3][2];
			end else if (count == 27) begin
				char_index <= 8'd120;
				char_data <= target_regs[3][3];
			end else if (count == 28) begin
				char_index <= 8'd122;
				char_data <= target_regs[3][4];
			end else if (count == 29) begin
				char_index <= 8'd123;
				char_data <= target_regs[3][5];
			end else if (count == 30) begin
				char_index <= 8'd125;
				char_data <= target_regs[3][6];
			end else if (count == 31) begin
				char_index <= 8'd127;
				char_data <= target_regs[3][7];
			end
			count <= count + 1;
		end
	end

	
endmodule
