import torch
import torchfile
import os
import sys
import numpy as np
from copy import deepcopy

from Linear import Linear
from ReLU import ReLU


class Model():

    def __init__(self, layers=[], is_train=True):
        self.Layers = layers
        self.isTrain = is_train

    def forward(self, input):
        """
        Args:
            input (tensor): of size [batch_size x num_inputs of first layer]
        Returns:
            output (tensor): of size [batch_size x num_outputs of last layer]
        """
        x = input
        for index, layer in enumerate(self.Layers):
            x = layer.forward(x)
        return x

    def backward(self, input, gradOutput):
        """
        Compute the gradient of the Loss with respect to the parameters
        of the different Layers contained in the model

        Args:
            input
        """
        pass

    def dispGradParam(self):
        """
        Sequentially print the parameters of the network with the Layer
        closer to output displayed first.

        The output format is a 2D matrix for each Layer with space separated elements.
        """
        pass

    def clearGradParam(self):
        """
        Makes the gradients of the parameters to 0 for every Layer and
        is required before back-propagation of every batch.
        """
        pass

    def addLayer(self, layer):
        """
        Used to add an object of type Layer to the self.layers.
        """
        self.Layers.append(layer)
