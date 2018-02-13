--
-- Author: lyt
-- Date: 2016-12-21 12:10:27
--
local cls = class("GuangDian", cc.load("mvc").ViewBase)

local Area = require("app.base.Area")

function cls:ctor()
	cls.super.ctor(self)

	local area = GAME_CFG.area or ""
	if area ~= Area.china then
		return
	end

	local text = "抵制不良游戏，拒绝盗版游戏。注意自我保护，谨防受骗上当。适度游戏益脑，沉迷游戏伤身。合理安排时间，享受健康生活。"
	local lab = cc.Label:createWithSystemFont(text, nil, 20)
	lab:addTo(self)
	lab:setPosition(display.cx, 15)
end

function cls:onCreate()
end

return cls