from jinja2 import Template

def get_template_sample(file_name):
    with open(file_name, 'r', encoding='UTF-8') as file:
        if file.mode == 'r':
            data = file.read()
        else:
            print("can't read file" + file_name )
            return -1       
    file.close()
    return data

def save_report(content, file_name):
    with open(file_name, 'w', encoding='UTF-8') as file:
        if file.mode == 'w':
            file.write(content)
        else:
            print("can't read file" + file_name )
            return -1        
    file.close()

def bin2hex(input):
    return hex(int(input, 2))[2:]

def create_param():
    accumulate_str = '''\n'''

    for kernel in range(8):
        bias_name = 'block1_conv1_3chanel_8filter_bias.txt'
        with open('/home/truong/Desktop/VGG16_weight/block1_conv1/bias/' + bias_name) as f:
            if f.mode == 'r':
                data_bias = f.readlines()
            else:
                print("can't read file" + weight_name )
        f.close()
              
        for channel in range(3):            
            weight_name = 'block1_conv1_3chanel_8filter_channel_{0}filter_{1}.txt'.format(channel, kernel)            
            with open('/home/truong/Desktop/VGG16_weight/block1_conv1/weight/' + weight_name) as f1:
                if f1.mode == 'r':
                    data_weight = f1.readlines()
                else:
                    print("can't read file" + weight_name )
            f1.close()
            for i in range(len(data_weight)):
                accumulate_str += '''\tparameter K{0}_C{1}_W{2} = 32'h{3},\n'''.format(kernel, channel, i, bin2hex(data_weight[i]))
        if (kernel == 7 and channel == 2):
            accumulate_str += '''\tparameter K{0}_BIAS  = 32'h{1}'''.format(kernel, bin2hex(data_bias[kernel]))
        else:
            accumulate_str += '''\tparameter K{0}_BIAS  = 32'h{1},\n\n'''.format(kernel, bin2hex(data_bias[kernel]))
        
    return accumulate_str

def build_report():
    file_template = get_template_sample('/home/truong/Desktop/git_vgg16/VGG16/template_block1_conv1_8kernel_3channel.v')
    jinja2_template = Template(file_template)
    
    out_template = '/home/truong/Desktop/git_vgg16/VGG16/CodePythonCNN/block1_conv1_8kernel_3channel.v'
    content = jinja2_template.render(weight_bias = create_param())

    save_report(content, out_template)
    print("{0} has created!".format(out_template))

if __name__ == "__main__":
    build_report();

