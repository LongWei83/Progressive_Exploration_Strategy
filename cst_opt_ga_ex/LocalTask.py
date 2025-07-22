import subprocess
import ProcVBA
import ProcTmpFile
import os

class LocalTask(object):
    def __init__(self, realpath_cstexepath, realpath_cst_project, tmp_dir):
        super().__init__()
        self.realpath_cstexepath = realpath_cstexepath
        self.realpath_cst_project = realpath_cst_project
        self.tmp_dir = tmp_dir
        #初始化临时文件管理器
        self.tmp_manager = ProcTmpFile.ProcTmpFile(tmp_dir)
        #初始化预处理VBA脚本管理器
        self.procVBA_manager = ProcVBA.ProcVBA()
        #创建临时CST项目文件
        self.tmp_cst=self.tmp_manager.create_tmp_file('.cst')
        #复制CST项目到临时的cst项目文件
        fcst=open(self.realpath_cst_project,"rb")
        content=fcst.read()
        self.tmp_cst.file.write(content)
        self.tmp_cst.file.close()
        #创建临时的CST参数文件
        self.tmp_parms=self.tmp_manager.create_tmp_file('.txt')

        self.tmpcstpath = os.path.abspath(os.path.join(self.tmp_dir,self.tmp_cst.name))
        self.tmpparmspath = os.path.abspath(os.path.join(self.tmp_dir,self.tmp_parms.name))


    def start_LocalTask(self, vbasrcpath, org_str0, dst_str0, org_str1, dst_str1):
        status = 0

        tmp_localtask=self.tmp_manager.create_tmp_file('.bas')

        tmplocaltaskpath = os.path.abspath(os.path.join(self.tmp_dir,tmp_localtask.name))

        print("tmplocaltaskpath is :", tmplocaltaskpath)

        #查找是否真实存在原始读取参数VBA脚本，否则退出程序
        if(not os.path.exists(vbasrcpath)):
            print("can't find the VBA script in :",vbasrcpath)
            print("quit the program!")
            os._exit(1)

        #打开原始读取参数VBA脚本文件
        VBA_file = open(vbasrcpath,"r")

        #打开将要生成的预处理读取参数VBA脚本文件
        VBA_dstfile = tmp_localtask.file

        self.procVBA_manager.proc(VBA_file, VBA_dstfile, org_str0, dst_str0, org_str1, dst_str1)

        command = "\""+ self.realpath_cstexepath + "\"" +" -m " + "\"" + tmplocaltaskpath + "\""

        print("run VBA command:",command)
        #使用subprocess.Popen启动一个新的进程来执行CST程序并调用一个VBA脚本
        try:
            with subprocess.Popen(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True) as cstProcess:
                stdout, stderr = cstProcess.communicate()
                if cstProcess.returncode == 0:
                    print("Command executed successfully.")
                    if stdout:
                        print(stdout.decode())
                else:
                    print("Error executing command. Return code:", cstProcess.returncode)
                    if stderr:
                        print(stderr.decode())
        except Exception as e:
            print("An error occurred:", str(e))

        #关闭VBA源文件
        VBA_file.close()
        #关闭并删除临时的VBA脚本文件
        VBA_dstfile.close()
        os.remove(tmplocaltaskpath)

        return status