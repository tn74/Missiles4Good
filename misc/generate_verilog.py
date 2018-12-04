def generate_ps2_line_updater():
	lines = []
	for i in range(32):
		lines.append("\tps2_lines[7][{}] <= ps2_line_content[{} : {}];\n".format(i, 255 - i * 8, 255 - i * 8 - 7))
	
	with open("line_ready.txt", "w") as f:
		for l in lines:
			f.write(l)
def generate_ps2_lines_initiator():
	lines = []
	for i in range(8):
		for j in range(32):
			lines.append("\tps2_lines[{}][{}] <= 8'h00;\n".format(i, j))
	
	with open("lines_init.txt", "w") as f:
		for l in lines:
			f.write(l) 

generate_ps2_line_updater()
generate_ps2_lines_initiator()