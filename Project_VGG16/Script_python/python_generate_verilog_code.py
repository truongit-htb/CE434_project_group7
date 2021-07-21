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
            print("can't save file" + file_name )
            return -1        
    file.close()

def bin2hex(input):
    return hex(int(input, 2))[2:]


def create_top_conv(num_kernel = 8, num_channel = 3):
    accumulate_str = '''\n\tconv3d_{0}_kernel_{1}_channel_size_3 #('''.format(num_kernel, num_channel)
    accumulate_str += '''\n\t\t.DATA_WIDTH(32),.IMG_WIDTH(WIDTH),.IMG_HEIGHT(HEIGHT),'''

    # Edit here
    bias_name = 'block1_conv1_bias.txt'

    with open('../Dataset/0_bias/' + bias_name) as f:
        if f.mode == 'r':
            data_bias = f.readlines()
        else:
            print("can't read file" + bias_name)
    f.close()

    for kernel in range(num_kernel):
        for channel in range(num_channel):      
            # Edit here      
            weight_name = 'block1_conv1_filter_{1}_channel_{0}.txt'.format(channel, kernel)            
            
            with open('../Dataset/1_weight/' + weight_name) as f1:
                if f1.mode == 'r':
                    data_weight = f1.readlines()
                else:
                    print("can't read file" + weight_name )
            f1.close()

            accumulate_str += '''\n\t\t'''
            for weight in range(9):
                accumulate_str += '''.K{0}_C{1}_W{2}(32'h{3}), '''.format(kernel, channel, weight, data_weight[weight][:-1])

        
        if (kernel == num_kernel-1) and (channel == num_channel-1):
            accumulate_str += '''\n\t\t.K{0}_BIAS (32'h{1})\n\t\t)'''.format(kernel,data_bias[kernel][:-1])
        else:
            accumulate_str += '''\n\t\t.K{0}_BIAS (32'h{1}),\n'''.format(kernel,data_bias[kernel][:-1])

    accumulate_str += '''\n\t\tblock{0}_conv{1}('''.format(1, 1)   # Edit here


    accumulate_str += '''\n\t\t.clk(clk),'''
    accumulate_str += '''\n\t\t.resetn(resetn),'''
    accumulate_str += '''\n\t\t.data_valid_in(valid_in),'''

    for c in range(num_channel):
        accumulate_str += '''\n\t\t.data_in{0}(data_in_{0}),'''.format(c)

    for k in range(num_kernel):
        accumulate_str += '''\n\t\t.data_out_conv{0}(conv_out[{0}]),'''.format(k)

    accumulate_str += '''\n\t\t.valid_out_pixel(conv_valid_out),'''
    accumulate_str += '''\n\t\t.done_img()\n\t\t);'''

    return accumulate_str


def create_param(num_kernel = 8, num_channel = 3):
    accumulate_str = ''' '''

    for kernel in range(num_kernel):
        for channel in range(num_channel):   
            accumulate_str += '''\n\tparameter'''        
            for weight in range(9):
                accumulate_str += ''' K{0}_C{1}_W{2} = 32'h0,'''.format(kernel, channel, weight)
        if (kernel == num_kernel-1) and (channel == num_channel-1):
            accumulate_str += '''\n\tparameter K{0}_BIAS  = 32'h0'''.format(kernel)
        else:
            accumulate_str += '''\n\tparameter K{0}_BIAS  = 32'h0,\n'''.format(kernel)
        
    return accumulate_str


def create_port(num_kernel = 8, num_channel = 3):
    accumulate_str = ''''''
    accumulate_str += '''input\tclk,'''
    accumulate_str += '''\n\tinput\tresetn,'''
    accumulate_str += '''\n\tinput\tdata_valid_in,'''

    for c in range(num_channel):
        accumulate_str += '''\n\tinput\t[DATA_WIDTH-1:0]\tdata_in{0},'''.format(c)

    for k in range(num_kernel):
        accumulate_str += '''\n\toutput\t[DATA_WIDTH-1:0]\tdata_out_conv{0},'''.format(k)

    accumulate_str += '''\n\toutput\tvalid_out_pixel,'''
    accumulate_str += '''\n\toutput\tdone_img'''
    return accumulate_str


def create_conv(num_kernel = 8, num_channel = 3):
    accumulate_str = ''''''
    for kernel in range(num_kernel):
        accumulate_str += '''\n\tconv3d_kernel_{0}_channel_size_3 #('''.format(num_channel)
        accumulate_str += '''\n\t\t.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),'''
        # accumulate_str += '''\n\t.DATA_WIDTH(32),.IMG_WIDTH(IMG_WIDTH),.IMG_HEIGHT(IMG_HEIGHT),'''

        for channel in range(num_channel):   
            # accumulate_str += '''\n\tparameter'''        
            for weight in range(9):
                accumulate_str += '''\n\t\t.C{1}_W{2}(K{0}_C{1}_W{2}),'''.format(kernel, channel, weight)

        accumulate_str += '''\n\t\t.BIAS(K{0}_BIAS)\n\t\t)'''.format(kernel)
        accumulate_str += '''\n\t\tconv_{0}('''.format(kernel)
        
        accumulate_str += '''\n\t\t.clk(clk),'''
        accumulate_str += '''\n\t\t.resetn(resetn),'''
        accumulate_str += '''\n\t\t.data_valid_in(data_valid_in),'''
        
        for k in range(num_channel):
            accumulate_str += '''\n\t\t.data_in{0}(data_in{0}),'''.format(k)

        accumulate_str += '''\n\t\t.data_out(data_out_conv{0}),'''.format(kernel)
        accumulate_str += '''\n\t\t.valid_out_pixel(valid_out_conv[{0}]),'''.format(kernel)
        accumulate_str += '''\n\t\t.done(done_conv[{0}])\n\t\t);'''.format(kernel)
    
    accumulate_str += '''\n\n\tassign valid_out_pixel = valid_out_conv[{0}];'''.format(kernel)
    accumulate_str += '''\n\n\tassign done_img = done_conv[{0}];'''.format(kernel)
    
    return accumulate_str


def build_report():
    num_kernel = 8      # Edit here
    num_channel = 3     # Edit here

    # file_name = 'template_conv3d_N_kernel_M_channel.v'
    # file_template = get_template_sample('../Data/6_template/' + file_name)
    # jinja2_template = Template(file_template)
    

    # file_name = 'conv3d_{0}_kernel_{1}_channel_size_3.v'.format(num_kernel, num_channel)
    # out_template = '../Data/6_template/' + file_name

    # content = jinja2_template.render(n_kernel = num_kernel, n_channel = num_channel, param_weight_bias = create_param(num_kernel, num_channel), 
    #                                     port = create_port(num_kernel, num_channel), conv = create_conv(num_kernel, num_channel))

    file_name = 'template_top_module.v'
    file_template = get_template_sample('../Data/6_template/' + file_name)
    jinja2_template = Template(file_template)
    

    file_name = 'block1_conv1_to_maxpool.v'
    out_template = '../Data/6_template/' + file_name

    content = jinja2_template.render(module_name = file_name[:-2], top_conv = create_top_conv(num_kernel, num_channel))


    save_report(content, out_template)
    print("{0} has created!".format(out_template))

if __name__ == "__main__":
    build_report();

