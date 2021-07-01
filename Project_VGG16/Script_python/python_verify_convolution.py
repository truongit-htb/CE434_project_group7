import cv2
import numpy as np
import ctypes
import struct

# Ham tao ma tran numpy ngau nhien. VD: a = create_rand_matrix(1, (200, 200, 3))
## mode = 0:    tao ma tran khac nhau trong moi lan chay lai
## mode != 0:   chi tao 1 kieu ma tran duy nhat trong moi lan chay lai
def create_rand_matrix(mode, dim):
    if mode == 0:
        img = np.uint8(np.random.random((dim))*255)
    elif mode == 1:
        rand_array = np.random.RandomState(18)
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


# Ham tinh conv2d tren 1 kernel 1 channel
def conv2d(img, filter):
    img_copy = img.copy()
    h, w = img.shape[0:2]

    sobel_matrix = np.zeros((h-2, w-2)) ######
    for i in range(1, h-1):
        for j in range(1, w-1):
            center_pixel = [i, j]
            center_filter = [1, 1]
            xRow = [0, 0, 1, -1, 1, -1, 1, -1]
            yCol = [-1, 1, 0, 0, -1, -1, 1, 1]

            new_value = 0
            for k in range(8):
                item = [xRow[k], yCol[k]]
                pixel_in_image_x = center_pixel[0] + item[0]
                pixel_in_image_y = center_pixel[1] + item[1]
                pixel_in_filter_x = center_filter[0] + item[0]
                pixel_in_filter_y = center_filter[1] + item[1]

                new_value += img[pixel_in_image_x, pixel_in_image_y] * filter[pixel_in_filter_x, pixel_in_filter_y]
            new_value += img[i, j] * filter[1, 1]

            # if new_value < 0:
            #     new_value = 0
            # if new_value > 255:
            #     new_value = 255
            
            sobel_matrix[i-1, j-1] = new_value
    return sobel_matrix  


# Ham tinh conv3d tren 1 kernel n channel
def conv3d(img, filter, bias):
    img_copy = img.copy()
    h, w, d = img.shape[0:3]

    sobel_matrix = np.zeros((h-2, w-2)) ######
    for i in range(1, h-1):
        for j in range(1, w-1):
            center_pixel = [i, j]
            center_filter = [1, 1]
            xRow = [0, 0, 1, -1, 1, -1, 1, -1]
            yCol = [-1, 1, 0, 0, -1, -1, 1, 1]
                
            new_value = 0
            for t in range(d):                
                for k in range(8):
                    item = [xRow[k], yCol[k]]
                    pixel_in_image_x  = center_pixel[0] + item[0]
                    pixel_in_image_y  = center_pixel[1] + item[1]
                    pixel_in_filter_x = center_filter[0] + item[0]
                    pixel_in_filter_y = center_filter[1] + item[1]

                    new_value += img[pixel_in_image_x, pixel_in_image_y, t] * filter[pixel_in_filter_x, pixel_in_filter_y, t]
                new_value += img[i, j, t] * filter[1, 1, t]

                # if new_value < 0:
                #     new_value = 0
                # if new_value > 255:
                #     new_value = 255
                
            sobel_matrix[i-1, j-1] = new_value + bias
    return sobel_matrix


# # #----------------- Doc data cho CONVOLUTION 3D #-----------------

# img = np.zeros((20, 20, 3))
# img_dim = img.shape
# # with open('E:\LAB\LAB_20_21_HK_II\CE434-ChuyenDeTKVM\git_vgg16\VGG16\CodePythonCNN\data_image_decimal.txt') as f:
# for i in range(img_dim[2]):
#     file_name = 'data_fp_image_channel_00{0}.txt'.format(i)
#     with open('/home/truong/Desktop/git_vgg16/Data/' + file_name) as f:
#         if f.mode == 'r':
#             data = f.readlines()
#             # print(type(data))
#             for h in range(img_dim[0]):
#                 for w in range(img_dim[1]):
#                     temp = data[h*img_dim[1] + w][:-1]
#                     img[h, w, i] = hex2dec(temp)
#         else:
#             print("can't read file" + file_name )
#     f.close()



# # path on Window
# img = cv2.imread('E:\LAB\LAB_20_21_HK_II\CE434-ChuyenDeTKVM\git_vgg16\VGG16\CodePythonCNN\sun_flower_40x40.jpg', 0)
# path on Ubuntu
# img = cv2.imread('/home/truong/Desktop/git_vgg16/VGG16/CodePythonCNN/sun_flower_40x40.jpg', 0)
# img2 = cv2.imread('/home/truong/Desktop/git_vgg16/VGG16/CodePythonCNN/sun400x500.jpg', 0)
# i_h, i_w = img2.shape[0:2]
# img = np.zeros((i_h, i_w, 2))
# img[:,:,0] = img2
# img[:,:,1] = img2

#----------------- Doc data cho CONVOLUTION 2D #-----------------
img = np.zeros((56, 56))
img_dim = img.shape
file_name = 'data_fp_image_111.txt'
with open('/home/truong/Desktop/CE434_project_group7/Project_VGG16/Data/' + file_name) as f:
    if f.mode == 'r':
        data = f.readlines()
        for h in range(img_dim[0]):
            for w in range(img_dim[1]):
                temp = data[h*img_dim[1] + w][:-1]
                img[h, w] = hex2dec(temp)
    else:
        print("can't read file" + file_name )
f.close()
# # print("Anh dau vao\n ",img)



# #----------------- Doc ket qua modelsim #-----------------
# pixels = []
# # with open("E:/LAB/LAB_20_21_HK_II/CE434-ChuyenDeTKVM/git_vgg16/VGG16/CodePythonCNN/modelsim_out_floating_point.txt") as file:
# # with open("/home/truong/Desktop/git_vgg16/VGG16/CodePythonCNN/modelsim_out_conv3d_1kernel_3channel.txt") as file:
# with open("/home/truong/Desktop/git_vgg16/Data/modelsim_conv3D_1kernel_3channel_333.txt") as file:
#     if file.mode == 'r':
#         data = file.readlines()
#         for line in data:
#             if (line.find("//") == -1):
#                 pixels.append(line)
# file.close()
# #----------------- Doc ket qua 2D #-----------------
pixels = np.zeros((img_dim[0], img_dim[1]))
pixels_dim = pixels.shape
# for kernel in range(pixels_dim[2]):
file_name = 'modelsim_conv2d_1kernel_1channel_000000.txt'
with open('/home/truong/Desktop/CE434_project_group7/Project_VGG16/Data/' + file_name) as f:
    if f.mode == 'r':
        data = f.readlines()
        for h in range(img_dim[0]):
            for w in range(img_dim[1]):
                temp = data[3 + h*img_dim[1] + w][:-1]
                pixels[h, w] = hex2dec(temp)
    else:
        print("can't read file" + file_name )
f.close()

# #----------------- Doc ket qua 3D #-----------------
# pixels = np.zeros((img_dim[0], img_dim[1], 8))
# pixels_dim = pixels.shape
# for kernel in range(pixels_dim[2]):
#     file_name = 'modelsim_conv3D_8kernel_3channel_00{0}.txt'.format(kernel)
#     with open('/home/truong/Desktop/git_vgg16/Data/' + file_name) as f:
#         if f.mode == 'r':
#             data = f.readlines()
#             for h in range(img_dim[0]):
#                 for w in range(img_dim[1]):
#                     temp = data[3 + h*img_dim[1] + w][:-1]
#                     pixels[h, w, kernel] = hex2dec(temp)
#         else:
#             print("can't read file" + file_name )
#     f.close()



#----------------- Thuc hien conv2d tren anh dau vao 1 channel #-----------------
# Lay thong tin anh img
h, w = img.shape[0:2]
# Thuc hien padding cho ma tran img 
img_padding = np.zeros((h+2, w+2))
img_padding[1:h+1, 1:w+1] = img[:, :]
# print("Anh Padding\n ",img_padding)

# Filer Gx
filter_Gx = np.array(
    [[  1,  1.1,  1],
    [   0,    0,  0],
    [  -1, -1.1, -1]])

# Sobel Gx
out_Gx = conv2d(img_padding.copy(), filter_Gx)



# #----------------- Thuc hien conv3D tren anh dau vao n Channel #-----------------
# # Lay thong tin anh img
# h, w, d = img.shape
# # Thuc hien padding cho ma tran img 
# img_padding = np.zeros((h+2, w+2, d))
# img_padding[1:h+1, 1:w+1, :] = img[:, :, :]

# out_Gx = np.zeros((h, w, 8))

# # ------- Doc cac file trong so WEIGHT
# for kernel in range(8):
#     filter_Gx = np.zeros((3, 3, 3))
#     filter_dim = filter_Gx.shape
#     # with open('E:\LAB\LAB_20_21_HK_II\CE434-ChuyenDeTKVM\git_vgg16\VGG16\CodePythonCNN\data_image_decimal.txt') as f:
#     for channel in range(filter_dim[2]):
#         weight_name = 'block1_conv1_3chanel_8filter_channel_{0}filter_{1}.txt'.format(channel, kernel)
#         with open('/home/truong/Desktop/git_vgg16/Data/1_weight/' + weight_name) as f:
#             if f.mode == 'r':
#                 data = f.readlines()
#                 # print(type(data))
#                 for h in range(filter_dim[0]):
#                     for w in range(filter_dim[1]):
#                         temp = data[h*filter_dim[1] + w][:-1]
#                         filter_Gx[h, w, channel] = hex2dec(bin2hex(temp))
#             else:
#                 print("can't read file" + weight_name )
#         f.close()

#     # ----- Doc file trong so BIAS
#     bias_name = 'block1_conv1_3chanel_8filter_bias.txt'
#     with open('/home/truong/Desktop/git_vgg16/Data/0_bias/' + bias_name) as f:
#         if f.mode == 'r':
#             data_bias = f.readlines()
#         else:
#             print("can't read file" + bias_name )
#     f.close()

#     bias_weight = hex2dec(bin2hex(data_bias[kernel]))

#     out_Gx[:, :, kernel] = conv3d(img_padding.copy(), filter_Gx, bias_weight)
# ------------------------------------------

# # Filer Gx
# filter_Gx = np.zeros((3, 3, 3))
# filter_Gx[:, :, 0] = np.array(
#     [[1, 1.1, 1],
#     [0, 0, 0],
#     [-1, -1.1, -1]])
# filter_Gx[:, :, 1] = np.array(
#     [[1, 0, -1],
#     [2, 0, -2],
#     [1, 0, -1]])
# filter_Gx[:, :, 2] = np.array(
#     [[1.5, 1, 0],
#     [1, 0, -1],
#     [0, -1, -1.5]])
# bias_weight = hex2dec('00000000')
# # print(bias_weight)
# # print(filter_Gx)

# # Sobel Gx
# out_Gx = conv3d(img_padding.copy(), filter_Gx, bias_weight)
# # print('done')
# # cv2.imshow('out python conv3d', out_Gx)

# print(out_Gx.shape)


############ Tinh do sai lech ###############
if (len(pixels_dim) == 2):  # ------- Verify Anh dau vao 2D
    correct = 0
    fault = []
    error = 0.0
    max_err = 0.0
    min_err = 0.0
    py_error = 0.0
    py_max_err = 0.0
    py_min_err = 0.0
    h2, w2 = out_Gx.shape[0:2]
    for i in range (h2):
        for j in range (w2):        
            bin_conv_py = dec2bin(out_Gx[i, j])

            # hex_conv_sim = pixels[i*w2 + j][:-1]    # chu y file out modelsim co ki tu \n nen can loai bo
            dec_conv_sim = pixels[i, j]
            bin_conv_sim = dec2bin(dec_conv_sim)
            # print('{0}\t{1}\t{2}'.format(i, hex_conv_py, hex_conv_sim))

            py_error = abs(out_Gx[i, j] - dec_conv_sim)
            if (py_error < 2.0):
            # if (bin_conv_py[0:9] == bin_conv_sim[0:9]):
                error = 0.0

                for k in range (1, 32, 1):
                    if bin_conv_py[k] > bin_conv_sim[k]:
                        error += 2**(8 - k)
                    elif bin_conv_py[k] < bin_conv_sim[k]:
                        error -= 2**(8 - k)
                error = abs(error)
            else:
                fault.append((i, j))
                # error = abs(out_Gx[i][j] - hex2dec(hex_conv_sim))
                # continue


            if (i == 0):
                max_err = error
                min_err = error
                py_max_err = py_error
                py_min_err = py_error
            else:
                if (error > max_err):
                    max_err = error
                if (error < min_err):
                    min_err = error

                if (py_error > py_max_err):
                    py_max_err = py_error
                if (py_error < py_min_err):
                    py_min_err = py_error
                
            if (bin_conv_py == bin_conv_sim):
                correct += 1

    print('\nSo phep tinh chinh xac: ', correct)
    print('So phep tinh gan dung: ', h2 * w2 - correct - len(fault))
    print('So phep tinh sai: ', len(fault))
    print('Do sai lech phep tinh GAN DUNG modelsim vs python: max = {0}, min = {1}'.format(max_err, min_err))
    print('Do sai lech modelsim vs python: max = {0}, min = {1}'.format(py_max_err, py_min_err))
  
    # for i in range(len(fault)):
    #     print('{0}   \t{1}   \t{2}'.format(fault[i], dec2hex_fp(out_Gx[fault[i]]) , pixels[fault[i]]))

else:   # ------- Verify Anh dau vao 3D
    for kernel in range(pixels_dim[2]):
        correct = 0
        fault = []
        error = 0.0
        max_err = 0.0
        min_err = 0.0
        py_error = 0.0
        py_max_err = 0.0
        py_min_err = 0.0
        h2, w2 = out_Gx[:, :, kernel].shape[0:2]
        for i in range (h2):
            for j in range (w2):        
                bin_conv_py = dec2bin(out_Gx[i, j, kernel])

                # hex_conv_sim = pixels[i*w2 + j][:-1]    # chu y file out modelsim co ki tu \n nen can loai bo
                dec_conv_sim = pixels[i, j, kernel]
                bin_conv_sim = dec2bin(dec_conv_sim)
                # print('{0}\t{1}\t{2}'.format(i, hex_conv_py, hex_conv_sim))

                py_error = abs(out_Gx[i, j, kernel] - dec_conv_sim)
                if (py_error < 2.0):
                # if (bin_conv_py[0:9] == bin_conv_sim[0:9]):
                    error = 0.0

                    for k in range (1, 32, 1):
                        if bin_conv_py[k] > bin_conv_sim[k]:
                            error += 2**(8 - k)
                        elif bin_conv_py[k] < bin_conv_sim[k]:
                            error -= 2**(8 - k)
                    error = abs(error)
                else:
                    fault.append((i, j))
                    # error = abs(out_Gx[i][j] - hex2dec(hex_conv_sim))
                    # continue


                if (i == 0):
                    max_err = error
                    min_err = error
                    py_max_err = py_error
                    py_min_err = py_error
                else:
                    if (error > max_err):
                        max_err = error
                    if (error < min_err):
                        min_err = error

                    if (py_error > py_max_err):
                        py_max_err = py_error
                    if (py_error < py_min_err):
                        py_min_err = py_error
                    
                if (bin_conv_py == bin_conv_sim):
                    correct += 1
        
        print('\nKernel ', kernel)
        print('So phep tinh chinh xac: ', correct)
        print('So phep tinh gan dung: ', h2 * w2 - correct - len(fault))
        print('So phep tinh sai: ', len(fault))
        print('Do sai lech phep tinh GAN DUNG modelsim vs python: max = {0}, min = {1}'.format(max_err, min_err))
        print('Do sai lech modelsim vs python: max = {0}, min = {1}'.format(py_max_err, py_min_err))

        # for i in range(len(fault)):
        #     print('{0}   \t{1}   \t{2}'.format(fault[i], dec2hex_fp(out_Gx[fault[i]]) , pixels[fault[i]]))




# ############ Khoi phuc lai anh conv_py ############
# out_py = np.uint8(out_Gx)
# # img0 = cv2.imread('restored_image.png')
# cv2.imshow('conv_py', out_py)

# height, width = out_Gx.shape[0:2]
# out_sim = np.zeros((height, width))
# # index = 0
# for i in range(height):
#     for j in range(width):
#         out_sim[i, j] = hex2dec(pixels[i*width + j][:-1])
#         #  struct.unpack('!f', bytes.fromhex(pixels[index][0:8]))[0]
#         # h = int(h)
#         # s = int(s)
#         # # v = int(v)
#         # imgg[i,j] = np.array([h, s, v])
#         # if( index < height*width):
#         # index = index + 1
# out_modelsim = np.uint8(out_sim)
# # img0 = cv2.imread('restored_image.png')
# cv2.imshow('modelsim', out_modelsim)


# ####################################################
# # print('{0}\t{1}\t{2}'.format(fault[i], dec2hex_fp(out_Gx[fault[i]]) , pixels[fault[i][0]*w2 + fault[i][1]][:-1]))

# cv2.waitKey(0)
# cv2.destroyAllWindows()


