import torch
import torchfile
import numpy as np
import sys


def load_file(file_path):
    try:
        return torchfile.load(file_path)
    except:
        return torch.load(file_path)

    print('Cannot load file: %s' % (file_path))
    sys.exit(-1)


def save_file(obj, file_path):
    try:
        torch.save(obj, file_path)
    except:
        print('Cannot save file: %s' % (file_path))
        sys.exit(-1)
