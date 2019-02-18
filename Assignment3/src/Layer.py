import torch
import numpy as np


class Layer():

    def __init__(self, has_params=False):
        self.has_params = has_params

    def forward(self, input):
        raise NotImplementedError

    def backward(self, input, grad_output):
        raise NotImplementedError