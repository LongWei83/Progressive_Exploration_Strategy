import numpy as np

class Personal(object):
    def __init__(self, id, org_x, init_x, dimension, xL, xU, w, c1, c2, v_factor):
        super().__init__()
        self.id = id
        self.org_x = org_x
        self.x = init_x
        self.dimension = dimension
        self.xL = xL
        self.xU = xU
        self.pBest = np.zeros(dimension)      # personal best solution
        self.w = w
        self.c1 = c1
        self.c2 = c2
        self.v_factor = v_factor
        self.pBest_value = 0.0                  # personal best fitness
        self.frequency = 0.0
        self.qFactor = 0.0
        self.roverQ = 0.0
        self.shuntImpedance = 0.0
        self.pBest_shuntImpedance = 0.0
        self.pBest_freq = 0.0
        self.fitness = 0.0
        self.velocity = np.random.uniform(-0.0005,0.0005,4)  #初始化速度
        self.crowd_distance = 0.0
        self.x_List = []
        self.crowd_distance_List = []
        self.fitness_List = []
        self.shuntImpedance_List = []
        self.frequency_List = []
        self.rOverQ_List = []

    def calculate_fitness(self):     
        # 检查约束条件
        if self.roverQ > 20:
            div_num = abs(self.frequency - 5.71)
            if div_num < 0.01 :
                div_num = 0.01
            self.fitness = self.shuntImpedance / div_num
        else:
            self.fitness = 0

    def pso_single_step(self):
        if self.fitness >= self.pBest_value:
            self.pBest_value = self.fitness
            self.pBest = np.copy(self.x)
            self.pBest_shuntImpedance = self.shuntImpedance
            self.pBest_freq = self.frequency

    def calculate_crowd_distance(self,gBest):
        crowd_dis_vector = np.array(self.x) - np.array(gBest)
        crowd_dis = np.sum(crowd_dis_vector)
        self.crowd_distance = np.abs(crowd_dis)

    def update_velocity(self,gBest):
        rl = np.random.rand(self.dimension)
        rg = np.random.rand(self.dimension)
        
        v_local = np.multiply((self.pBest - self.x),rl)*self.c1
        v_global = np.multiply((gBest-self.x),rg)*self.c2
        
        velocity = self.w*self.velocity + v_local + v_global
        #如果粒子遇到边界则调转方向
        #for i in range(self.dimension):
        #    if self.x[i] <= self.xL[i] :
        #        velocity = np.abs(velocity)
        #    elif self.x[i] >= self.xU[i] :
        #        velocity = - np.abs(velocity)
        self.velocity = np.round(np.clip(velocity, -0.001, 0.001),4)
        print(self.velocity)

    def update_position(self):
        self.x = self.x + self.v_factor * self.velocity
        #如果粒子遇到边界则穿越到边界的另一端
        for i in range(self.dimension):
            if self.x[i] < self.xL[i] :
                self.x[i] = self.xU[i]
            elif self.x[i] > self.xU[i] :
                self.x[i] = self.xL[i]
        self.x = np.round(np.clip(self.x, self.xL, self.xU),4)
        