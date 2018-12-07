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
			if (count == 32'd0) begin
				char_index <= 8'd175;
				char_data <= target_regs[0][0];
				count <= count + 32'd1;
			end else if (count == 32'd1) begin
				char_index <= 8'd176;
				char_data <= target_regs[0][1];
				count <= count + 32'd1;
			end else if (count == 32'd2) begin
				char_index <= 8'd178;
				char_data <= target_regs[0][2];
				count <= count + 32'd1;
			end else if (count == 32'd3) begin
				char_index <= 8'd179;
				char_data <= target_regs[0][3];
				count <= count + 32'd1;
			end else if (count == 32'd4) begin
				char_index <= 8'd181;
				char_data <= target_regs[0][4];
				count <= count + 32'd1;
			end else if (count == 32'd5) begin
				char_index <= 8'd182;
				char_data <= target_regs[0][5];
				count <= count + 32'd1;
			end else if (count == 32'd6) begin
				char_index <= 8'd184;
				char_data <= target_regs[0][6];
				count <= count + 32'd1;
			end else if (count == 32'd7) begin
				char_index <= 8'd185;
				char_data <= target_regs[0][7];
				count <= count + 32'd1;
			end else if (count == 32'd8) begin
				char_index <= 8'd207;
				char_data <= target_regs[1][0];
				count <= count + 32'd1;
			end else if (count == 32'd9) begin
				char_index <= 8'd208;
				char_data <= target_regs[1][1];
				count <= count + 32'd1;
			end else if (count == 32'd10) begin
				char_index <= 8'd210;
				char_data <= target_regs[1][2];
				count <= count + 32'd1;
			end else if (count == 32'd11) begin
				char_index <= 8'd211;
				char_data <= target_regs[1][3];
				count <= count + 32'd1;
			end else if (count == 32'd12) begin
				char_index <= 8'd213;
				char_data <= target_regs[1][4];
				count <= count + 32'd1;
			end else if (count == 32'd13) begin
				char_index <= 8'd214;
				char_data <= target_regs[1][5];
				count <= count + 32'd1;
			end else if (count == 32'd14) begin
				char_index <= 8'd216;
				char_data <= target_regs[1][6];
				count <= count + 32'd1;
			end else if (count == 32'd15) begin
				char_index <= 8'd217;
				char_data <= target_regs[1][7];
				count <= count + 32'd1;
			end else if (count == 32'd16) begin
				char_index <= 8'd239;
				char_data <= target_regs[2][0];
				count <= count + 32'd1;
			end else if (count == 32'd17) begin
				char_index <= 8'd240;
				char_data <= target_regs[2][1];
				count <= count + 32'd1;
			end else if (count == 32'd18) begin
				char_index <= 8'd242;
				char_data <= target_regs[2][2];
				count <= count + 32'd1;
			end else if (count == 32'd19) begin
				char_index <= 8'd243;
				char_data <= target_regs[2][3];
				count <= count + 32'd1;
			end else if (count == 32'd20) begin
				char_index <= 8'd245;
				char_data <= target_regs[2][4];
				count <= count + 32'd1;
			end else if (count == 32'd21) begin
				char_index <= 8'd246;
				char_data <= target_regs[2][5];
				count <= count + 32'd1;
			end else if (count == 32'd22) begin
				char_index <= 8'd248;
				char_data <= target_regs[2][6];
				count <= count + 32'd1;
			end else if (count == 32'd23) begin
				char_index <= 8'd249;
				char_data <= target_regs[2][7];
				count <= count + 32'd1;
			end else if (count == 32'd24) begin
				char_index <= 8'd116;
				char_data <= target_regs[3][0];
				count <= count + 32'd1;
			end else if (count == 32'd25) begin
				char_index <= 8'd117;
				char_data <= target_regs[3][1];
				count <= count + 32'd1;
			end else if (count == 32'd26) begin
				char_index <= 8'd119;
				char_data <= target_regs[3][2];
				count <= count + 32'd1;
			end else if (count == 32'd27) begin
				char_index <= 8'd120;
				char_data <= target_regs[3][3];
				count <= count + 32'd1;
			end else if (count == 32'd28) begin
				char_index <= 8'd122;
				char_data <= target_regs[3][4];
				count <= count + 32'd1;
			end else if (count == 32'd29) begin
				char_index <= 8'd123;
				char_data <= target_regs[3][5];
				count <= count + 32'd1;
			end else if (count == 32'd30) begin
				char_index <= 8'd125;
				char_data <= target_regs[3][6];
				count <= count + 32'd1;
			end else if (count == 32'd31) begin
				char_index <= 8'd126;
				char_data <= target_regs[3][7];
				count <= count + 32'd1;
			end
		end
	end

	
endmodule
