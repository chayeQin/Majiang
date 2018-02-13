--
-- @brief 滑动条
-- @author: qyp
-- @date: 2016/09/05
--

local cls = class("Slider", cc.load("mvc").ViewBase)

-- 兼容C++原生组件的字符串标识
cls.EVENT_PERCENT_CHANGE = "ON_PERCENTAGE_CHANGED"

function cls:ctor(bg, progressbar, ball, callback,width)
	cls.super.ctor(self)
	if width then
		local sp = Util:sprite(bg)
		local sp_bg = Util:sprite9(bg,sp:width()/2,sp:height()/2,10,10)
							:size(width,sp:height())
							:addTo(self)
		self.bg = sp_bg
	else
		self.bg = Util:sprite(bg)
					:addTo(self)
	end
	self.progress = Util:loadBar(progressbar)
						:addTo(self.bg)
						:pos(self.bg:width()/2, self.bg:height()/2)
	self.progress:setCapInsets(cc.rect(self.progress:width() / 3,self.progress:height() / 3,
		self.progress:width() / 3,self.progress:height() / 3))
	self.progress:setScale9Enabled(true)
	local progressWidth = width and (width - 5) or self.progress:width()
	self.progress:setContentSize(cc.size(progressWidth,self.progress:height()))
	self.ball = Util:sprite(ball)
					:addTo(self.bg)
					:y(self.bg:height()/2)
	self.callback = callback
	self.maxPercent = 100
	self:setPercent(self.maxPercent)
	self:size(self.bg:size())
	self:onTouch(handler(self, self.onTouchHandler), nil, true)
	self.touchEnabled = true
end

function cls:setPercent(percent)
	percent = math.max(math.min(percent, self.maxPercent), 0)
	self.percent = percent
	self.progress:setPercent(percent/self.maxPercent*100)
	self.ball:x((self.bg:width()-self.ball:width()) * percent/self.maxPercent+self.ball:width()/2)
end

function cls:getPercent()
	return self.percent
end

function cls:setMaxPercent(maxPercent)
	self.maxPercent = maxPercent
end

function cls:getMaxPercent()
	return self.maxPercent
end

function cls:setTouchEnabled(boolean)
	self.touchEnabled = boolean
end

function cls:onTouchHandler(event)
	local function calPercent(event)
		local np = self.bg:convertToNodeSpace(event)
		local width = self.bg:width()
		local percent = np.x/width* self.maxPercent
		self:setPercent(percent)
		if self.callback then
			self.callback({
				target = self,
				name = cls.EVENT_PERCENT_CHANGE,
				percent = percent
			})
		end
	end
	if event.name == "began" then
		if self.touchEnabled ~= true then return end
		if self.bg:isContain(event.x, event.y) then
			self.isTouchInside = true
			calPercent(event)
			return true
		else
			self.isTouchInside = false
		end
	elseif event.name == "moved" or
		event.name == "ended" then
		if self.isTouchInside then
			calPercent(event)
		end
	end
end

function cls:onEvent(callback)
	self.callback = callback
end

return cls
