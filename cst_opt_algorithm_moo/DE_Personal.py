import numpy as np

class DE_Personal(object):
    def __init__(self, id, org_x, init_x, dimension, xL, xU, F, CR):
        super().__init__()
        self.id = id
        self.org_x = org_x
        self.x = init_x
        self.dimension = dimension
        self.xL = xL
        self.xU = xU
        self.F = F
        self.CR = CR
        self.pBest = np.zeros(dimension)      # personal best solution
        self.pBest_value = [0.0,0.0,100.0]                  # personal best fitness
        self.frequency = 0.0
        self.qFactor = 0.0
        self.roverQ = 0.0
        self.shuntImpedance = 0.0
        self.pBest_shuntImpedance = 0.0
        self.pBest_freq = 0.0
        self.pBest_qFactor = 0.0
        self.fitness = 0.0
        self.x_List = []
        self.fitness_List = []
        self.shuntImpedance_List = []
        self.frequency_List = []
        self.rOverQ_List = []
        self.recalc = True
        self.rank = None
        self.crowding_distance = 0
        self.moo_fitness = None

    def calculate_fitness(self):     
        # 检查约束条件
        if self.roverQ > 20:
            div_num = abs(self.frequency - 5.71)
            if div_num < 0.01 :
                div_num = 0.01
            self.fitness = self.shuntImpedance / div_num
        else:
            self.fitness = 0

    def trial_fitness(self, roverQ, frequency, shuntImpedance):     
        # 检查约束条件
        if roverQ > 20:
            div_num = abs(frequency - 5.71)
            if div_num < 0.01 :
                div_num = 0.01
            fitness = shuntImpedance / div_num
        else:
            fitness = 0
        return fitness

    def de_single_step(self):
        if self.fitness >= self.pBest_value:
            self.pBest_value = self.fitness
            self.pBest = np.copy(self.x)
            self.pBest_shuntImpedance = self.shuntImpedance
            self.pBest_freq = self.frequency

    def moo_de_single_step(self):
        if self.roverQ > 20:
            if (self.shuntImpedance >= self.pBest_value[0]) and (self.qFactor >= self.pBest_value[1]) and (abs(self.frequency-5.71) <= abs(self.pBest_value[2]-5.71)):
                self.pBest_value[0] = self.shuntImpedance
                self.pBest_value[1] = self.qFactor
                self.pBest_value[2] = self.frequency
                self.pBest = np.copy(self.x)
                self.pBest_shuntImpedance = self.shuntImpedance
                self.pBest_freq = self.frequency
                self.pBest_qFactor = self.qFactor

    def update_position(self):
        self.x = self.x + self.v_factor * self.velocity
        #如果粒子遇到边界则穿越到边界的另一端
        for i in range(self.dimension):
            if self.x[i] < self.xL[i] :
                self.x[i] = self.xU[i]
            elif self.x[i] > self.xU[i] :
                self.x[i] = self.xL[i]
        self.x = np.round(np.clip(self.x, self.xL, self.xU),4)
        