--
-- Author: lyt
-- Date: 2017-01-18 10:33:20
-- 心跳包
local cls = class("HeartBeatUtil")

-- 心跳包回调内容
local RES_LIST = nil

local BEAT_CHECK     = 0.5 -- 断线检查
local BEAT_RECONNECT = 24 * 3600 -- 断线超过多少秒重新登陆
local BEAT_BAG       = 5  -- 心跳包循环间隔
local PAUSE_TIME     = 2 -- 切后台后.暂停x秒
local PAUSE_TIME_OUT = 60 -- 切后台后X秒后直接重登
local PING_TIME      = 60 -- 网络延迟每60秒上传一次

function cls:ctor()
	self.jewelTryCount = 0
	self.lastPingTime = 0
	self.lastBeatBagTime = 0 -- 上次检查心跳时间
end

function cls:stop()
	if not self.loop then
		return
	end

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loop)
	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.loop2)
	self.loop  = nil
	self.loop2 = nil
end

function cls:init()
	if RES_LIST then
		return
	end

	RES_LIST = {

	}
end

function cls:start()
	self:init()

	if self.loop then
		return
	end

	self.beatIndex   = 1 -- 心跳包发送类型
	self.beatSending = false -- 心跳包正在发送
	self.lastTime    = os.time() -- 上次断线检查通过时间
	self.loop        = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.tickHandler), BEAT_CHECK, false)
	self.loop2       = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.beatTickHandler), BEAT_BAG, false)

	-- 恢复钻石查询
	if self.jewelTryCount > 0 then
		self:updateJewel()
	end

	-- 立马发一个心跳包
	self:sendBag()
end

function cls:tickHandler()
	if Net:isConnect() then
		self.lastTime = os.time()
		return
    end

    -- X秒内直接重连
    local dtime = os.time() - self.lastTime
    if dtime < BEAT_RECONNECT then
		print("*** 网络断线TickHandler")
    	self:reconnect()
    	return
    end

    -- 超时直接弹窗提示
    self:showMsg("")
end

function cls:showMsg(v)
	Net:close()
	PostEvent:netclose()
	Msg.createSysMsg(Lang:find("sys_net_lose") .. v, function()
		app:clearModule()
		app:restart()
	end)
end

function cls:reconnect()
	if TEST_DEV then
		Net:close()
		Msg.createSysMsg("测试模式断线!点击重连接!", handler(app, app.restart))
		return
	end

	app:restart()
end

-- 发送心跳包
function cls:beatTickHandler()
	-- 正常判断
	if not Net:isConnect() then
		return
    end

    if not User.info or not User.info.uid then
    	return
    end

	-- 如果心跳机制的定时器是否正式运作
	local time = os.time() - self.lastBeatBagTime
	self.lastBeatBagTime = os.time()
	local min, max = BEAT_BAG - 1, BEAT_BAG + 1
	if time < min or time > max then
		print("*** 心跳检查异常:", min, time, max)
		self:sendBag()
		return
	end

    -- 上次心跳包没回调
    if self.beatSending then
		print("*** 心跳包超时：", time)
		PostEvent:netHeart()
    	self:reconnect()
    	return
    end

    self:sendBag()
end

function cls:sendBag()
	self.beatIndex = self.beatIndex + 1
	if self.beatIndex > #RES_LIST then
		self.beatIndex = 1
	end

	self.beatSending = true
	local data = RES_LIST[self.beatIndex]
    Net:call_(handler(self, self.beatRhand), "User", "heartbeat", User.info.uid, data[1], data[2])
end

function cls:pause()
	if self.pauseTick or not self.loop then
		return
	end

	print("*** 暂停心跳包")
	self:stop()
	self.puaseTime = os.time()
	self.pauseTick = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,self.pauseHander), PAUSE_TIME, false)
end

function cls:pauseHander()
	print("*** 恢复暂停心跳包")
	if not self.pauseTick then
		return
	end

	cc.Director:getInstance():getScheduler():unscheduleScriptEntry(self.pauseTick)
	self.pauseTick = nil

	local time = os.time() - self.puaseTime
	if time > PAUSE_TIME_OUT then
		print("*** 切后台后，超时重登")
		self.puaseTime = os.time() + 3600
		self:reconnect()
		return
	end

	if not Net:isConnect() then
		print("*** 切后台后，网络断线")
		self:reconnect()
		return
    end
    
    self:start()
end

function cls:resetBeatSendTime()
	self.beatSending = false
end

function cls:beatRhand(v)
	self.beatSending = false
	if v.error ~= 0 then
	    return
	end

	Util:initTime(v.result[1], v.result[2]) -- 重新校准时间

	local time = os.time() - self.lastPingTime
	if time > PING_TIME then
		local postData = {
			uid  = User.info.uid,
			sid  = PlatformInfo:getServerId(),
			time = math.floor(Net.sendTime / Net.sendCount * 1000),
		}
		Http.load(URLConfig.FORMAT_PING, nil, false, nil, nil, false, postData)
		self.lastPingTime = os.time()
	end
	
end

-- 更新钻石
function cls:updateJewel(v)
	if not self.loop then
		return
	end

	if v ~= nil then
		self.jewelTryCount = v
	end
    Net:call_(handler(self, self.updateJewelRhand), "User", "heartbeat", User.info.uid, Const.TData.TPropCannot, Const.TPropCannot.jewel)
end

function cls:updateJewelRhand(v)
	if v.error ~= 0 then
	    return
	end

	Util:initTime(v.result[1], v.result[2]) -- 重新校准时间
	local itemInfo = v.result[3]
	local isEvent = false

	if PackModel:getItemCount(itemInfo.type, itemInfo.id) ~= itemInfo.count then
		isEvent = true
	end
	PackModel:setItemCount(itemInfo.type, itemInfo.id, itemInfo.count, itemInfo.safetyCount)

	if isEvent then
		self.jewelTryCount = 0
		Util:event(Event.packUpdate)
	else
		self.jewelTryCount = self.jewelTryCount - 1
	end

	if self.jewelTryCount > 0 then
		Util:tick(handler(self, self.updateJewel), 5)
	end
end

return cls