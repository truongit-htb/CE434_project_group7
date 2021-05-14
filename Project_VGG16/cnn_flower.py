# -*- coding: utf-8 -*-
"""CNN_Flower.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1CLxwWBuGWYcVOwPES06AALfXIpkkhY6I
"""

from google.colab import files
files.upload()

!mkdir -p ~/.kaggle
!cp kaggle.json ~/.kaggle/

!chmod 600 ~/.kaggle/kaggle.json
!kaggle datasets download -d alxmamaev/flowers-recognition

from zipfile import  ZipFile
file_name = "flowers-recognition.zip"
with ZipFile(file_name, 'r') as zip:
  zip.extractall()
  print('Done')

# Commented out IPython magic to ensure Python compatibility.
##Import Libraries
import warnings
warnings.filterwarnings('ignore')

import cv2       # open CV
import os

# Data manipulation & visulation
import numpy as np
import pandas as pd
# %matplotlib inline
import matplotlib.pyplot as plt
import seaborn as sns

# data augmentation
from keras.preprocessing.image import ImageDataGenerator

from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, accuracy_score, recall_score, classification_report
from sklearn.preprocessing import LabelEncoder

from keras.layers import Dense
from keras.layers import Flatten, Activation
from keras.layers import Conv2D, MaxPooling2D
from keras.optimizers import Adam, RMSprop, SGD
from keras.utils import to_categorical    # one hot encoding
from keras.models import Sequential
from keras.applications import VGG16
from keras.callbacks import ReduceLROnPlateau


import random as rn
from tqdm import tqdm

print(os.listdir('/content/flowers/flowers'))

Daisy_flower_dir = '/content/flowers/flowers/daisy'
Sunflower_flower_dir = '/content/flowers/flowers/sunflower'
# Tulip_flower_dir = '/content/flowers/flowers/tulip'
# Dandelion_flower_dir = '/content/flowers/flowers/dandelion'
# Rose_flower_dir = '/content/flowers/flowers/rose'

images = []
labels = []
img_size = 56

def image_data(flower_name, DIR):
    for i in tqdm(os.listdir(DIR)):
        try:
            
            path = os.path.join(DIR,i)
            img = cv2.imread(path)
            img = cv2.resize(img, (img_size, img_size))
            img = cv2.cvtColor(img,cv2.COLOR_BGR2RGB)
        
            images.append(np.array(img))
            labels.append(str(flower_name))
            
        except:
            print(path)

image_data('Daisy', Daisy_flower_dir)
len(images)

image_data('Sunflower', Sunflower_flower_dir)
len(images)

# image_data('Tulip', Tulip_flower_dir)
# len(images)

# image_data('Dandelion', Dandelion_flower_dir)
# len(images)

# image_data('Rose', Rose_flower_dir)
# len(images)

data = np.array(images)
labels = np.array(labels)
print('Input(Feature) Data shape :', data.shape)
print('Output(Labels) Data shape :', labels.shape)

"""Visualizing random Images"""

fig, ax = plt.subplots(4, 2, figsize = (15, 20))
for i in range(4):
    for j in range(2):
        l = rn.randint(0, data.shape[0])
        ax[i,j].imshow(data[l])
        ax[i,j].set_title(labels[l])
        ax[i,j].axis('off')

"""Count plot for each class"""

sns.countplot(labels)
plt.title("Class Distribution")
plt.xlabel("Class Number")

"""One Hot Encoding of labels"""

le = LabelEncoder()
y = le.fit_transform(labels)
y = to_categorical(y, 2)
y

# Normalize the input data in range [0 1]
X = data/255

"""Spliting data in to training and test set"""

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 5)
print("X_train shape :",X_train.shape)
print("y_train shape :",y_train.shape)
print("X_test shape :" ,X_test.shape)
print("y_test shape :",y_test.shape)

"""Set Random Seed"""

np.random.seed(40)
rn.seed(40)

"""Preparing Base model"""

Base_model = VGG16(include_top= False, weights='imagenet',input_shape=(56,56,3), pooling='max')
Base_model.summary()

"""Add own fully connected Layers"""

model = Sequential()

model.add(Base_model)
model.add(Dense(256,activation='relu'))
# adding prediction(softmax) layer
model.add(Dense(2,activation="softmax"))

# freeze layers(Base Model)
Base_model.trainable = False

"""Annealer"""

# Set a learning rate annealer

red_lr=ReduceLROnPlateau(monitor='val_acc', factor=0.1, min_delta=0.0001, patience=2, verbose=1)

"""Data augmentation to prevent Overfitting"""

datagen = ImageDataGenerator(featurewise_center= False,
                              samplewise_center= False,
                              featurewise_std_normalization= False,
                              samplewise_std_normalization=False,
                              rotation_range= 10,        # 0- 180
                              zca_whitening=False,
                              zoom_range=0.1,            # Randomly zoom image
                              width_shift_range=0.2,     # randomly shift images horizontally (fraction of total width)
                              height_shift_range=0.2,    # randomly shift images vertically (fraction of total height)
                              horizontal_flip=True,      # randomly flip images
                              vertical_flip=False)       # randomly flip images
                             
datagen.fit(X_train)

model.summary()

"""Compile and train the model"""

model.compile(optimizer=Adam(lr = 1e-4), loss= 'categorical_crossentropy', metrics=['accuracy'])

batch_size=64
History = model.fit_generator(datagen.flow(X_train,y_train, batch_size=batch_size),
                              epochs = 20, validation_data = (X_test,y_test),
                              verbose = 1, steps_per_epoch=X_train.shape[0] // batch_size)

model.save("model.h5")

"""Model Accuracy"""

plt.plot(History.epoch, History.history['accuracy'])
plt.plot(History.epoch, History.history['val_accuracy'])
plt.title('Model Accuracy')
plt.legend(['train', 'test'])
plt.xlabel('No. of Epochs')
plt.ylabel('Accuracy')

"""Model Loss"""

plt.plot(History.epoch, History.history['loss'])
plt.plot(History.epoch, History.history['val_loss'])
plt.title('Model Loss')
plt.legend(['train', 'test'])
plt.xlabel('No. of Epochs')
plt.ylabel('Loss')

"""Test model"""

import numpy as np

from keras.preprocessing import image
test_image = image.load_img('/content/flowers/sunflower/10386503264_e05387e1f7_m.jpg', target_size = (56, 56))
test_image = image.img_to_array(test_image)
test_image = np.expand_dims(test_image, axis = 0)
result = model.predict(test_image)
cv2.imshow('réult', test_image)
if result[0][0] == 1:
  prediction = 'daisy'
else:
  prediction = 'sunflower'
print(prediction)