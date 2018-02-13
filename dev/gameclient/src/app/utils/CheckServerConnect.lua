--
-- Author: qyp
-- Date: 2017/02/17
--

local cls = class("CheckServerConnect")

local KEY = "CheckServerConnect"

local LOOP_KEY = "LOOP_KEY"

cls.CHECK_TIME    = 60 * 3 -- X分钟检查一次
cls.TRY_MAC_COUNT = 2 -- X次都慢就换

function cls:ctor()
	self.tryCount = 0
end

function cls:stop()
	print("*********CheckServerConnect:stop")
	GlobalTimer:removeTask(LOOP_KEY)
	GlobalTimer:removeTask(KEY)
	self.tryCount = 0
	self.ipLst = nil
end

function cls:next()
	print("*********CheckServerConnect:next")
	if not self.ipLst then
		return
	end

	self.ipIndex = #self.ipLst
	local func = handler(self, self.finish)
	for k,data in ipairs(self.ipLst) do
		local client = TestHttp.test(data.ip, func)
		client.index = k
	end
end

function cls:finish(client)
	print("*** CheckServerConnect测试SOCKET:", client.index, client.time)
	if not self.ipLst or self.ipIndex < 1 then
		return
	end

	self.ipIndex = self.ipIndex - 1

	local index = client.index
	if client.req then
		self.ipIndex = 0
	else
		if self.ipIndex > 0 then
			return
		end

		print("*** 测试SOCKET失败,使用第一个IP")
		index = 1
	end

	print("*********CheckServerConnect:finish")
	local addr  = self.ipLst[index]
	local value = addr.ip .. ":" .. addr.port
	local old   = Util:load(Const.SAVE_IP_KEY)
	if old ~= value then
		self.tryCount = self.tryCount + 1
		print("*** 新IP最快:", value, self.tryCount)
		if self.tryCount >= cls.TRY_MAC_COUNT then
			print("*** 使用新IP:", value)
			Util:save(Const.SAVE_IP_KEY, value)
			self.tryCount = 0
		end
	else
		print("*** 旧IP最快:", old)
		self.tryCount = 0
	end
	GlobalTimer:removeTask(KEY)

	GlobalTimer:scheduleTask(LOOP_KEY, handler(self, self.start), cls.CHECK_TIME, false)
end

function cls:start()
	-- print("*******CheckServerConnect:start")
	-- self.ipLst = TestServerUtil:getIpList()
	-- self:next()
end

return cls