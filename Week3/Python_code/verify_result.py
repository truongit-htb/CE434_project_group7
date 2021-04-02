import cv2
import numpy as np
import ctypes
import struct


img = cv2.imread('/v_env/ce434/W2/meomeo.jpg')

########## Recovery image from modelsim's output ##########
pixels = []
with open("data_out_modelsim.txt") as file:
  if file.mode == 'r':
    data = file.readlines()
    for line in data:
      if (line.find("//") == -1):
        pixels.append(line)
file.close()

imgg = img.copy()
(height, width, channel) = imgg.shape
index = 0
for i in range(height):
  for j in range(width):
    h = struct.unpack('!f', bytes.fromhex(pixels[index][0:8]))[0]
    s = struct.unpack('!f', bytes.fromhex(pixels[index][8:16]))[0]
    v = struct.unpack('!f', bytes.fromhex(pixels[index][16:24]))[0]
    h = int(h)
    s = int(s)
    v = int(v)
    imgg[i,j] = np.array([h, s, v])
    if( index < height*width):
      index = index + 1

cv2.imwrite('restored_image.png', imgg)
###########################################################



for i in range(100000):
  for j in range(10):
    i = i
img0 = cv2.imread('restored_image.png')
cv2.imshow('modelsim', img0)

######## Tinh sai so (verify) ########
pixels_py = []
with open("data_out_python.txt") as file:
  if file.mode == 'r':
    data1 = file.readlines()
    for line in data1:
      if (line.find("//") == -1):
        pixels_py.append(line)
file.close()

h_err = s_err = v_err = 0.0
max_h = min_h = max_s = min_s = max_v = min_v = 0.0
for index in range(len(pixels_py)):
  h_temp = abs(struct.unpack('!f', bytes.fromhex(pixels[index][0:8]))[0] - struct.unpack('!f', bytes.fromhex(pixels_py[index][0:8]))[0])
  s_temp = abs(struct.unpack('!f', bytes.fromhex(pixels[index][8:16]))[0] - struct.unpack('!f', bytes.fromhex(pixels_py[index][8:16]))[0])
  v_temp = abs(struct.unpack('!f', bytes.fromhex(pixels[index][16:24]))[0] - struct.unpack('!f', bytes.fromhex(pixels_py[index][16:24]))[0])
  
  if (h_temp > max_h):
    max_h = h_temp
  if (h_temp < min_h):
    min_h = h_temp

  if (s_temp > max_s):
    max_s = s_temp
  if (s_temp < min_s):
    min_s = s_temp

  if (v_temp > max_v):
    max_v = v_temp
  if (v_temp < min_v):
    min_v = v_temp
h_err = (max_h + min_h) / 2
s_err = (max_s + min_s) / 2
v_err = (max_v + min_v) / 2
print('\nMuc sai so trung binh cua h: ', h_err)
print('\nMuc sai so trung binh cua s: ', s_err)
print('\nMuc sai so trung binh cua v: ', v_err)

cv2.waitKey(0)
cv2.destroyAllWindows()
