#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jun  6 11:34:33 2021

@author: n7
"""

import numpy as np
import os
import random
from tensorflow.keras.datasets import mnist

KERNEL_SZ = 9

_SCRIPT_DIR = os.path.dirname(os.path.realpath(__file__))

px_template = ("\tpx_%d: \treg_8bit port map (CLK => CLK, rst => '0', "
               "input => '%d', output => elem_px(%d));\n")

img_row_template = ("\timg_row_%d: \treg_8bit port map (CLK => CLK, "
                    "rst => '0', input => \"%s\", "
                    "output => elem_img_row(%d));\n")

w_conv_template = ("\tw_conv_%d: \treg_8bit port map (CLK => CLK, rst => '0', "
                   "input => '%d', output => elem_w_conv(%d));\n")

w_full_template = ("\tw_full_%d: \treg_8bit port map (CLK => CLK, rst => '0', "
                   "input => '%d', output => elem_w_full(%d));\n")

conv_row_template = ("\tconv_row_%d: \treg_8bit port map (CLK => CLK, "
                     "rst => '0', input => \"%s\", "
                     "output => elem_conv_row(%d));\n")

test_bench_template = ("\"%s\" &\n")

# img_id = None
img_id = 1608

if __name__ == '__main__':
    (trainX, trainY), (testX, testY) = mnist.load_data()
    if img_id is None:
        img_id = random.randint(0, 9999)

    # print("Image ID: " + str(img_id))

    # img = testX[img_id].astype("int")

    # # Binarize Test Set
    # img[img < 127] = -1
    # img[img >= 127] = 1
    # nrows = img.shape[0]
    # ncols = img.shape[1]

    # img_row_str = ""
    # for i in range(0, img.shape[0]):
    #     px_str = ""
    #     for j in range(0, img.shape[1]):
    #         px_str += str(int(img[i, j] > 0))
    #     # img_row_str += img_row_template % (i, px_str, i)
    #     img_row_str += test_bench_template % (px_str, )

    # # with open(os.path.join(_SCRIPT_DIR, "img_row_reg.vhd"), "w") as f:
    # #     f.write(img_row_str)

    # with open(os.path.join(_SCRIPT_DIR, "img_row_test.vhd"), "w") as f:
    #     f.write(img_row_str)

    # conv_row_str = ""
    # ws_conv = np.load(os.path.join(_SCRIPT_DIR,
    #                                "w_conv_" + str(KERNEL_SZ) +
    #                                ".npy")).astype("int")

    # for i in range(0, ws_conv.shape[3]):
    #     for j in range(0, ws_conv.shape[0]):
    #         ws_str = ""
    #         cnt = (ws_conv.shape[0]*i) + j
    #         for k in range(0, ws_conv.shape[1]):
    #             ws_str += str(int(ws_conv[j, k, 0, i] > 0))
    #         # conv_row_str += conv_row_template % (cnt, ws_str, cnt)
    #         conv_row_str += test_bench_template % (ws_str)
    #     conv_row_str += "\n"

    full_row_str = ""
    ws_full = np.load(os.path.join(_SCRIPT_DIR,
                                   "w_full_" + str(KERNEL_SZ) +
                                   ".npy")).astype("int")

    for a in range(0, ws_full.shape[1]):
        for k in range(0, 8):
            ws_str = ""
            for i in range(0, 10):
                for j in range(0, 10):
                    index = (80*i) + (8*j) + k
                    ws_str += str(int(ws_full[index, a] > 0))
            full_row_str += test_bench_template % (ws_str)
        full_row_str += "\n"

    with open(os.path.join(_SCRIPT_DIR, "w_full_reg.vhd"), "w") as f:
        f.write(full_row_str)

    # with open(os.path.join(_SCRIPT_DIR, "conv_row_test.vhd"), "w") as f:
    #     f.write(full_row_str)

    # px_str = ""
    # for i in range(0, img.size):
    #     row = int(i/ncols)
    #     col = i % ncols
    #     px_str += px_template % (i, int(img[row, col] > 0), i)

    # with open(os.path.join(_SCRIPT_DIR, "px_reg.vhd"), "w") as f:
    #     f.write(px_str)

    # w_conv_str = ""
    # ws_conv = np.load(os.path.join(_SCRIPT_DIR,
    #                                "w_conv_" + str(KERNEL_SZ) +
    #                                ".npy")).astype("int")
    # for i in range(0, ws_conv.shape[3]):
    #     for j in range(0, ws_conv.shape[0]):
    #         ws_str = ""
    #         cnt = (ws_conv.shape[0]*i) + j
    #         for k in range(0, ws_conv.shape[1]):
    #             w_conv_str += w_conv_template % (cnt*ws_conv.shape[1] + k,
    #                                              int(ws_conv[j, k, 0, i] > 0),
    #                                              cnt*ws_conv.shape[1] + k)
    #     w_conv_str += "\n"

    # with open(os.path.join(_SCRIPT_DIR, "w_conv_reg.vhd"), "w") as f:
    #     f.write(w_conv_str)

    # w_full_str = ""
    # ws_full = np.load(os.path.join(_SCRIPT_DIR,
    #                                 "w_full_" + str(KERNEL_SZ) +
    #                                 ".npy")).astype("int")
    # ws_full = ws_full.reshape(-1)
    # for i in range(0, ws_full.size):
    #     w_full_str += w_full_template % (i, int(ws_full[i] > 0), i)

    # with open(os.path.join(_SCRIPT_DIR, "w_full_reg.vhd"), "w") as f:
    #     f.write(w_full_str)
