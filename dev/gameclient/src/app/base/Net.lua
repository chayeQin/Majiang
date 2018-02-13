--
--@brief 网络模块
--@author qyp
--@date 2015/8/14
--

local cls = class("Net")

cls.MAX_TRY_CONNECT  = 2 -- 最大连接次数
cls.CONNECT_TIME_OUT = 3 -- 连接超时(秒)

function cls:init()
	self:close()
	self.id           = 11  -- 每个请求的唯一id
	self.back         = {} -- 网络返回回调
	self.backLoading  = {} -- 请求对应的loading
end

function cls:connect(ip, port, rhand, fhand)
	print("**** connect :",ip,":",port)
	self.isLogin      = false -- 是否登陆
	self.postId       = 0 -- 正在发送的消息id
	self.postList     = {}-- 等待发送的消息队列
	self.sendSize     = 0
	self.rhand        = rhand
	self.fhand        = fhand
	self.ip           = ip
	self.port         = port
	self.connectTry   = cls.MAX_TRY_CONNECT
	self.sendCount    = 0 -- 发送数据包数量
	self.sendTime     = 0 -- 所有数据包发送接收总时间

	self:closeConnectCheck()
	
	Loading.show()
	disconnect()

	self:closeConnectCheck()
	self.closeConnectCheckLoop = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.checkConnectTimeOut), cls.CONNECT_TIME_OUT, false)

	connect(ip,port)
end

function cls:closeConnectCheck()
	if not self.closeConnectCheckLoop then
		return
	end

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.closeConnectCheckLoop)
	self.closeConnectCheckLoop = nil
end

-- 连接超时
function cls:checkConnectTimeOut()
	disconnect()

	-- 连接失败
	self.connectTry = self.connectTry - 1
	if self.connectTry < 1 then
		print("*** 多次连接未接通", self.ip, self.port)
		self:connectFhand()
		return
	end

	print("*** 连接没返回强制断开再连接:", self.connectTry, self.ip, self.port)
	connect(self.ip, self.port)
end

function cls:connectRhand()
	print("*******connectRhand")
	self:closeConnectCheck()
	Loading.hide()
	local rhand = self.rhand
	self.rhand = nil
	self.fhand = nil


	if rhand then
		if TEST_DEV then
			rhand()
		else
			pcall(rhand)
		end
	end
	Util:event(Event.netConnectSuccess)
end

function cls:connectFhand()
	print("*******connectFhand")
	self:closeConnectCheck()
	Loading.hide(true)
	if self.fhand then
		Util:tick(self.fhand, 0)
		self.rhand = nil
		self.fhand = nil
		return
	end

	if User and User.isInitFinished then
		HeartBeatUtil:reconnect()
		print("*** 已经登录完成,直接重连接!")
	else
		HeartBeatUtil:showMsg("")
		print("*** 未登录完成,重新进游戏")
	end
	Util:event(Event.netConnectFail)
end

-- 重连
function cls:reconnect()
	app:restart()
end

function cls:close()
	print("**** net:close")
	self:closeConnectCheck()
	InitUser:stop()
	HeartBeatUtil:stop()
	CheckServerConnect:stop()
	
	self.id             = 11  -- 每个请求的唯一id
	self.back           = {} -- 网络返回回调
	self.backLoading    = {} -- 请求对应的loading
	self.isLogin        = false -- 是否登陆
	self.postId         = 0 -- 正在发送的消息id
	self.postList       = {}-- 等待发送的消息队列
	self.sendSize       = 0
	self.rhand          = nil
	self.fhand          = nil
	
	Loading.hide(true)
	disconnect()
end

-- 支持直接回调的
-- 有loading...
function cls:call(func,bean,method,...)
	Loading.show()
	local id = self:send(bean,method,...)
	if id == nil then 
		print("*** call id is nil")
		Loading.hide()
		return 
	end
	-- print("........back id", id)
	self.back[id] = func
	self.backLoading[id] = true
end

-- 支持直接回调的
function cls:call_(func,bean,method,...)
	local id = self:send(bean,method,...)
	if id == nil then 
		print("*** call_ id is nil")
		return 
	end
	self.back[id] = func
end

-- "{'bean':'user',
-- 'id':'829d9c2df60734e95aafd8cc1b014c670',
-- 'method':'login',
-- 'params':['admin','111111'],
-- 'session':'汉字测试传输',
-- 'sign':'a6ad90e4c80104280574dac08c19a124',
-- 'time':1385448054}
function cls:send(bean,method,...)
	if not self:isConnect() then
		HeartBeatUtil:reconnect()
		return
	end

	self.id = self.id + 1
	if self.id > 10000 then
		self.id = 11
	end
	local msg = {}
	msg.i = self.id
	msg.b = bean
	msg.m = method
	msg.p = {...}
	-- msg.t = Util:time()
	-- msg.s= Crypto.md5(URLConfig.GAME_KEY .. bean .. method .. msg.t)

	-- 缓存数据，等下次返回后才提交数据
	table.insert(self.postList, msg)

	-- 没有消息正在发送
	if self.postId == 0 then
		self:doPost()
	end

	return msg.i
end

-- 提交数据
function cls:doPost()
	if #self.postList < 1 then
		self.postId = 0
		print("没有可提交的列表")
		return
	end

	if isConnect() then
		local msg = self.postList[1]
		table.remove(self.postList,1)
		self.postId = msg.i
		print("*****send msg", msg)
		self:socketSend(msg)
	else-- 网络已经断开，重新连接
		print("网络已经断开，重新连接")
		self:close()
	end
end

function cls:socketSend(msg)
    local str = json.encode(msg)
	if device.platform == "windows" then
		print("*** send",str)
	elseif DEBUG ~= 0 then
		print("*** send",str)
	end
	-- 增加发送时间
	self.lastSendTime = socket.gettime()
	self.sendSize = self.sendSize + send(str)
end

function cls:isConnect()
	return isConnect()
end

function cls:recv(v)
	HeartBeatUtil:resetBeatSendTime()
	v = json.decode(v)
	self.lastReceivedMsg = v -- 最后接收到的消息
	if v.t ~= 0 then -- 0：普通消息， !=0 推送消息
		local status, msg = xpcall(function()
			NotifyHandler.handleEvent(v, msg)
		end, __G__TRACKBACK__)
		return
	end

	-- if v.t == 100 then -- 出错了
		-- print("ERROR**** receive Msg Error", v.msg)
		-- Util:event(Event.netError, v)
		-- local errorStr = db.TErrorCode[v.error].data
		-- if TEST_DEV then
		-- 	errorStr = "服务端错误提示: " .. errorStr
		-- end

		-- if v.error == 1 or v.error == 2 then
		-- 	if TEST_DEV then

		-- 		Msg.new("开发模式下提示:\n" .. errorStr, handler(self, self.reconnect))
		-- 	end
		-- else
		-- 	if Lang:getLang() ~= "cn" and Lang:getLang() ~= "tw" then
		-- 		errorStr = "[" .. v.error .. "]" .. errorStr
		-- 	end
		-- 	Tips.show(errorStr)
		-- end
	-- end
	
	-- 发送下一条消息
	if self.postId == v.i then
		local time = socket.gettime() - self.lastSendTime
		self.sendCount = self.sendCount + 1
		self.sendTime  = self.sendTime + time

		if DEBUG > 0 then
			print("*** 网络请求:", time)
			print("*** 平均时间:", self.sendTime / self.sendCount)
		end

		self:doPost()
	end

	-- 这个请求是否有show loading
	if self.backLoading[v.i] then
		self.backLoading[v.i] = nil
		Loading.hide()
		if TEST_DEV then
			print(">>>>>loading count", Loading.count())
		end
	end

	-- 正常 call,call_方法调用 
	local func = self.back[v.i]
	self.back[v.i] = nil
	if func then -- 回调
		 -- 防止在回调报错阻塞游戏网络模块
		local status, msg = xpcall(function()
			func(v,msg)
		end, __G__TRACKBACK__)
	end
end

return cls