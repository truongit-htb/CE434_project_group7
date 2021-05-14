import h5py
import numpy as np

weights_path = 'model.h5' 
f = h5py.File(weights_path)

print(list(f["model_weights"].keys()))
print(list(f["model_weights"]["dense_4"]))
print(list(f["model_weights"]["dense_5"]))
print(list(f["model_weights"]["vgg16"]))

list_blocks = ['block1_conv1', 'block1_conv2', 'block2_conv1', 'block2_conv2', 'block3_conv1', 'block3_conv2', 
'block3_conv3', 'block4_conv1', 'block4_conv2', 'block4_conv3', 'block5_conv1', 'block5_conv2', 'block5_conv3']
def write_weights(file_b,file_k, file_in, block):
    for listweights in (file_in["model_weights"]["vgg16"][block]["bias:0"]):
        file_b.writelines('%s\n' % listweights)
    for listweights in (file_in["model_weights"]["vgg16"][block]["kernel:0"]):
        for i in range(3):
            if(i==0):
                file_k.write("Channel B\n")
                np.savetxt(file_k, listweights[i])
            if(i==1):
                file_k.write("Channel G\n")
                np.savetxt(file_k, listweights[i])
            if(i==2):
                file_k.write("Channel R\n")
                np.savetxt(file_k, listweights[i])
    return file_b, file_k
# Lấy trọng số lớp block1_conv1
f1_b = open('block1_conv1_bias.txt', 'w')
f1_k = open('block1_conv1_kernel.txt', 'w')
write_weights(f1_b, f1_k, f,list_blocks[0])
f1_b.close()
f1_k.close()

# Lấy trọng số lớp block1_conv2
f2_b = open('block1_conv2_bias.txt', 'w')
f2_k = open('block1_conv2_kernel.txt', 'w')
write_weights(f2_b, f2_k, f, list_blocks[1])
f2_b.close()
f2_k.close()

# Lấy trọng số lớp block2_conv1
f3_b = open('block2_conv1_bias.txt', 'w')
f3_k = open('block2_conv1_kernel.txt', 'w')
write_weights(f3_b, f3_k, f, list_blocks[2])
f3_b.close()
f3_k.close()

# Lấy trọng số lớp block2_conv2
f4_b = open('block2_conv2_bias.txt', 'w')
f4_k = open('block2_conv2_kernel.txt', 'w')
write_weights(f4_b, f4_k, f, list_blocks[3]) 
f4_b.close()
f4_k.close()

# Lấy trọng số lớp block3_conv1
f5_b = open('block3_conv1_bias.txt', 'w')
f5_k = open('block3_conv1_kernel.txt', 'w')
write_weights(f5_b, f5_k, f, list_blocks[4])
f5_b.close()
f5_k.close()

# Lấy trọng số lớp block3_conv2
f6_b = open('block3_conv2_bias.txt', 'w')
f6_k = open('block3_conv2_kernel.txt', 'w')
write_weights(f6_b, f6_k, f, list_blocks[5])
f6_b.close()
f6_k.close()

# Lấy trọng số lớp block3_conv3
f7_b = open('block3_conv3_bias.txt', 'w')
f7_k = open('block3_conv3_kernel.txt', 'w')
write_weights(f7_b, f7_k, f, list_blocks[6]) 
f7_b.close()
f7_k.close()

# Lấy trọng số lớp block4_conv1
f8_b = open('block4_conv1_bias.txt', 'w')
f8_k = open('block4_conv1_kernel.txt', 'w')
write_weights(f8_b, f8_k, f, list_blocks[7])
f8_b.close()
f8_k.close()

# Lấy trọng số lớp block4_conv2
f9_b = open('block4_conv2_bias.txt', 'w')
f9_k = open('block4_conv2_kernel.txt', 'w')
write_weights(f9_b, f9_k, f, list_blocks[8])   
f9_b.close()
f9_k.close()

# Lấy trọng số lớp block4_conv3
f10_b = open('block4_conv3_bias.txt', 'w')
f10_k = open('block4_conv3_kernel.txt', 'w')
write_weights(f10_b, f10_k, f, list_blocks[9])   
f10_b.close()
f10_k.close()

# Lấy trọng số lớp block5_conv1
f11_b = open('block5_conv1_bias.txt', 'w')
f11_k = open('block5_conv1_kernel.txt', 'w')
write_weights(f11_b, f11_k, f, list_blocks[10])  
f11_b.close()
f11_k.close()

# Lấy trọng số lớp block5_conv2
f12_b = open('block5_conv2_bias.txt', 'w')
f12_k = open('block5_conv2_kernel.txt', 'w')
write_weights(f12_b, f12_k, f, list_blocks[11])   
f12_b.close()
f12_k.close()


# Lấy trọng số lớp block5_conv3
f13_b = open('block5_conv3_bias.txt', 'w')
f13_k = open('block5_conv3_kernel.txt', 'w')
write_weights(f13_b, f13_k, f, list_blocks[12])   
f13_b.close()
f13_k.close()
