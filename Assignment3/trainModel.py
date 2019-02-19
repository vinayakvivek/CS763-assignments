import torch
import os
import sys
import numpy as np
from copy import deepcopy
import argparse

from src.Linear import Linear
from src.ReLU import ReLU
from src.Model import Model
from src.Criterion import Criterion
from src.Optimizer import SGDOptimizer
from src.utils import load_file, save_file


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument("-modelName", help="model name", required=True)
    parser.add_argument("-data", help="location of the training data", required=True)
    parser.add_argument("-target", help="location of the target labels", required=True)

    args = parser.parse_args()

    os.makedirs(args.modelName, exist_ok=True)

    data = load_file(args.data)
    target = load_file(args.target)

    print(data.shape, target.shape)
