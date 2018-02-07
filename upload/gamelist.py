#!/usr/bin/python
# -*- coding: utf-8 -*-  
#coding=utf-8  

class GlobalVar: 
	game_list=[
		{'name':'majiang','url':'http://58.220.3.9:11000/','cdnUpdate':'/res/'}, # 银河霸主
	]

def getGameList(): 
	return GlobalVar.game_list
	
