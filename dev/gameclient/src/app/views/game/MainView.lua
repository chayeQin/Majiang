--
--@brief: 
--@author: qyp
--@date: 2017/12/19
--

local cls = class("MainView", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/MainView.csb"

cls.RESOURCE_BINDING = {
	["btn_service"] = {
		varname = "btn_service",
		method = "btn_serviceHandler",
	},
	["btn_playHelp"] = {
		varname = "btn_playHelp",
		method = "btn_playHelpHandler",
	},
	["btn_shop"] = {
		varname = "btn_shop",
		method = "btn_shopHandler",
	},
	["btn_playRecord"] = {
		varname = "btn_playRecord",
		method = "btn_playRecordHandler",
	},
	["btn_activity"] = {
		varname = "btn_activity",
		method = "btn_activityHandler",
	},
	-- 10000
	["lab_id"] = {
		varname = "lab_id",
	},
	["node_icon"] = {
		varname = "node_icon",
	},
	-- name
	["lab_name"] = {
		varname = "lab_name",
	},
	["btn_setting"] = {
		varname = "btn_setting",
		method = "btn_settingHandler",
	},
	["btn_share"] = {
		varname = "btn_share",
		method = "btn_shareHandler",
	},
	["btn_add"] = {
		varname = "btn_add",
		method = "btn_addHandler",
	},
	-- 0
	["lab_cardCount"] = {
		varname = "lab_cardCount",
	},
	["btn_join"] = {
		varname = "btn_join",
		method = "btn_joinHandler",
	},
	["btn_create"] = {
		varname = "btn_create",
		method = "btn_createHandler",
	},
}

function cls:ctor()
	cls.super.ctor(self)
	self:enableNodeEvents()
	PlayerIcon.new():addTo(self.node_icon)
end

function cls:onEnter()
	-- 检测玩家游戏状态
	if User:isInRoom() then -- 如果玩家正在对局中，则进入对局
		Util:tick(function()
			Util:event(Event.gameSwitch, "RoomView")	
		end)
	end
end

function cls:btn_createHandler(target)
	-- require("app.views.game.common.JoinRoom").new()
	
end

function cls:btn_joinHandler(target)
	require("app.views.game.common.JoinRoom").new()
end

function cls:btn_shareHandler(target)
	require("app.views.game.common.ShareView").new()
end

function cls:btn_settingHandler(target)
	require("app.views.game.common.SettingView").new()
end

function cls:btn_playHelpHandler(target)
	require("app.views.game.common.PlayContent").new()
end

function cls:btn_serviceHandler(target)
	Msg.new("")
end

function cls:btn_addHandler(target)
	self:btn_serviceHandler()
end

function cls:btn_activityHandler(target)
	require("app.views.game.common.ActivityView").new()
end

function cls:btn_playRecordHandler(target)
	require("app.views.game.common.PlayRecord").new()
end

function cls:btn_createHandler(target)
	require("app.views.game.common.CreateRoom").new()
end

return cls

