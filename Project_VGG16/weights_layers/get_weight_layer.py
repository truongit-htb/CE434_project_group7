import h5py
import numpy as np
import struct
from keras.models import load_model

def float_to_bin(value):
	#return struct.unpack('Q', struct.pack('d', value))[0]
  #return np.binary_repr(value)
  return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', value))

# load model
model_done = load_model("model_1.h5")

# print(list(model_done["model_weights"].keys()))

# get filter, bias weights in conv layer
i = 0
for layer in model_done.layers:
    f_b = open('D:/CNN_VGG16/Python/cnn_env/bias/' + layer.name + '_bias.txt', "w")
    if 'conv' not in layer.name:
        continue
    filters, biases = layer.get_weights()
    for bias_weight in biases:
        # f_b.writelines('%s\n' % bias_weight)
        f_b.writelines(float_to_bin(bias_weight)+'\n')
    f_b.close()
    for channel in range(filters.shape[2]):
        for number_filter in range(filters.shape[3]):
            f_f = open('D:/CNN_VGG16/Python/cnn_env/kernel/' + layer.name + '_channel_' + str(channel) + 'filter_' + str(number_filter) + '.txt', 'w')
            for h in range(filters.shape[0]):
                for w in range(filters.shape[1]):
                    # np.savetxt(f_f, filters[h, w, channel, number_filter])
                    # f_f.writelines('%s\n' % filters[h, w, channel, number_filter])
                    f_f.writelines(float_to_bin(filters[h, w, channel, number_filter])+'\n')
            f_f.close()
    i += 1

# get filter, bias weights in dense layer
for layer_dense in model_done.layers:
    if 'dense' not in layer_dense.name:
        continue
    filters, bias = layer_dense.get_weights()
    f_b = open('D:/CNN_VGG16/Python/cnn_env/dense/file_' + layer_dense.name + '_bias.txt', 'w')
    for bias_weight in bias:
        # f_b.writelines('%s\n' % bias_weight)
        f_b.writelines(float_to_bin(bias_weight)+'\n')
    f_b.close()
    f_f = open('D:/CNN_VGG16/Python/cnn_env/dense/file_' + layer_dense.name + '_filter.txt', 'w')
    for h in range (filters.shape[0]):
        for w in range (filters.shape[1]):
            # f_f.writelines('%s\n' % filters[h][w])
            f_f.writelines(float_to_bin(filters[h][w])+'\n')
    f_f.close()

    