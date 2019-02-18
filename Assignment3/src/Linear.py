import torch
import torchfile
import numpy as np
import os
from Layer import Layer


class Linear(Layer):

    """
    Implements a Linear layer of neural network
    f(x) = <W*x> + b

    state variables:
     - `output`: matrix of size [batch_size x num_outputs]
     - `W`: weight matrix of size [num_outputs x num_inputs]
     - `B`: bias matrix of size [num_outputs x 1]
     - `gradW`: weight gradients, same size as W
     - `gradB`: bias gradients, same size as B
     - `gradInput`: same size as input
    """

    def __init__(self, num_inputs, num_outputs, W=None, B=None):
        super(Linear, self).__init__(has_params=True)
        if W is None and B is None:
            # Xavier’s initialization
            self.W = np.random.normal(loc=0.0,
                                      scale = np.sqrt(2 / (num_inputs + num_outputs)),
                                      size = (num_inputs, num_outputs))
            self.B = np.zeros(num_outputs)
        else:
            assert W.shape == (num_inputs, num_outputs)
            assert B.shape == (num_outputs, )
            self.W = W
            self.B = B

        self.gradW = np.zeros_like(self.W)
        self.gradB = np.zeros_like(self.B)

    def forward(self, input):
        """
        Args:
            input (tensor): of size [batch_size x num_inputs]
        Returns:
            output (tensor): of size [batch_size x num_outputs]
        """
        self.output = np.dot(input, self.W) + self.B
        return self.output

    def backward(self, input, gradOutput):
        """
        Args:
            input (tensor): of size [batch_size x num_inputs]
            gradOutput (tensor): of size [batch_size x num_outputs]
        Returns:
            gradInput (tensor): of size [batch_size x num_inputs]
        """
        self.gradInput = np.dot(gradOutput, self.W.T)

        self.gradW = np.dot(input.T, gradOutput)
        self.gradB = gradOutput.sum(axis=0)

        return self.gradInput


if __name__ == '__main__':

    sample_dir = '/Users/vinayak/pro/acads/SEM8/CS763/Assignment3/info/'

    W = torchfile.load(os.path.join(sample_dir, 'W_sample_1.bin'))
    B = torchfile.load(os.path.join(sample_dir, 'B_sample_1.bin'))
    inp = torchfile.load(os.path.join(sample_dir, 'input_sample_1.bin'))
    inp = inp.reshape(-1, (192))
    gradOutput = torchfile.load(os.path.join(sample_dir, 'gradOutput_sample_1.bin'))

    l = Linear(192, 10, W=W[0].T, B=B[0]);
    # print(l.W)
    # print(l.B)
    # inp = np.random.rand(10, 3);
    out = l.forward(inp)
    # print(out)

    gradInput = l.backward(inp, gradOutput);
    # print(gradInput)
    print(l.gradB)

    gradB = torchfile.load(os.path.join(sample_dir, 'gradB_sample_1.bin'))
    print(gradB[0])

