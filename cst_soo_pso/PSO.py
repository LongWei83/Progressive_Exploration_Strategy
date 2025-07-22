import numpy as np

class PSO(object):
    def __init__(self, particles_number, max_iter, x, xL, xU):
        super().__init__()
        self.particles_number = particles_number                # population size (number of particles)
        self.max_iter = max_iter    # maximum number of iterations
        self.x = x                  # x parameters
        self.xL = xL                # min values of x
        self.xU = xU                # max values of x