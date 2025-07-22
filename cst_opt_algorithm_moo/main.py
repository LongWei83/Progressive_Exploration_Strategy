import os
import sys
import argparse
import json
import glob
import time

import projectutil

import LocalTask
import Group
import History


params = sys.argv

params=sys.argv
###设定命令行参数PARSER
parser = argparse.ArgumentParser(description='import a cst project.')

parser.add_argument("-p", "--project", action="store", dest="project", help="project路径")

args = parser.parse_args()

cst_project = args.project

realpath_cst_project = os.path.realpath(cst_project)

print("cst project in :",realpath_cst_project)

if (not os.path.exists(realpath_cst_project)):
    print("can't find the cst project in :",realpath_cst_project)
    print("quit the program!")
    os._exit(1)

cstexepath = "C:\CST2020\CST DESIGN ENVIRONMENT.exe"
realpath_cstexepath = os.path.realpath(cstexepath)

if (os.path.exists(realpath_cstexepath)):
    print("cst program in :",realpath_cstexepath)
else:
    print("can't find the cst program in :",realpath_cstexepath)
    print("quit the program!")
    os._exit(1)

cst_project_dir = os.path.dirname(realpath_cst_project)
base_project_dir = os.path.dirname(cst_project_dir)
tmp_dir = os.path.join(base_project_dir,"tmp")
his_dir = os.path.join(base_project_dir,"history")

if not os.path.exists(tmp_dir):
    # 如果文件夹不存在，则创建文件夹
    os.makedirs(tmp_dir)

if not os.path.exists(his_dir):
    # 如果文件夹不存在，则创建文件夹
    os.makedirs(his_dir)

#初始化CST本地任务管理器
localTask_manager = LocalTask.LocalTask(realpath_cstexepath, realpath_cst_project, tmp_dir)

#生成原始读取参数VBA脚本的绝对路径
vbasrcpath = os.path.abspath(os.path.join(base_project_dir,"readParamsT.vb"))

#替换原始读取参数VBA脚本文件中的字符，并生成执行的VBA脚本
localTask_manager.start_LocalTask(vbasrcpath, '%PARAMDSTPATH%',localTask_manager.tmpparmspath,'%CSTPROJFILE%',localTask_manager.tmpcstpath)

#从临时的参数文件中生成json格式的参数列表文件
params_path = os.path.abspath(os.path.join(base_project_dir,"params.json"))

#删除已经存在了的json参数文件
if(os.path.exists(params_path)):
    os.remove(params_path)

#生成新的json参数文件
projectutil.custom_ascii_2_json(localTask_manager.tmpparmspath,"params.json")

#从参数文件中生成参数列表
f=open(params_path,"r")
parms_list=json.load(f)
print(type(parms_list))
f.close()

#将参数列表中的值提取并放入x列表中
x = []
for item in parms_list:
    if(item['name'] == 'D'):
        x.append(float(item['value']))
    elif(item['name'] == 'aa'):
        x.append(float(item['value']))
    elif(item['name'] == 'cc'):
        x.append(float(item['value']))
    elif(item['name'] == 'mm'):
        x.append(float(item['value']))

print("original x :",x)

#定义参数的下限
xL = [None] * len(x)
xL[0] = 3
xL[1] = 0.36
xL[2] = 0.72
xL[3] = 3
#print("xL :",xL)

#定义参数的上限
xU = [None] * len(x)
xU[0] = 6
xU[1] = 0.48
xU[2] = 0.92
xU[3] = 6

#print("xL :",xL)

personal_num = 50           # population size (number of particles)
dimension = 4              # dimension (= no. of parameters in the fitness function)
max_iter = 100              # maximum number of iterations 

de_group = Group.Group(personal_num, max_iter, dimension, x, xL, xU)

de_group.create_particles()

#生成原始CST本地任务VBA脚本的绝对路径
localtaskVBApath = os.path.abspath(os.path.join(base_project_dir,"LocalTask.vb"))

time_list = []

# 开始CST本地任务，这段代码可以放到多台远程电脑运行，并设置为处理部分文件而不是全部文件
# 获取共享目录中所有符合条件的文件名，并按照指定顺序排序
while True:
    task_flag_files = []
    #发布本地CST处理任务文件
    if de_group.distribute_tasks(tmp_dir):
        break
    else:
        print("next iter")
    task_flag_files = sorted(glob.glob(os.path.join(tmp_dir, "ge*task*.txt")), key=lambda x: int(x.split("task")[1].split(".")[0]))
    if(len(task_flag_files) == 0):
        print("No tasks distributed!!")

    start_time = time.time()

    for task_flag_path in task_flag_files:
        abs_task_flag_path = os.path.abspath(task_flag_path)
        localTask_manager.start_LocalTask(localtaskVBApath, '%TASKFLAGFILE%',task_flag_path,'%CSTPROJFILE%',localTask_manager.tmpcstpath)  
        # 处理完文件后，删除该文件
        os.remove(task_flag_path)


    #读取CST仿真结果
    de_group.read_results(tmp_dir)

    local_end_time = time.time()
    execute_time = local_end_time - start_time
    time_list.append(execute_time)
    start_time = time.time()

    # 单步PSO算法
    de_group.moo_de_single_step(his_dir,tmp_dir,localTask_manager,localtaskVBApath,time_list)

    end_time = time.time()
    execute_time = end_time - start_time

    time_list.append(execute_time)

print("All DE tasks finished!!")
#删除临时的CST项目文件和文件夹
#os.remove(tmp_cst.name)
#shutil.rmtree(os.path.splitext(tmpcstpath)[0])