import torch
import torchfile
import os
import sys
import numpy as np
from copy import deepcopy

from src.Linear import Linear
from src.ReLU import ReLU
from src.utils import save_file, load_file


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
        num_layers = len(self.Layers)
        grad_out = deepcopy(gradOutput)

        curr_layer_index = num_layers - 1
        while curr_layer_index > 0:
            curr_inp = self.Layers[curr_layer_index - 1].output
            grad_out = self.Layers[curr_layer_index].backward(curr_inp, grad_out)
            curr_layer_index -= 1

        self.Layers[0].backward(input, grad_out)

    def dispGradParam(self):
        """
        Sequentially print the parameters of the network with the Layer
        closer to output displayed first.

        The output format is a 2D matrix for each Layer with space separated elements.
        """
        for layer in reversed(self.Layers):
            if layer.has_params:
                print(layer.gradW.tolist())
                print(layer.gradB.tolist())

    def clearGradParam(self):
        """
        Makes the gradients of the parameters to 0 for every Layer and
        is required before back-propagation of every batch.
        """
        for layer in self.Layers:
            if layer.has_params:
                layer.gradW = np.zeros_like(layer.W)
                layer.gradB = np.zeros_like(layer.B)

    def getGradParam(self):
        """
        return list of gradW and gradB
        """
        gradW_list = []
        gradB_list = []

        for layer in self.Layers:
            if layer.has_params:
                gradW_list.append(layer.gradW)
                gradB_list.append(layer.gradB)

        return (gradW_list, gradB_list)

    def addLayer(self, layer):
        """
        Used to add an object of type Layer to the self.layers.
        """
        self.Layers.append(layer)

    def save(self, file_path):
        model_data = [x.as_dict() for x in self.Layers]
        save_file(model_data, file_path)

    def load(self, file_path):
        model_data = load_file(file_path)
        for x in model_data:
            if x["type"] == "Linear":
                self.addLayer(Linear(x["num_inputs"], x["num_outputs"], x["W"], x["B"]))
            elif x["type"] == "ReLU":
                self.addLayer(ReLU())
