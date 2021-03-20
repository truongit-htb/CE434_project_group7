import cv2
import numpy

img = cv2.imread('meomeo.jpg')

# Lay thong tin cua anh
(h, w, d) = img.shape
print("width={}, height={}, depth={}".format(w, h, d))

f = open('text.txt', 'w')
for i in range (h):
  for j in range (w):
    b, g, r = img[i][j]
    if(r < 16):
        r = '0' + hex(r).replace('0x', '')
    else: 
        r = hex(r).replace('0x', '')
    if(g < 16):
        g = '0' + hex(g).replace('0x', '')
    else: 
        g = hex(g).replace('0x', '')
    if(b < 16):
        b = '0' + hex(b).replace('0x', '')
    else: 
        b = hex(b).replace('0x', '')
    string = r + g + b + '\n'
    f.write(string)

cv2.imshow('RGB', img)
cv2.waitKey(0)
cv2.destroyAllWindows()