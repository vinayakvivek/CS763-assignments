import torch
import numpy as np


class Linear():

    """
    Implements a Linear layer of neural network
    f(x) = <W*x> + b

    state variables:
     - `output`: matrix of size [batch_size x num_output]
     - `W`: weight matrix of size [num_output x num_input]
     - `B`: bias matrix of size [num_output x 1]
     - `gradW`: weight gradients, same size as W
     - `gradB`: bias gradients, same size as B
     - `grad_input`: same size as input
    """

    def __init__(self, num_input, num_output):

        # Xavier’s initialization
        self.W = np.random.normal(loc=0.0, 
                                  scale = np.sqrt(2 / (num_input + num_output)), 
                                  size = (num_input, num_output))
        self.B = np.zeros(num_output)

    def forward(self, input):
        """
        Args:
            input (tensor): of size [batch_size x num_inputs]
        Returns:
            output (tensor): of size [batch_size x num_outputs]
        """
        self.output = np.dot(input, self.W) + self.B
        return self.output

    def backward(self, input, grad_output):
        """
        Args:
            input (tensor): of size [batch_size x num_inputs]
            grad_output (tensor): of size [batch_size x num_outputs]
        Returns:
            grad_input (tensor): of size [batch_size x num_input]
        """
        self.grad_input = np.dot(grad_output, self.W.T)

        self.gradW = np.dot(input.T, grad_output)
        self.gradB = grad_output.sum(axis=0)

        return self.grad_input


if __name__ == '__main__':
    
    l = Linear(3, 4);
    # print(l.W)
    # print(l.B)
    inp = np.random.rand(10, 3);
    out = l.forward(inp)
    # print(out)

    grad_input = l.backward(inp, np.random.rand(10, 4));
