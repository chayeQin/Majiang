--
--@brief: 
--@author: qyp
--@date: 2017/12/24
--

local cls = class("RoomView", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/RoomView.csb"

cls.RESOURCE_BINDING = {
	["img_wifi1"] = {
		varname = "img_wifi1",
	},
	["img_wifi2"] = {
		varname = "img_wifi2",
	},
	["img_wifi3"] = {
		varname = "img_wifi3",
	},
	["img_wifi4"] = {
		varname = "img_wifi4",
	},
	["btn_voice"] = {
		varname = "btn_voice",
		method = "btn_voiceHandler",
	},
	["btn_chat"] = {
		varname = "btn_chat",
		method = "btn_chatHandler",
	},
	["btn_settting"] = {
		varname = "btn_settting",
		method = "btn_setttingHandler",
	},
	["btn_rules"] = {
		varname = "btn_rules",
		method = "btn_rulesHandler",
	},
	["node_battery"] = {
		varname = "node_battery",
	},
	["img_batteryBg"] = {
		varname = "img_batteryBg",
	},
	-- 房间号：99
	["lab_tableNum"] = {
		varname = "lab_tableNum",
	},
	-- 12:12
	["lab_clock"] = {
		varname = "lab_clock",
	},
	["node_battery2"] = {
		varname = "node_battery2",
	},
	["img_batteryBg2"] = {
		varname = "img_batteryBg2",
	},
}


function cls:ctor()
	cls.super.ctor(self)
end

function cls:onEnter()
	-- 监听对局开始的消息

	-- 获取玩家头像信息
end

function cls:onExit()
end

function cls:updateUI()
	if User:isGameStart() then -- 如果对局已经开始
		self:showPlayView()
	else
		self:showReadyView()
	end
end

function cls:showReadyView()
	if self.view then
		self.view:remove()
		self.view = nil
	end

	self.view = require("app.views.game.ReadyView").new()
	self.view:updateUI()
	self.view:addTo(self)
end

function cls:showPlayView()
	if self.view then
		self.view:remove()
		self.view = nil
	end
	self.view = require("app.views.game.PlayView").new()
	self.view:updateUI()
	self.view:addTo(self)
end



return cls
