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
import gamelist as GlobalVar
game_list=GlobalVar.getGameList()

#code_src='E:/jyx/yhbz/temp_branch/'
code_src=os.path.join(os.getcwd(), "..", "switch") + "/"
print 'src = ' + code_src

# 加密用的KEY和SIGN
key = 'Ksfxxe_Adddjjds'
sign = 'XXJYX'

# 程序目录
dir = 'zip_script/'

# 启动目录
startDir = os.getcwd() + '\\'
src = code_src + 'gameclient\\'
srcServer = code_src + 'gameserver\\'
dir = startDir + dir
svn_path = code_src

ogg = dir + 'win32\ogg'
png = dir + 'win32\pngquanti.exe'
webp = dir + 'win32\webp\cwebp.exe' #不使用了
jpg = dir + 'win32\JPG-C_v3.1.exe'

php = dir + 'win32/php.exe'

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

# 生成增量包
def createAdd(url,path,cdn_update):
	srcpath = path + 'client/'
	outpath = path + 'client_add.zip'
	outcdn = path + 'reload_cdn.txt'
	upload_old = path + 'upload.old'

	print 'Start down ...'

	if os.path.exists(outpath) :
		os.remove(outpath)

	# 本地列表
	upload_file = startDir + srcpath + 'upload.list'
	print 'upload file ' + upload_file
	f = file(startDir + srcpath + 'upload.list')
	new_file = json.load(f)
	f.close()
	
	# 获取CDN地址
	while True :
		try:
			urllib.urlretrieve(url,upload_old)
			f = file(upload_old)
			old_file = json.load(f)
			f.close()
			os.remove(upload_old)
			url = old_file.get('u').split('\r\n')[0]
			if url[-1] != '/':
				url = url + '/'
			print 'CDN : ' + url
			break
		except urllib.error.URLError as ex:
			raw_input('net is error ,enter to reload')


	# 远程服务器列表
	old_file = 0
	while True :
		try:
			urllib.urlretrieve(url + 'upload.list',upload_old)
			f = file(upload_old)
			old_file = json.load(f)
			f.close()
			os.remove(upload_old)
			break
		except urllib.error.URLError as ex:         #处理超时、url不正确异常
			raw_input('net is error ,enter to reload')
			
	file_cdn = open(outcdn,'w')
	zip = zipfile.ZipFile(outpath, 'w' ,zipfile.ZIP_DEFLATED) 

	# 比对现有文件
	count = 0
	for key in new_file:
		md5 = new_file[key]['md5']
		obj = old_file.get(key)
		if obj <> None and obj['md5'] == md5 :
			continue

		fileName = key.replace('\\','/')
		print 'upload ' + fileName

		zip.write(srcpath + fileName,fileName)
		file_cdn.write(cdn_update + fileName + '\n')
		count = count + 1

	# 拷贝常用文件
	new_file = ['upload.list','upload.pc','upload.ios','upload.android','upload.ver']#,'upload_md5.pc','upload_md5.ios','upload_md5.android'
	for key in new_file:
		zip.write(srcpath + key,key)
		file_cdn.write(cdn_update + key + '\n')
	file_cdn.write(cdn_update + 'debug.txt')
	file_cdn.close()
	zip.close()

# 名字是否合格
def check(s):
    if re.match('^[0-9a-z._A-Z\-]+$',s):
        return True
    else:
        return False
		
# 检查目录下是否包含空格名
def checkPath(list, path):
    folderList = os.listdir(path)
    for key in folderList:
        sourceFile = os.path.join(path,  key) 
        if os.path.isdir(sourceFile): 
            checkPath(list, sourceFile)
        elif not check(key):
            list.append(sourceFile)
	

def doPackage(game_name,filter,cdnUrl,cdn_update,new_ver,upload_svn):
	print 'package : ' + game_name
	do_list = []
		
	out = startDir + game_name + '\\client\\'
	outServer = startDir + game_name + '\\server\\'
	cfg = out + 'upload'
	res = src + 'res\\' + game_name + '\\'
	
	os.system('mkdir "' + out + '"')
	os.system('mkdir "' + outServer + '"')

	# 先拷贝服务端数据
	do_list.append([4,'copy game server data',"{0}{1}.zip".format(srcServer,game_name),"{0}{1}.zip".format(outServer,game_name)])
	do_list.append([4,'copy game server jar',"{0}game.jar".format(srcServer),"{0}game.jar".format(outServer)])
	# 压缩脚本 1 php ,2 版本号，3 运行文件，4 拷贝文件
	do_list.append([1,'zip script.zip',"{0}lib/compile_scripts.php -m zip -i {1}src/ -o {2} -ek {3} -es {4} -e xxtea_zip -ex lua -x {5}".format(dir,src,res,key,sign,filter)])
	do_list.append([1,'zip res',"{0}lib/pack_files.php -i {1} -o {2} -ek {3} -es {4} -p {5} -t png,jpg,csb,atlas,json -xa pl -xi pl -xp pl -png {6}"
		.format(dir,res,out,key,sign,cfg,png)])
	do_list.append([2,'update ver'])

	#更新SVN号
	p = subprocess.Popen("TortoiseProc /command:update /path:{0} /closeonend:1".format(svn_path))
	p.wait()
	p = subprocess.Popen("TortoiseProc /command:update /path:{0} /closeonend:1".format(out))
	p.wait()
	
	# 检查文件
	emptyList = []
	checkPath(emptyList, src + 'src/')
	checkPath(emptyList, res)
	if len(emptyList) > 0:
		src_len = len(src)
		print '---------------------------文件名出错start------------------------------'.decode('utf-8').encode('gbk')
		for emptyList_i in range(0, len(emptyList)):
			tmp = emptyList[emptyList_i]
			print tmp[src_len:]
		print '---------------------------文件名出错end--------------------------------'.decode('utf-8').encode('gbk')
		os.system('pause')
		return

	list_len = len(do_list)
	for list_i in range(0,list_len):
		v = do_list[list_i]
		os.system("title {0}({1}/{2}-{3})".format(v[1],list_i,list_len,game_name))
		if v[0] == 2 : 
			ver_path = out + 'upload.ver'
			if os.path.exists(ver_path) :
				f = file(ver_path)
				ver_json = json.load(f)
				f.close()
			else :
				ver_json = {'ver':new_ver,'code':0}
			ver_json['ver'] = new_ver
			ver_json['code'] += 1
			
			print("set ver = {0},code = {1}".format(new_ver,ver_json.get('code')))
			f = file(ver_path,'wb')
			f.write(json.dumps(ver_json))
			f.close()
			continue
		if v[0] == 4 : # 拷贝文件
			if not os.path.exists(v[2]) :
				continue
			fileSource = open(v[2], "rb")
			fileTarget = open(v[3], "wb")
			fileTarget.write(fileSource.read())
			fileSource.close()
			fileTarget.close()
			continue
			
		if v[0] == 3 :
			# p = subprocess.Popen(v[2])
			os.system(v[2])
		else : # 1
			p = subprocess.Popen("{0} {1}".format(php,v[2]))
			p.wait()

	#删除文件bin目录
	bin_dir = res + 'bin'
	if os.path.exists(bin_dir) :
		shutil.rmtree(bin_dir)
		
	# 生成增量包
	createAdd(cdnUrl,game_name + '/',cdn_update)

	# 上传SVN  
	if upload_svn :
		p = subprocess.Popen("TortoiseProc /command:commit /path:{0}* /logmsg:\"[{1}.{2}][{3}] client package\" /closeonend:0".format(startDir + game_name,new_ver,ver_json.get('code'),game_name))
		p.wait()

# 生成过虑语言
def createFilter(game_name):
	filterList = []
	for gameVo in game_list:
		name = gameVo.get('name')
		if name != game_name :
			filterList.append('app.' + name)
			continue;

	return ','.join(filterList)
	
# 选择游戏
def chooseGame():
	msg = ''
	for i in range(len(game_list)):
		gameVo = game_list[i]
		projTab = "[%d]%s" % (i + 1,gameVo.get('name'))
		if i % 4 == 0 :
			projTab += '\n'
		else :
			for j in range(len(projTab),15) :
				projTab += ' '
		msg += projTab
	print msg
	
	num = readNumber('Choose game:',1,len(game_list))
	return game_list[num - 1]

# 主程序
def main():

	# 生成版本号
	while True :
		new_ver = raw_input("*** new ver:")
		new_ver_arr = new_ver.split('.')
		if len(new_ver_arr) == 3 :
			break
		print('ver is error . same: 1.0.0');
	
	gameVo = chooseGame()
	filter = createFilter(gameVo.get('name'))
	doPackage(gameVo.get('name'),filter,gameVo.get('url'),gameVo.get('cdnUpdate'),new_ver,True)
	
if __name__ == '__main__':
	main()


