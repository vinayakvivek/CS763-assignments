import torch
import numpy as np


class SGDOptimizer():

    def __init__(self, model, lr, momentum=0.0, decay=None):

        self.model = model

        self.lr0 = lr
        self.lr = lr

        self.momentum = momentum
        self.init_momentum_params()

        self.decay = decay

        self.num_steps = 0

    def decay_lr(self):
        """
        exponential decay of learning rate
        """
        if self.decay is not None:
            self.lr = self.lr0 * np.exp(self.dacay * self.num_steps)

    def init_momentum_params(self):
        """
        initialize zero values for retained grads
        """
        self.vW = []
        self.vB = []
        for layer in self.model.Layers:
            if layer.has_params:
                self.vW.append(np.zeros_like(layer.W))
                self.vB.append(np.zeros_like(layer.B))

    def step(self):
        """
        take one step in optimzation
        - apply SGD with momentum, to all layers of the model
        """
        index = 0
        for layer in self.model.Layers:
            if layer.has_params:
                self.vW[index] = self.momentum * self.vW[index] - self.lr * layer.gradW
                self.vB[index] = self.momentum * self.vB[index] - self.lr * layer.gradB
                layer.W += self.vW[index]
                layer.B += self.vB[index]
                index += 1

        self.num_steps += 1
        self.decay_lr()