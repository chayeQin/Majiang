--
-- Author: qyp
-- Date: 2018/01/31
-- Brief: 
--

local cls = class("ChooseOptionCards", cc.load("mvc").ViewBase)

function cls:ctor(optionLst, rhand)
	self.rhand = rhand
 	self.optionLst = optionLst

 	local x = 0
 	local deltaX = 70
 	local groupDeltaX = 15
 	self.cardGroup = {}
 	for i, v in ipairs(optionLst) do
 		self.cardGroup[i] = {}
 		for __,num in pairs(v) do
 			local tmp = Majiang.new(1, num)
		 				:addTo(self)
		 				:pos(x, 0)
		 	table.insert(self.cardGroup[i], tmp)
			x = x + deltaX
 		end

 		x = x + groupDeltaX

 	end

 	self:pos((display.width - x)/2, 100)
	self:onTouch(handler(self, self.onTouchHandler), nil, true)
	PopupManager:push(self)
end

function cls:onTouchHandler(event)
	if event.name == "began" then
		for i, v in ipairs(self.cardGroup) do
			for j, card in ipairs(v) do
				if card.bg:isContain(event.x, event.y) then
					return true
				end
			end
		end
	elseif event.name == "ended" then
		for i, v in ipairs(self.cardGroup) do
			for j, card in ipairs(v) do
				if card.bg:isContain(event.x, event.y) then
					if self.rhand then
						self.rhand(i)
					end
					PopupManager:popView(self)
					return
				end
			end
		end
	end
	
end

return cls
