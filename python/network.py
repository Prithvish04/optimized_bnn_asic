#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun May 30 20:50:49 2021

@author: n7
"""

from larq.layers import QuantConv2D
from larq.layers import QuantDense
from larq.models import summary
import numpy as np
from tensorflow import convert_to_tensor
from tensorflow.compat.v1 import Session
from tensorflow.keras.constraints import Constraint
from tensorflow.keras.constraints import MinMaxNorm
from tensorflow.keras.datasets import mnist
from tensorflow.keras.layers import Activation
from tensorflow.keras.layers import Conv2D
from tensorflow.keras.layers import MaxPooling2D
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers import Flatten
from tensorflow.keras.models import Sequential
from tensorflow.keras.optimizers import SGD
from tensorflow.keras.utils import to_categorical
from tensorflow.math import greater_equal
from tensorflow.math import greater
from tensorflow.math import sign
from tensorflow import cast
from tensorflow import int32
from tensorflow import float32


class BinaryWeights(Constraint):
    def __init__(self):
        pass

    def __call__(self, w):
        # sess = Session()
        # with sess.as_default():
        #     val = greater_equal(w.read_value(), 0.5).eval().astype("int")
        # w.assign(convert_to_tensor(val))
        return w

    def get_config(self):
        return {}


bias_constraint = MinMaxNorm(min_value=0.0, max_value=0.0)
weight_constraint = BinaryWeights()


def custom_activation(x):
    return cast(greater(x, 0), int32)


def bin_activation(x):
    return sign(x)


def create_network_1():
    """
    ACS Lab 3

    Returns
    -------
    model : keras.models.Sequentials
        Model containing the neural network layers.

    """
    model = Sequential()
    model.add(Conv2D(8, (5, 5),
                     activation=Activation(custom_activation),
                     bias_constraint=bias_constraint,
                     kernel_initializer="he_uniform", input_shape=(28, 28, 1)))
    model.add(MaxPooling2D((2, 2)))
    model.add(Flatten())

    # Activation not required for testing
    model.add(Dense(10,
                    bias_constraint=bias_constraint))
    opt = SGD(lr=0.01, momentum=0.9)
    model.compile(optimizer=opt, loss="categorical_crossentropy",
                  metrics=["accuracy"])
    return model


def create_network_2():
    """
    Example from https://machinelearningmastery.com/how-to-develop-a-convolutional-neural-network-from-scratch-for-mnist-handwritten-digit-classification/

    Returns
    -------
    model : keras.models.Sequentials
        Model containing the neural network layers.

    """
    model = Sequential()
    model.add(Conv2D(32, (3, 3), activation="relu",
                     kernel_initializer="he_uniform", input_shape=(28, 28, 1)))
    model.add(MaxPooling2D((2, 2)))
    model.add(Flatten())
    model.add(Dense(100, activation="relu", kernel_initializer="he_uniform"))
    model.add(Dense(10, activation="softmax"))
    opt = SGD(lr=0.01, momentum=0.9)
    model.compile(optimizer=opt, loss="categorical_crossentropy",
                  metrics=["accuracy"])
    return model


def create_network_3(kernel_sz=9):
    """
    Reduced version of from https://colab.research.google.com/github/larq/docs/blob/master/docs/larq/tutorials/mnist.ipynb

    Returns
    -------
    model : keras.models.Sequentials
        Model containing the neural network layers.

    """
    kwargs = dict(input_quantizer="ste_sign",
                  kernel_quantizer="ste_sign",
                  kernel_constraint="weight_clip")

    model = Sequential()
    model.add(QuantConv2D(8, (kernel_sz, kernel_sz),
                          kernel_quantizer="ste_sign",
                          kernel_constraint="weight_clip",
                          input_quantizer="ste_sign",
                          use_bias=False,
                          input_shape=(28, 28, 1)))
    model.add(MaxPooling2D((2, 2)))
    model.add(Flatten())
    model.add(QuantDense(10, use_bias=False, **kwargs))
    # model.add(Activation("softmax"))
    # summary(model)
    model.compile(optimizer='adam',
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])
    return model


def create_network_4(kernel_sz=9):
    """
    Reduced version of from https://colab.research.google.com/github/larq/docs/blob/master/docs/larq/tutorials/mnist.ipynb

    Returns
    -------
    model : keras.models.Sequentials
        Model containing the neural network layers.

    """

    model = Sequential()
    model.add(Conv2D(8, (kernel_sz, kernel_sz), use_bias=False,
                     input_shape=(28, 28, 1)))
    model.add(MaxPooling2D((2, 2)))
    model.add(Flatten())
    model.add(Dense(10, use_bias=False))
    model.add(Activation("relu"))
    model.compile(optimizer='adam',
                  loss='sparse_categorical_crossentropy',
                  metrics=['accuracy'])
    return model
