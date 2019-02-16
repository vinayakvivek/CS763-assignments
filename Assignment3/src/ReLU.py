import torch
import numpy as np


class ReLU():

    def __init__(self):
        pass

    def forward(self, input):
        """
        Args:
            input (tensor): of size [batch_size x ...]
        Returns:
            output (tensor): same size as that of input
        """
        self.output = np.maximum(input, 0);
        return self.output

    def backward(self, input, grad_output):
        """
        Compute gradient of loss w.r.t. ReLU input
        """
        assert input.shape == grad_output.shape. # just a safety check
        self.grad_input = grad_output * (input > 0)
        return self.grad_input


if __name__ == '__main__':
    
    r = ReLU();
    inp = np.random.rand(10, 3);
    out = r.forward(inp)
    # print(out)

    grad_input = r.backward(inp, np.random.rand(10, 3));
    print(grad_input)
