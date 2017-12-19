#!/usr/bin/python
# -*- coding: utf-8 -*-  
#coding=utf-8  

class GlobalVar: 
	game_list=[
		{'name':'yhbz','url':'http://yhbz-web.my-seiya.com:8079/account/game?plat=demo','cdnUpdate':'/res/'}, # 银河霸主
	]

def getGameList(): 
	return GlobalVar.game_list
	
