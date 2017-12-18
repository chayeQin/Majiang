--
-- Author: lyt
-- Date: 2017-03-07 14:56:54
-- 测试HTTP返回速度
local cls = class("TestHttp")

cls.MAX_TIME   = 3000 -- 3秒,PC上大约3.6秒固定值,
cls.DEFULA_STR = "yhbz_game" -- 默认测试时验证文本

-- 返回自己
function cls:ctor(url, rhand, maxTime, isDefault)
	self.url       = url
	self.rhand     = rhand
	self.maxTime   = maxTime or cls.MAX_TIME
	self.data      = nil
	self.isDefault = isDefault -- 默认测试地址
	self:start()
end

function cls:start()
	self.time = socket.gettime()
	Http.load(self.url,
	    handler(self,self.loadRhand),
	    false,
	    handler(self,self.loadFhand),
	    nil,
	    false,
	    nil,
	    nil,
	    self.maxTime)
end

function cls:loadRhand(str, req)
	if not self.isDefault or str == cls.DEFULA_STR then
		self.data = str
		self.req  = req
		self.time = socket.gettime() - self.time
	end
	self:callback()
end

function cls:loadFhand()
	self:callback()
end

function cls:callback()
	if not self.rhand then
		return
	end

	self.rhand(self)
end

-- 默认测试
function cls.test(base, rhand)
	local url  = Lang:format(URLConfig.FORMAT_TEST, base)
	return cls.new(url, rhand, nil, true)
end

return cls