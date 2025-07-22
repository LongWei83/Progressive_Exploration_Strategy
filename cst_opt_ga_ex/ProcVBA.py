import os
import re

class ProcVBA(object):
    def __init__(self):
        super().__init__()

    def proc(self, src_file, dst_file, org_str0, dst_str0, org_str1, dst_str1):
        status = 0

        VBA_List = []

        for line in src_file.readlines():
            ssd=line
            ssd=re.sub(org_str0, dst_str0.replace('\\','\\\\'),ssd)
            ssd=re.sub(org_str1, dst_str1.replace('\\','\\\\'),ssd)
            VBA_List.append(ssd)
        src_file.close()

        for i in range(len(VBA_List)):
            dst_file.write(VBA_List[i].encode())
        dst_file.close()
        return status