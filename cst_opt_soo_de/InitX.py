import numpy as np

class InitX(object):
    def __init__(self, x_seed, xL, xU):
        super().__init__()
        self.x_seed = x_seed
        self.xL = xL
        self.xU = xU

    def generate_random_numbers(self, scale):
        # 设置均值和标准差
        mean_list = self.x_seed
        random_numbers = []
    
        #1.生成随机解，从一个比较好的解开始
        for mean, xL, xU in zip(mean_list,self.xL,self.xU):
            # 生成随机数
            #random_number = np.random.normal(loc=mean, scale= 0.007*scale)
            random_number = np.random.normal(loc=mean, scale= (xU - xL)*0.05*scale)

            while random_number > xU and random_number < xL:
                if random_number > xU :
                    random_number = xL + (random_number - xU)
                if random_number < xL :
                    random_number = xU - (xL - random_number)
            
            # 限制随机数范围在[mean-0.5, mean+0.5]之间
            random_numbers.append(np.round(random_number,4))

        #2.生成随机解，不从一个比较好的解开始
        #random_numbers = np.round(np.random.uniform(self.xL, self.xU, size= 4),4)

        random_numbers = np.clip(random_numbers,self.xL,self.xU)
        
        return random_numbers