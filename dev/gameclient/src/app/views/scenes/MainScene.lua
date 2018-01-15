--
--@brief: 主场景
--@author: qyp
--@date: 2016/02/20
--

-- 因为多点触摸的问题， 要放弃界面缓存， 其他界面会的触摸事件会屏蔽多点触摸
local cls = class("MainScene", BaseScene)

local HEART_BEAT_KEY = "HEART_BEAT"

function cls:ctor(...)
	cls.super.ctor(self, ...)
    require("app.views.game.MainView").new()
        :addTo(self)
	self:enableNodeEvents()
end

function cls:onEnter()
	cls.super.onEnter(self)

end

function cls:onExit()
    cls.super.onExit(self)
end

return cls
