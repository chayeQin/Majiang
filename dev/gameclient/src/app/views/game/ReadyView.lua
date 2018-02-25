--
--@brief: 准备界面
--@author: qyp
--@date: 2017/12/24
--

local cls = class("ReadyView", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/ReadyView.csb"

cls.RESOURCE_BINDING = {
	["btn_dismiss"] = {
		varname = "btn_dismiss",
		method = "btn_dismissHandler",
	},
	["btn_invite"] = {
		varname = "btn_invite",
		method = "btn_inviteHandler",
	},
}



function cls:ctor()
	cls.super.ctor(self)
	self:enableNodeEvents()
end

function cls:onEnter()
end

function cls:onExit()
end

function cls:updateUI()
end

return cls
