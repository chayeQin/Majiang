#encoding:utf-8
import os
import sys 
import re
# reload(sys) 
# sys.setdefaultencoding('utf8') 

num = 0

def _verifyContent(path):
    folderList = os.listdir(path)
    for key in folderList:
        sourceFile = os.path.join(path,  key) 
        if os.path.isdir(sourceFile): 
            _verifyContent(sourceFile)
        elif not check(key):
            print sourceFile
    return 

def readPath():
    v = raw_input()
    return v

def check(s):
    if re.match('^[0-9a-z._A-Z]+$',s):
        return True
    else:
        return False

if __name__ == "__main__":
	gameList = ["yhbz"]
	for game in gameList:
		path = sys.path[0] + '/../trunk/gameclient/res/' + game + '/'
		_verifyContent(path)
	os.system("pause")



