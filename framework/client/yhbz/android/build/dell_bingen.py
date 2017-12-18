# -*- coding: utf-8 -*-
import os
import re
import sys
import shutil

def replaceFile(sourceFile, targetFile, sourceStr, targetStr):
    sfp = open(sourceFile,'rb')
    result, num = re.subn(sourceStr, targetStr, sfp.read())
    print num, sourceFile
    sfp.close()
    tfp = open(targetFile, "wb")
    tfp.write(result)
    tfp.close()

def delDir(ppath,delRes):
	dirlist = None
	try:
		dirlist = os.listdir(ppath)
	except:
		return
	for dir in dirlist:
		if os.path.isfile(dir):
			continue
		if dir == '.svn' or dir == 'build':
			continue
			
		if dir != 'bin' and dir != 'gen' and dir != 'res' :
			dpath = ppath + dir + '/'
			delDir(dpath,delRes)
			continue
		if dir == 'res':
			if not delRes:
				continue
				
			str_len = len(ppath)
			str = ppath[str_len - 7:str_len - 1]
			if str != 'assets':
				continue
		if dir == 'bin':
			dpath = ppath + dir + '/main.lua'
			if os.path.exists(dpath):
				continue
				
		dpath = ppath + dir
		print 'del ' + dpath
		shutil.rmtree(dpath)

if __name__ == '__main__':
	mpath = sys.path[0] + "/../"
	delRes = raw_input("any key remove res,enter is not:")
	if (delRes != ""):
		print '*** remove res dir'
	delDir(mpath,delRes != "")