def generate_ps2_line_updater():
	lines = []
	for i in range(32):
		lines.append("\tps2_lines[7][{}] <= ps2_line_content[{} : {}];\n".format(i, 255 - i * 8, 255 - i * 8 - 7))
	save_to_file(lines, "line_ready.txt")

def generate_ps2_lines_initiator():
	lines = []
	for i in range(8):
		for j in range(32):
			lines.append("\tps2_lines[{}][{}] <= 8'h00;\n".format(i, j))
	save_to_file(lines, "lines_init.txt")

def genereat_ps2_line_scroll():
	lines = []
	for row in range(1, 8):
		for col in range(32):
			lines.append("ps2_lines[{}][{}] <= ps2_lines[{}][{}];\n".format(row - 1, col, row, col))

	save_to_file(lines, "lines_scroll.txt")

def generate_ps2processormodule_write_char():
	lines = []
	for i in range(0, 32):
		lines.append("end else if (count == 32'd{}) begin\n".format(i))
		lines.append("\tps2_line_content[{}:{}] <= ascii_char;\n".format(255 - i * 8, 255 - i * 8 - 7))
	lines.append("end\n")
	lines[0] = lines[0][9:]
	save_to_file(lines, "ps2processormodule.txt")


def save_to_file(lines, filename):
	with open(filename, "w") as f:
		for l in lines:
			f.write(l) 

generate_ps2_line_updater()
generate_ps2_lines_initiator()
genereat_ps2_line_scroll()
generate_ps2processormodule_write_char()