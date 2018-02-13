--
-- Author: lyt
-- Date: 2016-07-18 16:10:37
-- LUA 内存记录
local cls = class("LuaMem")

function cls:ctor()
	-- self.list = {}
	self.min = 99999999999
	self.max = 0
	self.value = 0
	self.textureMin = 99999999999
	self.textureMax = 0
	self.textureValue = 0

	self:clear()
end

function cls:check()
	local value = collectgarbage("count") / 1024
	self.min = math.min(value, self.min)
	self.max = math.max(value, self.max)
	self.value = value
	-- table.insert(self.list, value)

	local text = cc.Director:getInstance():getTextureCache():getCachedTextureInfo()
	local index = string.find(text, "for ") + 4
	text = string.sub(text,index)
	index = string.find(text, " ") - 1
	text = string.sub(text,1,index)
	local value2 = checknumber(text) / 1024
	self.textureMin = math.min(value2, self.textureMin)
	self.textureMax = math.max(value2, self.textureMax)
	self.textureValue = value2

	-- print("#######################################################")
	-- print(string.format("###  LUA : %.02fMB min:%.02f max:%.02f",value,self.min,self.max))
	-- print(string.format("### 纹理 : %.02fMB min:%.02f max:%.02f",value2,self.textureMin,self.textureMax))
	-- print("#######################################################")
end

function cls:clear()
	collectgarbage("collect")
end

return cls