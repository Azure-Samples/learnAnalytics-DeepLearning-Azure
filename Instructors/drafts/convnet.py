import os, os.path, sys
import numpy as np
import pandas as pd
from skimage.io import imread 
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, Flatten
from keras.layers import Conv2D, MaxPooling2D
from keras.utils import np_utils
from keras.datasets import mnist

NUM_IMG = 25

class experiment (object):

    def __init__(self, data_path):
        self.data_path = data_path
        X_train, y_train = self.get_training_data(self.data_path, "train-labels.csv")
        X_test, y_test = self.get_training_data(self.data_path, "test-labels.csv")
        self.X_train = X_train
        self.X_test = X_test
        self.y_train = y_train
        self.y_test = y_test

    def get_training_data(self, train_path, labels_path):
        train_images = []
        train_files = []
        for filename in os.listdir(train_path):
            if filename.endswith(".png"):
                train_files.append(train_path + filename)

        features = []

        for i, train_file in enumerate(train_files):
            if i >= NUM_IMG: break
            train_image = imread(train_file, True)
            feature_set = np.asarray(train_image)
            features.append(feature_set)

        labels_df = pd.read_csv(os.path.join(self.data_path, labels_path)) #["Finding Labels"]
        labels_df = labels_df["Finding Labels"]
        labels = np.zeros(NUM_IMG) # 0 for no finding, 1 for finding.

        # loading all labels
        for i in range(NUM_IMG):
            if (labels_df[i] == 'No Finding'):
                labels[i] = 0
            else:
                labels[i] = 1
                images = np.expand_dims(np.array(features), axis=3).astype('float32') / 255 # adding single channel
        return images, labels


    def build_conv(self, dropout_rate=0.18):

        self.model = Sequential()

        self.model.add(Conv2D(4, (3, 3), strides=(2,2), activation='relu', input_shape=(1024, 1024, 1), data_format='channels_last'))
        self.model.add(Conv2D(4, (3, 3), strides=(2,2), activation='relu'))
        self.model.add(MaxPooling2D(pool_size=(2,2)))
        self.model.add(Dropout(dropout_rate))

        # self.model.add(Conv2D(4, (3, 3), strides=(2,2), activation='relu'))
        # self.model.add(Conv2D(4, (3, 3), strides=(2,2), activation='relu'))
        # self.model.add(MaxPooling2D(pool_size=(2,2)))
        # self.model.add(Dropout(dropout_rate))

        self.model.add(Conv2D(4, (3, 3), strides=(2,2), activation='relu'))
        self.model.add(Conv2D(4, (3, 3), strides=(2,2), activation='relu'))
        self.model.add(MaxPooling2D(pool_size=(2,2)))
        self.model.add(Dropout(dropout_rate))

        self.model.add(Conv2D(4, (3, 3), strides=(2,2), activation='relu'))
        self.model.add(Conv2D(4, (3, 3), strides=(2,2), activation='relu'))
        self.model.add(MaxPooling2D(pool_size=(2,2)))
        self.model.add(Dropout(dropout_rate))

        self.model.add(Flatten())
        self.model.add(Dense(1024, activation='relu'))
        self.model.add(Dropout(dropout_rate))
        self.model.add(Dense(1, activation='sigmoid'))

        self.model.compile(loss='binary_crossentropy', optimizer='adam', metrics=['accuracy'])

    def run_model(self, total_epochs):

        last_score = None 
        for k in range(1, total_epochs+1):
            self.model.fit(self.X_train, self.y_train, batch_size=4, epochs=k, initial_epoch=k-1, verbose=2)
            score = self.model.evaluate(self.X_test, self.y_test, verbose=1)
            if last_score:
                if last_score == score:
                    break
            else:
                last_score = score

        print(k, 'k, Score ', self.model.metrics_names, ' , ', score)
        return k, score


