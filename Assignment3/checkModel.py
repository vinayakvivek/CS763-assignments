import torch
import os
import sys
import numpy as np
from copy import deepcopy
import argparse

from src.Linear import Linear
from src.ReLU import ReLU
from src.Model import Model
from src.utils import load_file, save_file


LINEAR = "linear"
RELU = "relu"


def create_model(config_file):

    model = Model()

    with open(config_file, 'r') as f:
        num_layers = int(f.readline().strip())
        for i in range(num_layers):
            layer_info = f.readline().strip().split(' ')
            layer_type = layer_info[0]

            if layer_type == LINEAR:
                num_inputs = int(layer_info[1])
                num_outputs = int(layer_info[2])
                model.addLayer(Linear(num_inputs, num_outputs))
            elif layer_type == RELU:
                model.addLayer(ReLU())

        weight_file = f.readline().strip()
        bias_file = f.readline().strip()

        weights = load_file(weight_file)
        biases = load_file(bias_file)

    linear_index = 0
    for layer in model.Layers:
        if isinstance(layer, Linear):
            layer.W = weights[linear_index]
            layer.B = biases[linear_index]
            linear_index += 1

    return model


if __name__ == '__main__':

    parser = argparse.ArgumentParser()
    parser.add_argument("-config", help="path to model config file", required=True)
    parser.add_argument("-i", help="path to input(.bin) file", required=True)
    parser.add_argument("-og", help="path to gradOuput(.bin) file", required=True)
    parser.add_argument("-o", help="path to output(.bin) file", required=True)
    parser.add_argument("-ow", help="path to gradW(.bin) file", required=True)
    parser.add_argument("-ob", help="path to gradB(.bin) file", required=True)
    parser.add_argument("-ig", help="path to gradInput(.bin) file", required=True)

    args = parser.parse_args()

    model = create_model(args.config)
    inp = load_file(args.i)
    num_input_nodes = np.prod(inp.shape[1:])

    inp = inp.reshape(-1, (num_input_nodes))
    out = model.forward(inp)

    model.clearGradParam()

    gradOutput = load_file(args.og)
    model.backward(inp, gradOutput)

    # save output
    save_file(out, args.o)

    # save gradW and gradB
    gradW, gradB = model.getGradParam()
    save_file(gradW, args.ow)
    save_file(gradB, args.ob)

    # save gradInput
    save_file(model.Layers[0].gradInput, args.ig)

    model.save("outputs/model2.bin")
