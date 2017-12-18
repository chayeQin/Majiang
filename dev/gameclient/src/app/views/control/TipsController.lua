--
-- Author: qyp
-- Date: 2017/05/04
-- Brief: 
--

local cls = class("TipsController", Controller)

local SCHEDULE_KEY =  "TIPS_CONTROLLER"

function cls:ctor()
	cls.super.ctor(self)
	self.tipsQueue = {}
end

function cls:init()
	self.tipsQueue = {}
	GlobalTimer:scheduleTask(SCHEDULE_KEY, handler(self, self.scheduleTips), 1, true)
end

function cls:clear()
	self.tipsQueue = {}
	GlobalTimer:removeTask(SCHEDULE_KEY)
end

function cls:addTips(str)
	table.insert(self.tipsQueue, str)
end

function cls:getNxtTips()
	local msg = self.tipsQueue[1]
	table.remove(self.tipsQueue, 1)
	return msg
end

function cls:scheduleTips()
	local currTips =  appView:getChildByTag(TAGS.Tips)
	if not currTips then
		local msg = self:getNxtTips()
		if msg then
			print("****TipsController*****", msg)
			Tips.show(msg)
		end
	end

end

return cls