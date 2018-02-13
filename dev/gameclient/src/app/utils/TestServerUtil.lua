--
-- Author: lyt
-- Date: 2017-02-10 10:34:13
-- 测试服务器
local cls = class("TestServerUtil")

function cls:ctor(rhand)
	self.rhand = rhand

	self:gameServerLogin()
end

function cls:getIpList()
	local serverInfo  = PlatformInfo:getServerInfo()
	local server_ip   = serverInfo.i
	local server_port = serverInfo.p
	local list = {}
	local arr1 = string.split(server_ip, ";")
	local arr2 = string.splitInt(server_port, ";")
	for i,ip in ipairs(arr1) do
		local port = arr2[i] or 0
		if ip ~= "" and port > 0 then
			table.insert(list, {ip=ip, port=port})
		end
	end

	return list
end

function cls:gameServerLogin()
	local ips         = self:getIpList()

	if #ips == 0 then
		Msg.createConsumeMsg("没有服务器IP", function()end)
		return
	end

	if TEST_SELECT_SERVER_IP then
		local arr = string.split(TEST_SELECT_SERVER_IP, ":")
		local server_ip = arr[1]
		local server_port = checknumber(arr[2])

		Msg.new("正在使用选择服务器进行游戏：\n" .. PlatformInfo:getServerName() .. "\n" .. TEST_SELECT_SERVER_IP)

		Net:init()
		Net:connect(server_ip, server_port, handler(self, self.connectRhand), handler(self, self.connectFhand))
		return
	end

	if TEST_NO_LOGIN then
		Net:init()
		Net:connect("127.0.0.1", "10001", handler(self, self.noWebLogin))
		return
	end

	-- 测试哪个IP好
	self.ips     = ips
	self:testIp()
end

function cls:testIp()
	self.ipIndex = #self.ips

	if self.ipIndex < 1 then
		Msg.new("没有配置服务器信息")
		return
	end

	if self.ipIndex < 2 then
		local data = self.ips[1]
		local value = data.ip .. ":" .. data.port
		Util:save(Const.SAVE_IP_KEY, value)
		print("*** 使用网络:", value)
		Net:init()
		Net:connect(data.ip, data.port, handler(self, self.connectRhand), handler(self, self.connectFhand))
		return
	end

	local func = handler(self, self.testRhand)
	for k,data in ipairs(self.ips) do
		local client = TestHttp.test(data.ip, func)
		client.index = k
	end
end

function cls:testRhand(client)
	print("*** 测试SOCKET:", client.index, client.time)
	if self.ipIndex < 1 then
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

	local data = self.ips[index]
	local value = data.ip .. ":" .. data.port
	Util:save(Const.SAVE_IP_KEY, value)
	print("*** 使用网络:", value)
	Net:init()
	Net:connect(data.ip, data.port, handler(self, self.connectRhand), handler(self, self.connectFhand))
end

function cls:connectRhand()
	if self.rhand then
		self.rhand()
	end
end

function cls:connectFhand()
	Util:save(Const.SAVE_IP_KEY, "")
	local msg = Msg.createSysMsg(Lang:find("sys_net_lose"), handler(app, app.restart))
	msg:zorder(TAGS.Reconnect)
	msg.isCanClose = false
end

return cls