import os
import numpy as np
import Personal
import glob
import shutil

import InitX
import History

class Group(object):
    def __init__(self, personal_num, max_iter, dimension, init_x, xL, xU):
        super().__init__()
        self.personals = []  # individuals in the group
        self.personal_num = personal_num
        self.max_iter = max_iter
        self.dimension = dimension
        self.xL = xL
        self.xU = xU
        self.gBest = np.zeros(dimension)        # group best solution
        self.gBest_value = 0.0                  # group best fitness
        self.iteration_count = 0                # number of iterations
        self.results_dirs = []
        self.Frequency = []
        self.QFactor = []
        self.RoverQ = []
        self.ShuntImpedance = []
        self.gBest_ShuntImpedance = 0.0
        self.gBest_Freq = 0.0
        self.gBest_List = []
        self.gBest_value_List = []
        self.gBest_id = 0
        self.gBest_id_List = []
        self.local_trap_cnt = 0
        self.initx_manager = InitX.InitX(init_x,xL,xU)
        self.history = History.History()

    def create_particles(self):
        if self.local_trap_cnt >=3:
            tmp_personals = np.copy(self.personals)
        self.personals.clear()             
        i = 0

        scale = 1
        if self.local_trap_cnt >=3:
             scale = 1.2 ** (self.local_trap_cnt-3)
        else:
             scale = 1

        for _ in range(self.personal_num):
            init_x = self.initx_manager.generate_random_numbers(scale)  # 随机生成符合上下限的初始个体
            personal = Personal.Personal(i, self.initx_manager.x_seed, init_x, self.dimension, self.xL, self.xU, 1, 2.0, 2.0, 1.0)  # 创建 Personal 实例
            self.add_personal(personal)  # 将个体添加到 Group 中
            i = i + 1
        #确保原始解也包括在初始化群体中
        personal = Personal.Personal(i, self.initx_manager.x_seed, self.initx_manager.x_seed, self.dimension, self.xL, self.xU, 1, 2.0, 2.0, 1.0)  # 创建 原始解的Personal 实例 
        self.add_personal(personal)  # 将原始解个体添加到 Group 中  
        if self.local_trap_cnt >= 3:
            for tmp_personal, personal in zip(tmp_personals, self.personals):
                personal.x_List = tmp_personal.x_List
                personal.crowd_distance_List = tmp_personal.crowd_distance_List
                personal.fitness_List = tmp_personal.fitness_List
                personal.shuntImpedance_List = tmp_personal.shuntImpedance_List
                personal.frequency_List = tmp_personal.frequency_List
                personal.rOverQ_List = tmp_personal.rOverQ_List

    def add_personal(self, personal: Personal):
        if len(self.personals) >= self.personal_num + 1:
            raise ValueError("The group is already full.")
        if not isinstance(personal, Personal.Personal):
            raise TypeError("The input must be a Personal object.")
        self.personals.append(personal)

    def distribute_tasks(self, tmp_dir):
        if(self.iteration_count < self.max_iter):
            #if self.local_trap_cnt >= 12:
            #    print("Finished PSO!")
            #    print("The Best solution is:", self.gBest)
            #    return 1
            if self.local_trap_cnt >= 3:
                self.initx_manager.x_seed = self.gBest
                self.create_particles()
            task_id = 0
            for personal in self.personals:
                #初始化任务标志文件task[task_id].txt
                task_flag_path = os.path.abspath(os.path.join(tmp_dir,"ge"+str(self.iteration_count)+"task"+ str(task_id) +".txt"))
                print(task_flag_path)
                #在任务标志文件中写入x列表对应的值
                f=open(task_flag_path,"w")
                for item in personal.x:
                    f.write(str(item)+"\n")
                f.close()
                task_id = task_id + 1

                personal.x_List.append(personal.x)
            return 0
        else:
            print("Finished PSO!")
            print("The Best solution is:", self.gBest)
            return 1
        

    def read_results(self, tmp_dir):
        self.results_dirs = sorted(glob.glob(os.path.join(tmp_dir, "ge*task*")), key=lambda x: int(x.split("task")[1]))
        self.Frequency.clear()
        self.QFactor.clear()
        self.RoverQ.clear()
        self.ShuntImpedance.clear()
        for dir_item in self.results_dirs:
            files_list = []
            files_list = glob.glob(os.path.join(dir_item,"*"))
            for file_item in files_list:
                filename = os.path.basename(file_item)
                with open(file_item, 'r') as f:
                    lines=f.readlines()
                    if len(lines)>3 :
                        value = float(lines[2].split()[1])
                        if "Frequency" in filename:
                                self.Frequency.append(value)
                        elif "QFactor" in filename:
                                self.QFactor.append(value)
                        elif "RoverQ" in filename:
                                self.RoverQ.append(value)
                        elif "ShuntImpedance" in filename:
                                self.ShuntImpedance.append(value)
                    f.close()

        i = 0
        for personal in self.personals:
             personal.frequency = self.Frequency[i]
             personal.qFactor = self.QFactor[i]
             personal.roverQ = self.RoverQ[i]
             personal.shuntImpedance = self.ShuntImpedance[i]
             personal.shuntImpedance_List.append(personal.shuntImpedance)
             personal.frequency_List.append(personal.frequency)
             personal.rOverQ_List.append(personal.roverQ)
             if personal.frequency == 0.0:
                 print("Wow!!")
             i = i + 1

        for dir_item in self.results_dirs:
             shutil.rmtree(dir_item)

    def pso_single_step(self,his_dir,time_list):
        # 单步PSO算法
        pre_gBest_value = self.gBest_value
        for personal in self.personals:
            personal.calculate_fitness()
            personal.pso_single_step()
            # 更新全局最佳位置和适应度值
            if personal.pBest_value > self.gBest_value:
                self.gBest_value = personal.pBest_value
                self.gBest = np.copy(personal.pBest)
                self.gBest_ShuntImpedance = personal.pBest_shuntImpedance
                self.gBest_Freq = personal.pBest_freq
                self.gBest_id = personal.id


            #print(personal.x) #个体解
            #print(personal.fitness) #个体适应度
            #print(personal.crowd_distance)
            #print(personal.pBest_value) #个体最佳适应度
        #防止所有粒子进入局部最优解
        if pre_gBest_value == self.gBest_value:
             self.local_trap_cnt = self.local_trap_cnt + 1
        else:
             self.local_trap_cnt = 0
        for personal in self.personals:
             personal.calculate_crowd_distance(self.gBest)
        #记录数据
        self.gBest_List.append(self.gBest)
        self.gBest_value_List.append(self.gBest_value)
        self.gBest_id_List.append(self.gBest_id)

        # 找到当前群体中crowd_distance最大的前25个粒子
        top_crowd_distance = sorted(self.personals, key=lambda p: p.crowd_distance, reverse=True)[:20]
        # 记录群体最优解数据
        task_flag_path = os.path.abspath(os.path.join(his_dir,"sub_success"+str(self.iteration_count)+".txt"))
        f=open(task_flag_path,"w")
        f.write(str(self.gBest)+"\n")
        f.write(str(self.gBest_value)+"\n")
        f.write(str(self.gBest_ShuntImpedance)+"\n")
        f.write(str(self.gBest_Freq)+"\n")
        f.close()

        for personal in self.personals:
            # 当前群体中crowd_distance最大的前10个粒子,保持个体速度，以扩大搜索范围
            if personal in top_crowd_distance and personal.fitness > 0:
                print("no update this one")
            else:
                personal.update_velocity(self.gBest)
            personal.update_position()
            #记录数据
            personal.crowd_distance_List.append(personal.crowd_distance)
            personal.fitness_List.append(personal.fitness)

        self.iteration_count = self.iteration_count + 1

        self.history.record_personals(self,his_dir)
        self.history.record_group(self,his_dir)
        self.history.record_time(time_list,his_dir)