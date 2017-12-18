--
-- Author: lyt
-- Date: 2015-11-04 15:45:30
--
local cls = class("Random")
local RandomSeed = RandomSeed

function cls:ctor(x,y)
	local len = #RandomSeed
	x = x or 1
	y = y or 1
	x = x % len
	y = y % len

	if x < 1 then
		x = 1
	end

	if y < 1 then
		y = 1
	end

	self.x = x
	self.y = y
	self.count = 0
end

-- 生成一个0~9999的数
function cls:rnd()
	self.count = self.count + 1
	local rnd = RandomSeed[self.x] * 100 + RandomSeed[self.y]
	self.x = self.x + 1
	self.y = self.y + 1
	if self.x > #RandomSeed then
		self.x = 1
	end
	if self.y > #RandomSeed then
		self.y = 1
	end
	return rnd
end

-- 生成min ~ max 数据
function cls:range(min,max)
	min,max = math.min(min,max),math.max(min,max)
	local rnd = self:rnd() / 10000
	return min + math.floor((max - min + 1) * rnd)
end

return cls