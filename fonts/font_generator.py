import numpy as np
from scipy import ndimage, stats
from PIL import Image
import time
from matplotlib import pyplot as plt
from matplotlib import cm as cm
from skimage.transform import resize


import os

class FontGenerator():
	def __init__(self, characters_picture):
		self.fname = characters_picture
		self.character_images = []
		self.bitvectors = []
		self.desired_character_width = 20
		self.desired_character_height = 30

	def populate_character_images(self):
		fullimage = ndimage.imread(self.fname)
		fullimage = fullimage[:,:,0]
		height, width = fullimage.shape[:2]
		print("Width: {0}, Height: {1}".format(width, height))

		chars_in_row = 10
		chars_in_col = 9
		x_coors = [int(width / chars_in_row) * i for i in range(chars_in_row + 1) ]
		y_coors = [int(height / chars_in_col) * i for i in range(chars_in_col + 1)]

		for j in range(chars_in_col):
			for i in range(chars_in_row):
				charim = fullimage[y_coors[j] : y_coors[j+1] , x_coors[i]: x_coors[i+1]]
				self.character_images.append(charim)

	def make_bitvectors(self):
		folder = "character_representations"
		if not os.path.exists(folder):
			os.mkdir(folder)

		for index, im in enumerate(self.character_images):
			h, w = im.shape[:2]
			woff, hoff = 10, 15
			im = im[hoff: h - hoff, woff: w-woff]

			im = resize(im, (self.desired_character_height, self.desired_character_width ), anti_aliasing=True)
			new_im = np.array([ [ (num + 0.5) // 1 for num in row] for row in im])
			plt.imsave(os.path.join(folder, hex(index+33)) , new_im, cmap=cm.gray)

			bitvector = []
			for i in range(len(new_im)):
				for j in range(len(new_im[0])):
					bitvector.append(int(new_im[i][j]))
			# print(len(bitvector))
			self.bitvectors.append(bitvector)

	def save_to_file(self):
		folder = "font_mifs"
		fname = "charwidth={0}__charheight={1}.mif".format(self.desired_character_width, self.desired_character_height)

		if not os.path.exists(folder):
			os.mkdir(folder)

		data_width = self.desired_character_width * self.desired_character_height
		mif = open(os.path.join(folder, fname), 'w')
		mif.write("DEPTH = {0};\n".format(256))
		mif.write("WIDTH = {0};\n".format(data_width))
		mif.write("ADDRESS_RADIX = DEC;\nDATA_RADIX = BIN;\n\nCONTENT\nBEGIN\n")


		# l = 
		dummy_string = "".join(["0" for j in range(data_width)])

		mifdata = []
		for i in range(21):
			mifdata.append(dummy_string)
		for i in range(len(self.bitvectors)):
			mifdata.append("".join([str(num) for num in self.bitvectors[i]]))
		while len(mifdata) < 256:
			mifdata.append(dummy_string)

		for address, data in enumerate(mifdata):
			mif.write("{0:03d}\t:\t{1};\n\n".format(address, data))
		
		mif.write("END;")

	def produce_font_bitmap(self):
		self.populate_character_images()
		self.make_bitvectors()
		self.save_to_file()

	# def write_to_file


fg = FontGenerator("ascii.png")
fg.produce_font_bitmap()