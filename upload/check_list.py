#!/usr/bin/python
# -*- coding: utf-8 -*-  
#coding=utf-8  
import os
import json
import urllib
import shutil
import zipfile
import subprocess
import shutil
import re
import hashlib
import zlib
import threading
import time
import sys

# CDN
CDNS = [
	'http://yhbz-cdn2.my-seiya.com/yhbz/v257/'
]

# 检查平台
platform = ['upload.ios', 'upload.android']

# 启动目录
startDir = os.getcwd() + '/'
filePath = startDir + 'temp'
threads = []
THREAD_COUNT = 10 #同时下载数量太大..服务器会拒绝
TRY_COUNT = 3 # 出现下载失败或MD5不一样时重试次数(共)
mutex = threading.Lock()

def readNumber(msg,min,max):
	v = 0
	while True :
		v = raw_input(msg)
		if v == '' :
			v = 0
		else :
			v = int(v)
			
		if v >= min and v <= max :
			break

	return v
	
def md5(str):
    m = hashlib.md5()  
    m.update(str)
    return m.hexdigest()
	
def md5file(filename):
    if not os.path.isfile(filename):
        return
    myhash = hashlib.md5()
    f = file(filename,'rb')
    while True:
        b = f.read(8096)
        if not b :
            break
        myhash.update(b)
    f.close()
    return myhash.hexdigest()
	
def checkFile(url,md5,key,index):
	global THREAD_COUNT
	global threads
	
	url = url.replace('\\', '/')
	new_md5 = ''
	tmp = filePath + str(index)
	count = 0
	while True:
		try:
			count += 1
			urllib.urlretrieve(url,tmp)
			new_md5 = md5file(tmp)
						
			if os.path.isfile(tmp):
				os.remove(tmp)
			
			if md5 == new_md5 :
				break
			else:
				raise Exception("执行下载失败处理")
		except :
			if count > TRY_COUNT:
				print 'down error :' + key + ' try : ' + str(count)
				break
			time.sleep(0.1)
	
	for t in threads:
		if t.key == key :
			mutex.acquire(1)
			threads.remove(t)
			mutex.release()
			break
	
	if md5 != new_md5:
		print 'file md5 error : ' + key
		print 'old : ' + md5
		print 'new : ' + new_md5

def check(url, fileName):
	print 'check cdn :' + url + fileName
	urllib.urlretrieve(url + fileName,filePath)
	f = file(filePath, 'rb')
	files = f.read()
	f.close()
	if os.path.isfile(filePath):
		os.remove(filePath)

	files = zlib.decompress(files)
	files = json.loads(files)
	
	index = 0
	sum = len(files)
	
	for key in files:
		md5 = files[key]['md5']
		
		index += 1
		t = threading.Thread(target=checkFile,args=(url + key, md5, key,index))
		t.key = key
		while True:
			if THREAD_COUNT == 0:
				break
				
			if len(threads) < THREAD_COUNT :
				mutex.acquire(1)
				threads.append(t)
				mutex.release()
				t.setDaemon(True)
				t.start()
				
				pro('check : ' + str(index) + '/' + str(sum))
				break
			else:
				time.sleep(0.01)

	return True

def pro(str) :
	sys.stdout.write(str + '\r')
	sys.stdout.flush()
			
# 主程序
def main():
	for url in CDNS:
		for fileName in platform:
			check(url, fileName)
			while True: # 等待所有进程处理完
				if len(threads) < 1 :
					break
				else:
					time.sleep(0.1)
	raw_input('check complete')
	
if __name__ == '__main__':
	main()


