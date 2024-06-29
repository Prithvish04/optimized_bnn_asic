#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon May 31 00:07:30 2021

@author: n7
"""

from copy import deepcopy as dc
import h5py
from matplotlib import pyplot as plt
import network as net
import numpy as np
import random
from tensorflow.keras.datasets import mnist
from tensorflow.keras.utils import to_categorical
from tensorflow.keras import backend as K
import time

EPOCHS = 100
BATCH_SZ = 32
KERNEL_SZ = 9
WEIGHTS_FILE_NAME = "weights.h5"

img_id = None
# img_id = 1608

if __name__ == '__main__':
    # Load values and labels for training and testing data
    (trainX, trainY), (testX, testY) = mnist.load_data()

    trainX = trainX.reshape((trainX.shape[0], 28, 28, 1))
    testX = testX.reshape((testX.shape[0], 28, 28, 1))

    if img_id is None:
        img_id = random.randint(0, 9999)

    trainX = trainX.astype('float32')
    testX = testX.astype('int')

    # [0 to 255] -> [- to 1]
    trainX = trainX / 127.5 - 1

    # Binarize Test Set
    testX[testX < 127] = -1
    testX[testX >= 127] = 1

    model = net.create_network_3(KERNEL_SZ)

    # ws = None
    # acc = 0

    # accs_bnn = np.zeros(EPOCHS)

    # for i in range(EPOCHS):
    #     model.fit(trainX, trainY, epochs=1, batch_size=BATCH_SZ)
    #     test_loss, test_acc = model.evaluate(testX, testY)
    #     accs_bnn[i] = test_acc

    #     if (test_acc > acc):
    #         acc = test_acc
    #         ws = model.get_weights()

    # model = net.create_network_4(KERNEL_SZ)

    # ws = None
    # acc = 0

    # accs_dnn = np.zeros(EPOCHS)

    # for i in range(EPOCHS):
    #     model.fit(trainX, trainY, epochs=1, batch_size=BATCH_SZ)
    #     test_loss, test_acc = model.evaluate(testX, testY)
    #     accs_dnn[i] = test_acc

    #     if (test_acc > acc):
    #         acc = test_acc
    #         ws = model.get_weights()

    # for w in ws:
    #     w[w < 0] = -1
    #     w[w >= 0] = 1

    # end_ts = time.time()
    # print("Training Time: " + str(end_ts - start_ts))

    # np.save("w_conv_" + str(KERNEL_SZ) + ".npy", ws[0].astype("int"))
    # np.save("w_full_" + str(KERNEL_SZ) + ".npy", ws[1].astype("int"))

    ws = [np.load("w_conv_" + str(KERNEL_SZ) + ".npy").astype("int"),
          np.load("w_full_" + str(KERNEL_SZ) + ".npy").astype("int")]

    model.set_weights(ws)
    model.evaluate(trainX, trainY)
    model.evaluate(testX, testY)
    img = testX[img_id, :, :, 0]

    preds = model.predict(testX).argmax(axis=1)
    pred = preds[img_id]
    wrong_ids = np.where(testY != preds)[0]

    # end_ts = time.time()
    # print("Training Time: " + str(end_ts - start_ts))

    inp = model.input
    outputs = [layer.output for layer in model.layers]
    functors = [K.function([inp], [out]) for out in outputs]
    layer_outs = [func([testX])[0] for func in functors]
    outs_bin = []
    for layer_out in layer_outs[:-1]:
        outs_bin += [dc(layer_out)]
        outs_bin[-1][outs_bin[-1] >= 0] = 1
        outs_bin[-1][outs_bin[-1] < 0] = 0

    maxpool_out = outs_bin[1][img_id]
    flat_out = outs_bin[2][img_id]
    full_out = layer_outs[3][img_id, :]

    # fig, ax = plt.subplots(1, 1)

    # ax.plot(accs_bnn, label="BNN")
    # ax.set_xlabel("# Epochs", fontsize=12)
    # ax.set_ylabel("Accuracy (%)", fontsize=12)
    # ax.set_ylim(50, 100)
    # plt.subplots_adjust(left=0.12, bottom=0.12, right=0.95, top=0.95)
