--
-- Author: lyt
-- Date: 2017-03-03 11:46:34
-- 走马灯效果
local cls = class("GoRoundUtil", function()
	return ccui.Layout:create()
end)

cls.TICK = 1 / 30
cls.SPEED = 2

--isBound 是否滚动到末端就回弹
--isCenter node长度小于走马灯时是否居中
function cls:ctor(node, size, isBound, isCenter)
	self:setClippingEnabled(true)
	self:setClippingType(1)
	self:setContentSize(size)

	self.leftX = -node:width()
	self.rightX = size.width

	self.isBound = isBound
	self.node = node
	node:addTo(self)

	if Lang.isRTL then
		local x = size.width - node:width()
		if x < 0 then
			self.node:setPositionX(x)
		end
		self.delta = 1
		self.speed = cls.SPEED
		self.actionX = self.leftX
	else
		self.delta = -1
		self.speed = -cls.SPEED
		self.actionX = self.rightX
	end

	local x =  node:width() - size.width
	if isCenter and x < 0 then
		self.node:setPositionX(math.abs(x)/2)
	end
	self.tickNode = self:schedule(handler(self, self.tickHandler), cls.TICK)
	self:tickHandler()
end

function cls:tickHandler()
	if self.isBound then
		local minX = math.min(-((self.node:width()) - self:width()), 0)
		local maxX = 0

		if minX == maxX then
			return
		end

		local newX = self.node:x() + self.delta*cls.SPEED /2
		self.node:x(newX)
		if newX <= minX - 20 then
			self.delta = 1
		elseif newX >= maxX + 20 then
			self.delta = -1
		end
	else
		self.actionX = self.actionX + self.speed
		if Lang.isRTL then
			if self.actionX > self.rightX then
				self.actionX = self.leftX
				if self.rhand then
					self.tickNode:remove()
					self.tickNode = nil
					self.rhand()
					return
				end
			end
		else
			if self.actionX < self.leftX then
				self.actionX = self.rightX
				if self.rhand then
					self.tickNode:remove()
					self.tickNode = nil
					self.rhand()
					return
				end
			end
		end

		self.node:setPositionX(self.actionX)
	end
end

return cls