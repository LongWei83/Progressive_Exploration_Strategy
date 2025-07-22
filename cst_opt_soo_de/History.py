import Group
import os

class History(object):
    def __init__(self):
        super().__init__()

    def record_personals(self, group,his_dir):
        for personal in group.personals:
            task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Personal_Solution"+str(personal.id)+".txt"))
            f=open(task_flag_path,"w")
            for item in personal.x_List:
                f.write(str(item)+"\n")
            f.close()

            task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Personal_Fitness"+str(personal.id)+".txt"))
            f=open(task_flag_path,"w")
            for item in personal.fitness_List:
                f.write(str(item)+"\n")
            f.close()

            task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Personal_ShuntImp"+str(personal.id)+".txt"))
            f=open(task_flag_path,"w")
            for item in personal.shuntImpedance_List:
                f.write(str(item)+"\n")
            f.close()

            task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Personal_Freq"+str(personal.id)+".txt"))
            f=open(task_flag_path,"w")
            for item in personal.frequency_List:
                f.write(str(item)+"\n")
            f.close()

            task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Personal_rOverQ"+str(personal.id)+".txt"))
            f=open(task_flag_path,"w")
            for item in personal.rOverQ_List:
                f.write(str(item)+"\n")
            f.close()

    def record_group(self,group,his_dir):
        task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Group_Solution"+".txt"))
        f=open(task_flag_path,"w")
        for item in group.gBest_List:
            f.write(str(item)+"\n")
        f.close()

        task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Group_Fitness"+".txt"))
        f=open(task_flag_path,"w")
        for item in group.gBest_value_List:
            f.write(str(item)+"\n")
        f.close()

        task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Group_id"+".txt"))
        f=open(task_flag_path,"w")
        for item in group.gBest_id_List:
            f.write(str(item)+"\n")
        f.close()

    def record_time(self, time_list, his_dir):
        task_flag_path = os.path.abspath(os.path.join(his_dir,"History_Time"+".txt"))
        f=open(task_flag_path,"w")
        for item in time_list:
            f.write(str(item)+"\n")
        f.close()

        f.close()