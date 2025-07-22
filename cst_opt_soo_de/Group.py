import os
import numpy as np
import DE_Personal
import glob
import shutil
import random
import re

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
        self.Frequency = [0.0]*(self.personal_num+1)
        self.QFactor = [0.0]*(self.personal_num+1)
        self.RoverQ = [0.0]*(self.personal_num+1)
        self.ShuntImpedance = [0.0]*(self.personal_num+1)
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
            personal = DE_Personal.DE_Personal(i, self.initx_manager.x_seed, init_x, self.dimension, self.xL, self.xU, 0.8, 0.9)  # 创建 Personal 实例
            self.add_personal(personal)  # 将个体添加到 Group 中
            i = i + 1
        #确保原始解也包括在初始化群体中
        personal = DE_Personal.DE_Personal(i, self.initx_manager.x_seed, self.initx_manager.x_seed, self.dimension, self.xL, self.xU, 0.8, 0.9)  # 创建 原始解的Personal 实例 
        self.add_personal(personal)  # 将原始解个体添加到 Group 中  
        if self.local_trap_cnt >= 3:
            for tmp_personal, personal in zip(tmp_personals, self.personals):
                personal.x_List = tmp_personal.x_List
                personal.fitness_List = tmp_personal.fitness_List
                personal.shuntImpedance_List = tmp_personal.shuntImpedance_List
                personal.frequency_List = tmp_personal.frequency_List
                personal.rOverQ_List = tmp_personal.rOverQ_List

    def add_personal(self, personal: DE_Personal):
        if len(self.personals) >= self.personal_num + 1:
            raise ValueError("The group is already full.")
        if not isinstance(personal, DE_Personal.DE_Personal):
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
                if personal.recalc == True:
                    #初始化任务标志文件task[task_id].txt
                    task_flag_path = os.path.abspath(os.path.join(tmp_dir,"ge"+str(self.iteration_count)+"task"+ str(task_id) +".txt"))
                    print(task_flag_path)
                    #在任务标志文件中写入x列表对应的值
                    f=open(task_flag_path,"w")
                    for item in personal.x:
                        f.write(str(item)+"\n")
                    f.close()
                    personal.recalc = False
                task_id = task_id + 1

                personal.x_List.append(personal.x)
            return 0
        else:
            print("Finished PSO!")
            print("The Best solution is:", self.gBest)
            return 1
        

    def read_results(self, tmp_dir):
        self.results_dirs = sorted(glob.glob(os.path.join(tmp_dir, "ge*task*")), key=lambda x: int(x.split("task")[1]))

        task_numbers = []
        for dir_item in self.results_dirs:
            match = re.search(r'task(\d+)', dir_item)  # 匹配task后面跟随的数字
            if match:
                task_numbers.append(int(match.group(1)))  # 将匹配到的数字添加到列表中

        for index, dir_item in zip(task_numbers,self.results_dirs):
            files_list = []
            files_list = glob.glob(os.path.join(dir_item,"*"))
            for file_item in files_list:
                filename = os.path.basename(file_item)
                with open(file_item, 'r') as f:
                    lines=f.readlines()
                    if len(lines)>3 :
                        value = float(lines[2].split()[1])
                        if "Frequency" in filename:
                                self.Frequency[index] = value
                        elif "QFactor" in filename:
                                self.QFactor[index] = value
                        elif "RoverQ" in filename:
                                self.RoverQ[index] = value
                        elif "ShuntImpedance" in filename:
                                self.ShuntImpedance[index] = value
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

    def de_single_step(self,his_dir,tmp_dir,localTask_manager,localtaskVBApath,time_list):
        # 单步PSO算法
        pre_gBest_value = self.gBest_value
        for personal in self.personals:
            personal.calculate_fitness()
            personal.de_single_step()
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
        
        #记录数据
        self.gBest_List.append(self.gBest)
        self.gBest_value_List.append(self.gBest_value)
        self.gBest_id_List.append(self.gBest_id)

        # 记录群体最优解数据
        task_flag_path = os.path.abspath(os.path.join(his_dir,"sub_success"+str(self.iteration_count)+".txt"))
        f=open(task_flag_path,"w")
        f.write(str(self.gBest)+"\n")
        f.write(str(self.gBest_value)+"\n")
        f.write(str(self.gBest_ShuntImpedance)+"\n")
        f.write(str(self.gBest_Freq)+"\n")
        f.close()

        for personal in self.personals:
            # Add DE single step
            available_personals = [p for p in self.personals if p != personal]
            r1, r2 = random.sample(available_personals, 2)

            # DE/rand/1 mutation
            X_best = self.gBest  # 假设 gBest 是当前群体最优解

            # 获取个人、r1 和 r2 的解向量
            X_i = personal.x  # 当前个体的解向量
            X_r1 = r1.x  # r1 的解向量
            X_r2 = r2.x  # r2 的解向量

            # DE/current-to-best/1 变异策略公式
            V = X_i + personal.F * (X_best - X_i) + personal.F * (X_r1 - X_r2)

            # 处理V[i]超出边界的问题和限制精度
            for i in range(self.dimension):
                while V[i] < personal.xL[i] or V[i] > personal.xU[i]:
                    if V[i] < personal.xL[i]:
                        V[i] = personal.xU[i] - personal.xL[i] + V[i]
                    elif V[i] > personal.xU[i]:
                        V[i] = V[i] - personal.xU[i] + personal.xL[i]

                V[i] = round(V[i], 4)

            # 生成随机掩码
            crossover_mask = np.random.rand(personal.dimension) < personal.CR

            # 确保至少有一个维度来自变异向量 V
            crossover_mask[random.randint(0, personal.dimension - 1)] = True

            # 执行交叉操作，生成试验向量 U
            U = np.where(crossover_mask, V, X_i)
            trial_task_path = os.path.abspath(os.path.join(tmp_dir,"trial_task"+".txt"))
            

            #在任务标志文件中写入x列表对应的值
            f=open(trial_task_path,"w")
            for item in U:
                f.write(str(item)+"\n")
            f.close()

            localTask_manager.start_LocalTask(localtaskVBApath, '%TASKFLAGFILE%',trial_task_path,'%CSTPROJFILE%',localTask_manager.tmpcstpath)  

            result_files_list = []
            trial_task_dir = os.path.join(tmp_dir, "trial_task")
            result_files_list = glob.glob(os.path.join(trial_task_dir,"*"))

            for file_item in result_files_list:
                filename = os.path.basename(file_item)
                with open(file_item, 'r') as f:
                    lines=f.readlines()
                    if len(lines)>3 :
                        value = float(lines[2].split()[1])
                        if "Frequency" in filename:
                                trial_Frequency = value
                        elif "QFactor" in filename:
                                trial_QFactor = value
                        elif "RoverQ" in filename:
                                trial_RoverQ = value
                        elif "ShuntImpedance" in filename:
                                trial_ShuntImpedance = value
                    f.close()

                # 删除文件
                os.remove(file_item)   
            
            trial_fitness = personal.trial_fitness(trial_RoverQ,trial_Frequency,trial_ShuntImpedance)

            if trial_fitness > personal.fitness:
                 personal.x = U
                 personal.fitness = trial_fitness
                 personal.recalc = True

        self.iteration_count = self.iteration_count + 1

        self.history.record_personals(self,his_dir)
        self.history.record_group(self,his_dir)
        self.history.record_time(time_list,his_dir)