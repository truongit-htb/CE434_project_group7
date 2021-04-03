# Chuong trinh python dung de tao data_input cho modelsim
# Ket hop voi hien thuc thuat toan chuyen doi RGB -> HSB bang python
# Sau do ghi lai ket qua cua thuat toan tren de so sanh voi ket qua modelsim

import cv2
import numpy as np
import ctypes

def de2hex_floating_point(x):
   return hex(ctypes.c_uint.from_buffer(ctypes.c_float(x)).value)

img_rgb = cv2.imread('/v_env/ce434/W2/meomeo.jpg')

#img_rgb = cv2.imread('/v_env/ce434/W2/image_resized.png')

# Lay thong tin cua anh
(h, w, d) = img_rgb.shape
print("width={}, height={}, depth={}".format(w, h, d))

####### Dung python tao data input cho modelsim
f = open('data_input.txt', 'w')
for i in range (h):
  for j in range (w):
    b, g, r = img_rgb[i][j]
    if(r != 0): r = de2hex_floating_point(r).replace('0x', '')
    else: r = '00000000'
    if(g != 0): g = de2hex_floating_point(g).replace('0x', '')
    else: g = '00000000'
    if(b != 0): b = de2hex_floating_point(b).replace('0x', '')
    else: b = '00000000'
    string = r + g + b + '\n'
    f.write(string)
f.close()

####### Chay thuat toan chuyen doi RGB -> HSV bang python
def rgb2hsv(r, g, b):
  r_d = r / 255
  g_d = g / 255
  b_d = b / 255

  Cmax = max(r_d, g_d, b_d)
  Cmin = min(r_d, g_d, b_d)

  denta = Cmax - Cmin

  #Hue calculation:
  if(denta == 0):
      h = 0
  elif(Cmax == r_d):
      h = 60*(((g_d - b_d)/denta)%6)
  elif(Cmax == g_d):
      h = 60*((b_d - r_d)/denta + 2)
  elif(Cmax == b_d):
      h = 60*((r_d - g_d) + 4)

  #Saturation calculation:
  if(Cmax == 0):
      s = 0
  else:
      s = (denta/Cmax)*100

  #Value calculation:
  v = Cmax * 100
  #Return result
  return h, s, v

####### Ghi lai ket qua cua thuat toan python de so sanh voi ket qua modelsim
f1 = open('data_out_python.txt', 'w')
for i in range (h):
  for j in range (w):
    b, g, r = img_rgb[i][j]
    h, s, v = rgb2hsv(r, g, b)
    if(h !=0): h = de2hex_floating_point(h).replace('0x', '')
    else: h = '00000000'
    if(s != 0): s = de2hex_floating_point(s).replace('0x', '')
    else: s = '00000000'
    if(v != 0): v = de2hex_floating_point(v).replace('0x', '')
    else: v = '00000000'
    string = h + s + v + '\n'
    f1.write(string)
f1.close()

cv2.imshow("image python", img_rgb)
cv2.waitKey(0)
