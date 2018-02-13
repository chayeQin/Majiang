--
-- Author: lyt
-- Date: 2017-03-07 17:12:44
-- 测试SOCKET 连接
local cls = class("TestClient")

cls.TIME_OUT = 3 -- 超时时间(秒)

function cls:ctor(ip, port, rhand)
	self.ip    = ip
	self.port  = port
	self.rhand = rhand
	self.isOk  = false

	self:start()
end

function cls:start()
	self.tcp = socket.tcp()
	self.tcp:settimeout(0)
	self.tcp:connect(self.ip, self.port)
	self.time = socket.gettime()

	self.loop = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.tickHandler), 1 / 60, false)
end

function cls:tickHandler()
	local now = socket.gettime() - self.time
	local arr = {self.tcp}
	local r, s, e = socket.select(arr, arr or nil, 0)
	if s and #s >= 1 and s[1] == self.tcp then   -- 连接成功
		print(string.format("*** 连接%s:%s成功, 耗时%s秒", self.ip, self.port, now))

		-- 发送数据测试
		local recvData, recvError, recvParticialData = self.tcp:receive(99999999)
		self.tcp:send("{}")

	    if recvError == 'closed' or now > cls.TIME_OUT then
	    	print("*** 等待数据超时",self.ip, self.port)
	    	self.tcp:close()
			self:callback()

	    elseif recvData or recvParticialData then
			print(string.format("*** 接收数据%s:%s成功, 耗时%s秒", self.ip, self.port, now))
	    	self.time = now
			self.isOk = true
	    	self.tcp:close()
	    	self:callback()
	    end

	elseif now > cls.TIME_OUT then  -- 连接超时
    	print("*** 连接失败",self.ip, self.port)
    	self.tcp:close()
		self:callback()
	end
end

function cls:callback()
	if not self.loop then
		return
	end

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loop)
	self.loop = nil

	if not self.rhand then
		return
	end
	self.rhand(self)
end

return cls