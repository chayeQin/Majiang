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


local ICON_POS_MAP = {
	{80, 180},
	{80, display.height/2},
	{300, 680},
	{1220, display.height/2}
}

function cls:ctor()
	cls.super.ctor(self)
	self.viewType = 0
	self.playerNodes = {}
	self.iconNode = display.newNode():addTo(self, 3)
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
	if not User:isInRoom() then -- 房间解散了
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

	self:onPlayersUpdate()
end

function cls:onPlayersUpdate()
	for _, v in ipairs(self.playerNodes) do
		v:remove()
	end
	self.playerNodes = {}

	local indexMap = {}
	local orig = 0
	local sortKey = orig
	-- 找出玩家自己的位置
	for i, v in ipairs(User.roomInfo.players) do
		if v.uid == User.info.uid then
			sortKey = sortKey - 4

			if not v.state then -- 未准备
				GameProxy:ready()
			end
		else
			sortKey = sortKey + 1
		end
		indexMap[i] = {i, sortKey}
	end
	table.sort(indexMap, function(v1, v2)
		return v1[2] < v2[2]
	end)

	local posMap = {}
	if User.info.maxSize == 2 then
		posMap[1] = ICON_POS_MAP[1]
		posMap[2] = ICON_POS_MAP[3]
	else 
		posMap = ICON_POS_MAP
	end

	for i, v in ipairs(indexMap) do
		local posInfo = posMap[i]
		local index = v[1]
		local info = User.roomInfo.players[index]
		local node = PlayerIcon.new(info.headimgurl)
		node:addTo(self)
		node:x(posInfo[1])
		node:y(posInfo[2])
		node:bindUid(info.uid)
		Util:label(info.nickname)
			:addTo(self.iconNode)
			:pos(node:x(), node:y() - 50)
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
	self.view:addTo(self, 2)
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
	self.view:addTo(self, 2)
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
