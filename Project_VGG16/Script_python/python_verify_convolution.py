import cv2
import numpy as np
import ctypes
import struct

# Ham tao ma tran numpy ngau nhien. VD: a = create_rand_matrix(1, (200, 200, 3))
## mode = 0:    tao ra ma tran int khac nhau trong moi lan chay lai
## mode = 1:    chi tao 1 kieu ma tran duy nhat trong moi lan chay lai
## else:        tao ra ma tran float khac nhau trong moi lan chay lai
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


# Ham doc data dau vao cho CONV PYTHON
def read_data_4conv_py(img_dim, file_name):
    img = np.zeros(img_dim)

    if (len(img_dim) == 2):
        #----------------- Doc data dau vao cho conv2D PYTHON -----------------
        with open(file_name) as f:
            if f.mode == 'r':
                data = f.readlines()
                for h in range(img_dim[0]):
                    for w in range(img_dim[1]):
                        temp = data[h*img_dim[1] + w][:-1]
                        img[h, w] = hex2dec(temp)
            else:
                print("can't read file" + file_name )
        f.close()
    else:
        # #----------------- Doc data dau vao cho conv3D PYTHON -----------------
        for i in range(img_dim[2]):
            # file_name = '../Data/' +  'data_fp_image_channel_00{0}.txt'.format(i)
            with open(file_name.format(i)) as f:
                if f.mode == 'r':
                    data = f.readlines()
                    # print(type(data))
                    for h in range(img_dim[0]):
                        for w in range(img_dim[1]):
                            temp = data[h*img_dim[1] + w][:-1]
                            img[h, w, i] = hex2dec(temp)
                else:
                    print("can't read file" + file_name )
            f.close()
    
    return img


# Ham doc data out CONV MODELSIM
def read_data_4conv_sim(sim_dim, file_name):
    sim = np.zeros(sim_dim)

    if (len(sim_dim) == 2):       
        # #----------------- Doc ket qua 2D #-----------------        
        with open(file_name) as f:
            if f.mode == 'r':
                data = f.readlines()
                for h in range(sim_dim[0]):
                    for w in range(sim_dim[1]):
                        # # OLD
                        # temp = data[3 + h*sim_dim[1] + w][:-1]
                        # # NEW
                        temp = data[h*sim_dim[1] + w][:-1]

                        sim[h, w] = hex2dec(temp)
            else:
                print("can't read file" + file_name )
        f.close()
    else:
        #----------------- Doc ket qua 3D #-----------------
        for kernel in range(sim_dim[2]):
            # file_name = '../Data/' +  'modelsim_block1_conv1_00{0}.txt'.format(kernel)
            with open(file_name.format(kernel)) as f:
                if f.mode == 'r':
                    data = f.readlines()
                    for h in range(sim_dim[0]):
                        for w in range(sim_dim[1]):
                            # # EX
                            # temp = data[3 + h*sim_dim[1] + w][:-1]
                            # # NEW
                            temp = data[h*sim_dim[1] + w][:-1]

                            sim[h, w, kernel] = hex2dec(temp)
                else:
                    print("can't read file" + file_name )
            f.close()

    return sim



# # ###########################
# #          MAIN 
# # ###########################

file_name = '../Data/data_fp_image_channel_00{0}.txt'
# file_name = '../Data/data_fp_image_channel_002.txt'
img_dim = (56, 56, 3)
img = read_data_4conv_py(img_dim, file_name)


file_name = '../Data/' +  'modelsim_block1_conv1_00{0}.txt'
# file_name = '../Data/' +  'modelsim_conv2d_channel_222.txt'
sim_dim = (56, 56, 8)
sim = read_data_4conv_sim(sim_dim, file_name)


############ PYTHON convolution ###############
if (len(sim_dim) == 2):
    #----------------- PYTHON conv2d tren anh dau vao 1 channel #-----------------
    # Lay thong tin anh img
    h, w = img_dim
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
else:
    #----------------- PYTHON conv3D tren anh dau vao n Channel #-----------------
    # Lay thong tin anh img
    h, w, d = img_dim
    # Thuc hien padding cho ma tran img 
    img_padding = np.zeros((h+2, w+2, d))
    img_padding[1:h+1, 1:w+1, :] = img[:, :, :]

    out_Gx = np.zeros((h, w, 8))

    # ------- Doc cac file trong so WEIGHT
    for kernel in range(8):
        filter_Gx = np.zeros((3, 3, 3))
        filter_dim = filter_Gx.shape

        for channel in range(filter_dim[2]):
            weight_name = 'block1_conv1_3chanel_8filter_channel_{0}filter_{1}.txt'.format(channel, kernel)
            with open('../Data/1_weight/' + weight_name) as f:
                if f.mode == 'r':
                    data = f.readlines()
                    # print(type(data))
                    for h in range(filter_dim[0]):
                        for w in range(filter_dim[1]):
                            temp = data[h*filter_dim[1] + w][:-1]
                            filter_Gx[h, w, channel] = hex2dec(bin2hex(temp))
                else:
                    print("can't read file" + weight_name )
            f.close()

        # ----- Doc file trong so BIAS
        bias_name = 'block1_conv1_3chanel_8filter_bias.txt'
        with open('../Data/0_bias/' + bias_name) as f:
            if f.mode == 'r':
                data_bias = f.readlines()
            else:
                print("can't read file" + bias_name )
        f.close()

        bias_weight = hex2dec(bin2hex(data_bias[kernel]))

        out_Gx[:, :, kernel] = conv3d(img_padding.copy(), filter_Gx, bias_weight)
# # ------------------------------------------



############ Tinh do sai lech ###############
if (len(sim_dim) == 2):  # ------- Verify Anh dau vao 2D
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

            # hex_conv_sim = sim[i*w2 + j][:-1]    # chu y file out modelsim co ki tu \n nen can loai bo
            dec_conv_sim = sim[i, j]
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
    #     print('{0}   \t{1}   \t{2}'.format(fault[i], dec2hex_fp(out_Gx[fault[i]]) , sim[fault[i]]))

else:   # ------- Verify Anh dau vao 3D
    for kernel in range(sim_dim[2]):
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
                bin_conv_py = dec2bin(out_Gx[i, j, kernel])

                # hex_conv_sim = sim[i*w2 + j][:-1]    # chu y file out modelsim co ki tu \n nen can loai bo
                dec_conv_sim = sim[i, j, kernel]
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
        #     print('{0}   \t{1}   \t{2}'.format(fault[i], dec2hex_fp(out_Gx[fault[i]]) , sim[fault[i]]))




# # ###########################
# #         VISUALIZE 
# # ###########################

# ############ Anh minh hoa conv MODELSIM ############
sim_copy = sim.copy()
sim_copy[np.where(sim_copy < 0)] = 0

if (len(sim_dim) == 2):
    img_out = cv2.normalize(src=sim_copy, dst=None, alpha=0, beta=255, norm_type=cv2.NORM_MINMAX, dtype=cv2.CV_8U)
    cv2.imshow("SIM conv2d", img_out)    
    cv2.imwrite("SIM_conv2d.jpg", img_out)
else:
    for channel in range(sim_dim[2]):
        img_out = cv2.normalize(src=sim_copy[:, :, channel], dst=None, alpha=0, beta=255, norm_type=cv2.NORM_MINMAX, dtype=cv2.CV_8U)
        cv2.imshow("SIM_conv3d_channel_{0}".format(channel), img_out)    
        cv2.imwrite("../Data/SIM_conv3d_channel_00{0}.jpg".format(channel), img_out)



# ############ Anh minh hoa conv PYTHON ############
out_Gx_copy = out_Gx.copy()
out_Gx_copy[np.where(out_Gx_copy < 0)] = 0

if (len(sim_dim) == 2):
    img_out = cv2.normalize(src=out_Gx_copy, dst=None, alpha=0, beta=255, norm_type=cv2.NORM_MINMAX, dtype=cv2.CV_8U)
    cv2.imshow("PYTHON conv2d", img_out)    
    # cv2.imwrite("PYTHON_conv2d.jpg", img_out)
else:
    for channel in range(sim_dim[2]):
        img_out = cv2.normalize(src=out_Gx_copy[:, :, channel], dst=None, alpha=0, beta=255, norm_type=cv2.NORM_MINMAX, dtype=cv2.CV_8U)
        cv2.imshow("PYTHON_conv3d_channel_{0}".format(channel), img_out)    
        # cv2.imwrite("../Data/PYTHON_conv3d_channel_00{0}.jpg".format(channel), img_out)

cv2.waitKey(0)
cv2.destroyAllWindows()


