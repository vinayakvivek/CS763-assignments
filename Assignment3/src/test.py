import torch
import torchfile
import os
import sys
import numpy as np
from copy import deepcopy

from src.Linear import Linear
from src.ReLU import ReLU
from src.Model import Model


if __name__ == '__main__':


    sample_dir = '/Users/vinayak/pro/acads/SEM8/CS763/Assignment3/info/'

    W = torchfile.load(os.path.join(sample_dir, 'W_sample_1.bin'))
    B = torchfile.load(os.path.join(sample_dir, 'B_sample_1.bin'))
    inp = torchfile.load(os.path.join(sample_dir, 'input_sample_1.bin'))
    inp = inp.reshape(-1, (192))
    gradOutput = torchfile.load(os.path.join(sample_dir, 'gradOutput_sample_1.bin'))

    l1 = Linear(192, 10, W=W[0].T, B=B[0]);

    model = Model(layers=[l1], is_train=True)
    out = model.forward(inp)

    print(out.shape)