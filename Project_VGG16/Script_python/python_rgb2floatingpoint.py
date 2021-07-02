# Chuong trinh python dung de tao data_input cho modelsim

import cv2
import numpy as np
import ctypes
import math
import struct

# Ham tao ma tran numpy ngau nhien. VD: a = create_rand_matrix(1, (200, 200, 3))
## mode = 0:    tao ra ma tran int khac nhau trong moi lan chay lai
## mode = 1:    chi tao 1 kieu ma tran duy nhat trong moi lan chay lai
## else:        tao ra ma tran float khac nhau trong moi lan chay lai
def create_rand_matrix(mode, dim):
    if mode == 0:
        img = np.uint8(np.random.random((dim))*255)
    elif mode == 1:
        rand_array = np.random.RandomState(2021)
        size_matrix = 1
        for item in dim:
            size_matrix *= item
        # img = np.uint8(rand_array.randint(0, 20, size = size_matrix)).reshape(dim)
        img = rand_array.randint(-255, 255, size = size_matrix).reshape(dim)
    else:
        img = np.random.uniform(low = -255, high = 255, size = dim)
    return img


# Ham chuyen so decimal sang so hexa floating point
def dec2hex_fp(x):
    if (x != 0):
        return hex(ctypes.c_uint.from_buffer(ctypes.c_float(x)).value)[2:]  # bo ki tu 0x o dau chuoi hex
    else: 
        return '00000000'


def dec2bin(x):
    if x == 0:
        tempp = '00000000000000000000000000000000'
    else:
        tempp = bin(ctypes.c_uint.from_buffer(ctypes.c_float(x)).value)[2:]
        if (len(tempp) < 32):
            pad = 32 - len(tempp)
            for i in range(pad):
                tempp = '0' + tempp
    return tempp


def hex2dec(x):
    if (x == "xxxxxxxx"):
        return 2**32
    else:
        return struct.unpack('!f', bytes.fromhex(x))[0]


def bin2hex(input):
    return hex(int(input, 2))[2:]


#------------------- MAIN #-------------------
img_rgb = cv2.imread('/home/truong/Desktop/CE434_project_group7/Project_VGG16/Data/sun56x56.jpg')
# img_rgb = cv2.resize(img_rgb, (56, 56))
# cv2.imshow('input56x56', img_rgb)
# cv2.waitKey(0)
# cv2.destroyAllWindows()
# cv2.imwrite('../Data/sun56x56.jpg', img_rgb)    # CHI CHAY 1 LAN

# #-------- Tao anh 2D ngau nhien
# img_rgb = create_rand_matrix(0, (56, 56))
# # Lay thong tin cua anh
# dim = img_rgb.shape[0:2]
# # #-------- Tao anh 3D ngau nhien
# img_rgb = create_rand_matrix(1, (20, 20, 3))
dim = img_rgb.shape

print(dim)


# # #-------- Tao filter 2D
# # img_rgb = np.array(
# #     [[  1,  1.1,  1],
# #     [   0,    0,  0],
# #     [  -1, -1.1, -1]])
# # #------- Tao filter 3D
# # # Filer Gx
# img_rgb = np.zeros((3, 3, 3))
# img_rgb[:, :, 0] = np.array(
#     [[1, 1.1, 1],
#     [0, 0, 0],
#     [-1, -1.1, -1]])
# img_rgb[:, :, 1] = np.array(
#     [[1, 0, -1],
#     [2, 0, -2],
#     [1, 0, -1]])
# img_rgb[:, :, 2] = np.array(
#     [[1.5, 1, 0],
#     [1, 0, -1],
#     [0, -1, -1.5]])
# dim = img_rgb.shape






# #------------------- Doc du lieu tu file co san #-------------------

# name = 'data_mult_decimal.txt'
# data_in = []
# with open("/home/truong/Desktop/BT-Tuan10/" + name) as file:
#     if file.mode == 'r':
#         data = file.readlines()
#         for line in data:
#             if (line.find("//") == -1):
#                 data_in.append(line)
# file.close()



#------------------- Dung python tao data input cho modelsim #-------------------
# ------- Ghi file Anh dau vao 2D
if (len(dim) == 2):   
    file_name = 'image_111.txt'
    # f  = open('/home/truong/Desktop/git_vgg16/VGG16/CodePythonCNN/data_fp_weight_block0_conv0_kernel0_channel_1.txt', 'w')
    # f2 = open('/home/truong/Desktop/git_vgg16/VGG16/CodePythonCNN/data_decimal_weight_block0_conv0_kernel0_channel_1.txt', 'w')
    f = open('/home/truong/Desktop/git_vgg16/Data/data_fp_' + file_name, 'w')
    f2 = open('/home/truong/Desktop/git_vgg16/Data/data_decimal_' + file_name, 'w')
    for i in range (dim[0]):
        for j in range (dim[1]):
            r = img_rgb[i][j]
            # r = math.exp(i*w + j)
            f2.write(str(r) + '\n')
            s = dec2hex_fp(r)
            string = s + '\n'
            f.write(string)
    f.close()
    f2.close()
    print('File {0} has done!'.format(file_name))
    print('\nPLEASE UPDATE DIMENSION IN TESTBENCH & VERIFY: h = {0}, w = {1}'.format(dim[0], dim[1]))
# ------- Ghi file Anh dau vao 3D
else: 
    for k in range(dim[2]):
        file_name = 'image_channel_00{0}.txt'.format(k)
        # f  = open('/home/truong/Desktop/git_vgg16/VGG16/CodePythonCNN/data_fp_weight_block0_conv0_kernel0_channel_1.txt', 'w')
        # f2 = open('/home/truong/Desktop/git_vgg16/VGG16/CodePythonCNN/data_decimal_weight_block0_conv0_kernel0_channel_1.txt', 'w')
        f  = open('../Data/data_fp_' + file_name, 'w')
        f2 = open('../Data/data_decimal_' + file_name, 'w')
        for i in range (dim[0]):
            for j in range (dim[1]):
                r = img_rgb[i][j][k]
                f2.write(str(r) + '\n')
                s = dec2hex_fp(r)
                string = s + '\n'
                f.write(string)
        f.close()
        f2.close()
        print('File {0} has done!'.format(file_name))
    print('\nPLEASE UPDATE DIMENSION IN TESTBENCH & VERIFY: h = {0}, w = {1}'.format(dim[0], dim[1]))


# -------------- Tao file dimension.v --------------
file_name = 'dimension.v'
f  = open('../Verilog/rtl/' + file_name, 'w')
string = "`define IMG_HEIGHT {0}\n`define IMG_WIDTH {1}".format(dim[0], dim[1])
f.write(string)
f.close()
print('File {0} has done!'.format(file_name))