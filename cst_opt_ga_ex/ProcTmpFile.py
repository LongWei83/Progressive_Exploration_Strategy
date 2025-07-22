import tempfile
import os

class ProcTmpFile(object):
    def __init__(self, tmpDir):
        super().__init__()
        self.tmpDir = tmpDir
        tempfile.tempdir = tmpDir

        if(not os.path.exists(tempfile.tempdir)):
            os.makedirs(tempfile.tempdir,exist_ok=True)

        print("tmp project in:", tempfile.tempdir)

    def create_tmp_file(self,suffix):
        tmpfile = tempfile.NamedTemporaryFile(mode="wb",suffix=suffix,delete =False)
        return tmpfile