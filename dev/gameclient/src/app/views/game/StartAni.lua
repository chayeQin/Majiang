--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

local cls = class("StartAni", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/StartAni.csb"

cls.RESOURCE_BINDING = {
}


function cls:ctor()
	cls.super.ctor(self)
	self:enableNodeEvents()
end

function cls:onEnter()
	self:runTimeline()
	self:run{"seq",
				{"delay", 40/30},
				{"remove"}
	}
end


return cls 