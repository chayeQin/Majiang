--
-- Author: qyp
-- Date: 2018/01/31
-- Brief: 
--

local cls = class("TingOptionCards", cc.load("mvc").ViewBase)

function cls:ctor()
	cls.super.ctor(self)
	self.optLst = {}
	self:enableNodeEvents()
end

function cls:onEnter()
	self.optionHandle = Util:addEvent(Event.tingOptUpdate, handler(self, self.onOptUpdate))
end

function cls:onExit()
	Util:removeEvent(self.optionHandle)
end

function cls:onOptUpdate(event)
	local optionLst = event.params[1]
	for _, card in pairs(self.optLst) do
		card:remove()
	end

	if not optionLst then
		return
	end

	self.cardGroup = {}
 	local x = 0
 	local deltaX = 86
 	local groupDeltaX = 15
 	for i, num in ipairs(optionLst) do
		local tmp = Majiang.new(1, num)
	 				:addTo(self)
	 				:pos(x, 0)
	 	table.insert(self.cardGroup, tmp)
		x = x + deltaX
 	end
 	self:pos((display.width - x)/2, 120)
end

return cls
