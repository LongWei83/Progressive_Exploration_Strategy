import os
import glob
import matplotlib.pyplot as plt
import numpy as np

class Visual_Chart(object):
    def __init__(self, tmp_dir):
        super().__init__()
        self.tmp_dir = tmp_dir

    def plot_chart(self):

        his_files = sorted(glob.glob(os.path.join(self.tmp_dir, "History*")), key=lambda x: (x.split("History")[1]))
        print(his_files)

        for file_item in his_files:
            data = []
            filename = os.path.basename(file_item)

            if "Group_Fitness1" in filename:
                with open(file_item, 'r') as f:
                    for readline in f:
                        data.append(float(readline.strip()))
                plt.plot(data, marker='o', linestyle='-')
                plt.xlabel('Iterations',fontsize=16)
                plt.ylabel('Fitness',fontsize=16)
                plt.title('Global Best Fitness',fontsize=18)
                plt.grid(True)
                plt.tight_layout()
                plt.show()

            if "Group_id" in filename:
                with open(file_item, 'r') as f:
                    for readline in f:
                        data.append(int(readline.strip()))
                plt.scatter(range(0,len(data)), data)
                plt.xlabel('Iterations',fontsize=16)
                plt.ylabel('Particle ID',fontsize=16)
                plt.title('Best Solution ID',fontsize=18)
                plt.grid(True)
                plt.show()

            if "Group_Solution" in filename:
                with open(file_item, 'r') as f:
                    for readline in f:
                        data.append(np.fromstring(readline.strip()[1:-1], dtype=float, sep=' '))
                    print(data)
                # 提取前两列和后两列数据
                xy_data = np.array(data)[:, :2]
                zw_data = np.array(data)[:, 2:]
                fig, axs = plt.subplots(2, 2, figsize=(10, 10))
                fig.suptitle('Best Solution',fontsize=18)
                axs[0, 0].scatter(range(0,len(data)), xy_data[:, 0])
                axs[0, 0].set_xlabel('Iterations',fontsize=16)
                axs[0, 0].set_ylabel('X[0]',fontsize=16)
                axs[0, 0].grid(True)
                axs[0, 1].scatter(range(0,len(data)), xy_data[:, 1])
                axs[0, 1].set_xlabel('Iterations',fontsize=16)
                axs[0, 1].set_ylabel('X[1]',fontsize=16)
                axs[0, 1].grid(True)
                axs[1, 0].scatter(range(0,len(data)), zw_data[:, 0])
                axs[1, 0].set_xlabel('Iterations',fontsize=16)
                axs[1, 0].set_ylabel('X[2]',fontsize=16)
                axs[1, 0].grid(True)
                axs[1, 1].scatter(range(0,len(data)), zw_data[:, 1])
                axs[1, 1].set_xlabel('Iterations',fontsize=16)
                axs[1, 1].set_ylabel('X[3]',fontsize=16)
                axs[1, 1].grid(True)

                plt.show()