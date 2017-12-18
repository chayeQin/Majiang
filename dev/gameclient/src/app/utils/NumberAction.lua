--
-- Author: lyt
-- Date: 2017-04-06 17:17:19
-- 数字跳动效果
local cls = class("NumberAction")

cls.TICK_TIME = 1/30

-- format = true 则使用千分符，字符串则用来格式化
-- 数值变化时回调
function cls:ctor(lab, value, format, time, updateHandler)
	self.lab           = lab
	self.value         = value or 0
	self.format        = format or "%f"
	self.time          = time or 1
	self.isThousands   = format == true -- 千分符
	self.updateHandler = updateHandler
end

function cls:setValue(value)
	self.targetValue = value
	self:start()
end

function cls:stop()
	if not self.tickNode then
		return
	end

	self.tickNode:remove()
	self.tickNode = nil
end

function cls:start()
	self:stop()

	self.sumTime  = math.ceil(self.time / cls.TICK_TIME)
	self.addValue = (self.targetValue - self.value) / self.sumTime
	self.tickNode = self.lab:schedule(handler(self, self.tickHandler), cls.TICK_TIME)
end

function cls:tickHandler()
	self.sumTime = self.sumTime - 1
	if self.sumTime < 0 then
		self:stop()
		self.value = self.targetValue
	else
		self.value = self.value + self.addValue
	end

	local value = nil
	if self.isThousands then
		value = string.formatnumberthousands(math.round(self.value))
	else
		value = string.format(self.format, self.value)
	end

	self.lab:setString(value)

	if self.updateHandler then
		self.updateHandler(self.value)
	end
end

return cls