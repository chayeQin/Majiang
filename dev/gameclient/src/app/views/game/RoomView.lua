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
	self.viewType = 0

	-- Util:button("com/com_btn_create",function()
	-- 	User.info.uid = "a08r47qbzx0"
	-- 	User:setRoomInfo(Const.testRoomInfo)
	-- 	User:setGameInfo(Const.testGameInfo)
	-- end)
	-- 	:addTo(self, 999)
	-- 	:pos(display.center)
	-- Util:button(nil, function()

	-- end"解散房间")
	-- 	:addTo(self)
	-- 	:pos(300, 300)
end

function cls:onEnter()
	-- 监听对局开始的消息
	print("*****Room view on enter")
	self.roomInfoHandle = Util:addEvent(Event.roomInfoUpdate, handler(self, self.updateUI))
	-- 获取玩家头像信息
end

function cls:onExit()
	Util:removeEvent(self.roomInfoHandle)
end

function cls:updateUI()
	print("******RoomView:updateUI")
	if not User:isInRoom() then -- 房间解散了
		print("*******房间解散了")
		Util:event(Event.gameSwitch, "MainView")
		return
	end
	local isVoting = false
	for _, v in ipairs(User.roomInfo.exitUids) do
		if v == User.info.uid then
			isVoting = false
			break
		else
			isVoting = true
		end
	end

	local voteName = ""
	for _, v in ipairs(User.roomInfo.players) do
		if v.uid == User.roomInfo.exitUids[1] then
			voteName = v.nickname
			break
		end
	end

	if self.exitMsg then
		PopupManager:popView(self.exitMsg)
		self.exitMsg = nil
	end

	if isVoting then
		self.exitMsg = Msg.new(voteName .. "请求解散游戏，是否同意解散?", 
						function()
							self.exitMsg = nil
							GameProxy:dismiss(nil, 1)
						end, 
						function() -- 不同意
							self.exitMsg = nil
							GameProxy:dismiss(nil, 0)
						end)
	end


	self.lab_tableNum:setString("房间号:" .. User:getRoomId())

	if User:isGameStart() then -- 如果对局已经开始
		self:showPlayView()
	else
		self:showReadyView()
	end
end

function cls:showReadyView()
	if self.viewType == 1 then
		self.view:updateUI()
		return
	end
	if self.view then
		self.view:remove()
		self.view = nil
	end


	self.viewType = 1
	self.view = require("app.views.game.ReadyView").new()
	self.view:updateUI()
	self.view:addTo(self)
end

function cls:showPlayView()
	if self.viewType == 2 then
		self.view:updateUI()
		return
	end
	if self.view then
		self.view:remove()
		self.view = nil
	end

	self.viewType = 2
	self.view = require("app.views.game.PlayView").new()
	self.view:updateUI()
	self.view:addTo(self)
end

function cls:btn_rulesHandler(target)
	require("app.views.game.common.RoomRuleView").new()
end

function cls:btn_setttingHandler(target)
	require("app.views.game.common.SettingView").new(false)
end

function cls:btn_chatHandler(target)
	require("app.views.game.common.ChatView").new()
end

function cls:btn_voiceHandler(target)
	require("app.views.game.common.GameResultView").new()
end

return cls
