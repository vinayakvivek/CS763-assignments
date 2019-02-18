import torch
import os
import sys
import numpy as np
from copy import deepcopy
import argparse

from Criterion import Criterion
from utils import load_file, save_file


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument("-i", help="path to input(.bin) file", required=True)
    parser.add_argument("-t", help="path to target(.bin) file", required=True)
    parser.add_argument("-ig", help="path to gradInput(.bin) file", required=True)

    args = parser.parse_args()

    inp = load_file(args.i)
    target = load_file(args.t)

    ce_loss = Criterion()
    loss = ce_loss.forward(inp, target)
    print(loss)

    gradInput = ce_loss.backward(inp, target)
    save_file(gradInput, args.ig)
