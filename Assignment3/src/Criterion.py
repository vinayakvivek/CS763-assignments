import torch
import torchfile
import numpy as np


class Criterion():

    def __init__(self):
        pass

    def forward(self, input, target):
        """
        computes the average cross-entropy loss over the batch

        Args:
            input (tensor): of size [batch_size x num_classes]
            target (tensor): of size [batch_size x 1]
        Return:
            output (float): average cross-entropy loss
        """
        batch_size = input.shape[0]
        logits = input[tuple([range(batch_size), target[:, 0].astype(np.int) - 1])]
        self.output = np.mean(-logits + np.log(np.sum(np.exp(input), axis=1)))
        return self.output

    def backward(self, input, target):
        """
        computes and returns the gradient of the cross-entropy loss
        with respect to the input.

        Args:
            input (tensor): of size [batch_size x num_classes]
            target (tensor): of size [batch_size x 1]
        Return:
            gradInput (tensor): of size same as input
        """
        batch_size = input.shape[0]
        softmax = np.exp(input) / np.exp(input).sum(axis=-1,keepdims=True)
        indices = tuple([range(batch_size), target[:, 0].astype(np.int) - 1])
        softmax[indices] -= 1
        self.gradInput = softmax / batch_size
        return self.gradInput