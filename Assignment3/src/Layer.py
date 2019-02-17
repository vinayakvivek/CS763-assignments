import torch
import numpy as np


class Layer():

    def __init__(self):
        raise NotImplementedError

    def forward(self, input):
        raise NotImplementedError

    def backward(self, input, grad_output):
        raise NotImplementedError