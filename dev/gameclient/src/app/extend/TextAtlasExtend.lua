--
-- Author: lyt
-- Date: 2015-09-23 21:41:07
-- 数字键绑定
-- 以CCS里只需要在"文本"中填写对应的数字
-- 如图片显示是:123456789
-- 则在控件的文本中填:123456789
-- 要使用setValue时就会自动进行绑定
-- 

local cls = ccui.TextAtlas

-- 时间间隔
local ACT_DT = 0.05

function cls:initMap()
	if self.map then
		return
	end

	local map = self:getString()
	self.map = {}
	local len = string.len(map)
	for i = 1,len,1 do
		self.map[string.sub(map,i,i)] = string.char(48 + i)
	end
end

-- 设置时间
function cls:time(v,t)
	if self.value_ == v then return end
	self.value_ = v
	if not t then
		self:value(Util:date("%X",v))
		return self
	end

	local arr = {}
	for i = t,1,-1 do
		local t1 = math.floor(v / math.pow(60,i-1)) % 60
		if i ~= t then
			t1 = string.format("%02d",t1)
		end
		table.insert(arr,t1)
	end

	self:value(table.concat(arr,":"))
	return self
end

function cls:tickNumber()
	local dt = ACT_DT
	if not self or self.value_time_ == nil then
		self:unschedule(self.loop_)
		return
	end

	self.value_time_ = self.value_time_ + dt
	dt = self.value_time_ / self.value_time_sum_
	if dt >= 1 then
		dt = self.value_target_
		self:unschedule(self.loop_)
		self.loop_ = nil
	else
		dt = (self.value_target_ - self.value_start_) * dt + self.value_start_
	end

	self:showNumber(dt)
end

function cls:stop()
	if not self.loop_ then
		return
	end
	self:unschedule(self.loop_)
	self.loop_ = nil
	self:showNumber(self.value_)
end

function cls:showNumber(v)
	if self.show_value_ == v then
		return
	end
	self.show_value_ = v
	local num = v
	if not self.dot and type(v)=="number" then
		num = math.floor(v)
	end
	local len = string.len(num)
	local new = ""
	for i = 1,len,1 do
		local c = self.map[string.sub(num,i,i)]
		if not c then break end
		new = new .. c
	end
	self:setString(new)
end

function cls:getValue()
	return self.value_
end

function cls:setValue(v, easeing)
	self:initMap()
	if v == nil then return self end
	if self.value_ == v then return self end

	self:stop()
	if v and type(v) == "number" and easeing and type(easeing) == "number" then
		self.value_start_ = 0
		if self.value_ and type(self.value_) == 'number' then 
			self.value_start_ = self.value_ 
		end
		self.value_target_ = v
		self.value_time_ = 0
		self.value_time_sum_ = easeing
		self.loop_ = self:schedule(handler(self,self.tickNumber), ACT_DT)
	else
		self:showNumber(v)
	end
	self.value_ = v
	return self
end

return cls