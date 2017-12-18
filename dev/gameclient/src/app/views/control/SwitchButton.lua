--
-- @brief 
-- @author: qyp
-- @date: 2016/08/09
--

local cls = class("SwitchButton", cc.Node)

function cls:ctor(maskSp, onSp, offSp, thumbSp, rhand)
	self.rhand = rhand
	local mask = Util:sprite(maskSp):addTo(self)
	self.node = display.newNode():addTo(self)
	local onSprite = Util:sprite(onSp):anchor(1, 0.5):addTo(self.node)
	local offSprite = Util:sprite(offSp):anchor(0, 0.5):addTo(self.node)
	local thumbSprite = Util:sprite(thumbSp):addTo(self.node)
	self.mask = mask
	self.onSprite = onSprite
	self.offSprite = offSprite
	self.thumbSprite = thumbSprite
    self:onTouch(handler(self, self.onTouchHandler), nil, true)
    self:setOn(true)
end

function cls:setOn(boo, isAni)
	self.on = boo
	local toPos = boo and cc.p(self.mask:width()/2 - self.thumbSprite:width()/2, self.thumbSprite:y()) 
					 or cc.p(-self.mask:width()/2 + self.thumbSprite:width()/2, self.thumbSprite:y())
	local _ = boo and self.onSprite:show() and self.offSprite:hide() or self.onSprite:hide() and self.offSprite:show()
	if isAni then
		self.node:stopAllActions()
		self.node:run{"moveto", 0.2, toPos}
	else
		self.node:pos(toPos)
	end
	if self.rhand and self:isRunning() then
		self.rhand(self.on, self)
	end
end

function cls:isOn()
	return self.on
end

function cls:onTouchHandler(event)
	local np = self:convertToNodeSpace(cc.p(event.x, event.y))
	local size =  self.mask:size()
	local rect = cc.rect(-size.width/2, -size.height/2, size.width, size.height)
	if event.name == "began" then
		if cc.rectContainsPoint(rect, np) then
			return true
		end
	elseif event.name == "ended" then
		if cc.rectContainsPoint(rect, np) then
			self:setOn(not self.on)
		end
		
	end
end

return cls
