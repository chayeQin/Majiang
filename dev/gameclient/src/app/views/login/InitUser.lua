--
-- @brief 
-- @author: qyp
-- @date: 2016/02/16
--
local cls = class("InitUser")

local TIME_OUT = 10 -- 整个登录最长时间(秒)

function cls:load(rhand)
	self.rhand     = rhand
	--ModelManager.init()

	User.isInitFinished = false -- 用户初始化开始
	self:initList()
	
	if not cls.isRelogin then
		SDK:post()
		PostEvent:loginStart()
		SDKEvent:loginStart()
	end

	ChatModel:initData()

	self.index = 0
	Net:send("user", "startLogin", User.info.uid)
	Net.postId = -100 -- 不让后面发包
	self.loop = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self, self.timeOut), TIME_OUT, false)
end

function cls:stop()
	if self.loop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loop)
		self.loop = nil
	end
	self.rhand = nil
end

function cls:timeOut()
	if self.loop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loop)
		self.loop = nil
	end

	PostEvent:loginError()

	local msg = "(InitUser)KEY不对或服务端缺返回值:"
	for k,v in pairs(self.callbackTest) do
		msg = msg .. "\n" .. k
	end

	dump(self.callbackTest)
	-- 打印没完成接口
	if TEST_DEV then
		Msg.new(msg)
		return
	else
		postError("InitUser", msg)
	end

	HeartBeatUtil:reconnect()
end

function cls:endRequire()
	if self.loop then
		cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loop)
		self.loop = nil
	end


	User.isInitFinished = true -- 用户初始化完毕
	User.initDataTime = Util:time() -- 用户数据初始化时间

	if not cls.isRelogin then
		PostEvent:loginComplete()
		SDKEvent:loginComplete()
		cls.isRelogin = true
	end

	Net:doPost()

	local rhand = self.rhand
	self.rhand = nil
	Loading.hide(true)
	
	if TEST_DEV then
		rhand()
		HeartBeatUtil:start()
		GVoiceUtil:init()
	else
		Util:tick(function()
			rhand()
			HeartBeatUtil:start()
			GVoiceUtil:init()
		end, 0)
	end
end

function cls:initList()
	if self.callbackMap then
		return
	end
	-- 加载列表,第一个参数是类型,1 socket,2 方法(Model类)
	local list = {
	}

	
	self.callbackMap = {}
	self.callbackTest = {}
	for i = 1, #list, 4 do
		local key = string.upper(list[i] .. "_" .. list[i + 1])
		self.callbackMap[key] = handler(list[i + 2], list[i + 3])
		self.callbackTest[key] = true
		self.sum = self.sum + 1
	end
	self.loadLst = list
end

function cls:loginBlack(data)
	if self.rhand == nil then
		print("*** InitUser:next rhand is nil break!!")
		return
	end

	self.index = self.index + 1
	
	Util:event(Event.loadUserInfo, {index = self.index, sum = sum})

	local key = string.upper(data[1] .. "_" .. data[2])
	local func = self.callbackMap[key]
	self.callbackTest[key] = nil
	if func then
		if TEST_DEV then
			print("*** load ", self.index, self.sum, data[1], data[2])
			func(data[3], data[4], data)
		else
			pcall(func, data[3], data[4])
		end
	else
		print("**** init user 没处理服务器推送消息")
		echo(data)
	end

	if self.index >= self.sum then
		if TEST_DEV then -- GM 命令工具读取用户uid
			io.writefile("LoginUID.txt", User.info.uid)
		end
		self:endRequire()
	end
end


return cls