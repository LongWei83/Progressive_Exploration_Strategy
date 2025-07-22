import Visual_Chart
import os
import matplotlib.pyplot as plt
import numpy as np

cst_project = "projects\\Regular_cell_Test_ALO.cst"
realpath_cst_project = os.path.realpath(cst_project)
cst_project_dir = os.path.dirname(realpath_cst_project)
base_project_dir = os.path.dirname(cst_project_dir)
tmp_dir = os.path.join(base_project_dir,"tmp")

visual_Chart_manager = Visual_Chart.Visual_Chart(tmp_dir= tmp_dir)
visual_Chart_manager.plot_chart()