import torch
import numpy as np
from Layer import Layer


class ReLU(Layer):

    def __init__(self):
        super(ReLU, self).__init__(has_params=False)

    def forward(self, input):
        """
        Args:
            input (tensor): of size [batch_size x ...]
        Returns:
            output (tensor): same size as that of input
        """
        self.output = np.maximum(input, 0);
        return self.output

    def backward(self, input, gradOutput):
        """
        Compute gradient of loss w.r.t. ReLU input
        """
        assert input.shape == gradOutput.shape  # just a safety check
        self.gradInput = gradOutput * (input > 0)
        return self.gradInput

    def as_dict(self):
        return {
            "type": "ReLU"
        }


if __name__ == '__main__':

    r = ReLU();
    inp = np.random.rand(10, 3);
    out = r.forward(inp)
    # print(out)

    gradInput = r.backward(inp, np.random.rand(10, 3));
    print(gradInput)
