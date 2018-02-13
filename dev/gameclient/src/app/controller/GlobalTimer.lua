--
-- @brief 全局定时器
-- @author: qyp
-- @date: 2016/03/01
--

local cls = class("GlobalTimer")

function cls:ctor()
	self.scheduleLst = {}
	self:clear()
	cc.exports.GlobalTimerHandle = Scheduler.scheduleGlobal(handler(self, self.update), 0)
end

function cls:setSchedule(key, value)
	if not self.scheduleLst then
		return false
	end

	self.scheduleLst[key] = value

	return true
end

function cls:getSchedule(key)
	if self.scheduleLst then
		return self.scheduleLst[key]
	end

	return nil
end

-- delay 为第二天后延时时间
function cls:setNextDaySchedule(key,callback,delay)
	local date = Util:date("*t")
	date.hour = 0
	date.min = 0
	date.sec = 0
	local time = Util:time(date)
	local nextDay = time + 24 * 60 * 60 + delay
	local delay = nextDay - Util:time()
	print(Util:formatTime(delay).."后执行:"..key)
	self:scheduleTask(key,callback,delay,false)
end

--@param[key] 任务的唯一标识
--@param[callback] 任务执行回调
--@param[delay] 延时
--@param[forever] 是否重复执行
function cls:scheduleTask(key, callback, delay, forever)
	local value = {callback=callback, delay=delay,forever=forever, endTime=os.time()+delay}
	self:setSchedule(key, value)
end

--@param[key] 根据唯一标识删除任务
function cls:removeTask(key)
	self:setSchedule(key, nil)
end

function cls:getTask(key)
	return self:getSchedule(key)
end

function cls:clear()
	if GlobalTimerHandle then
		Scheduler.unscheduleGlobal(GlobalTimerHandle)
		GlobalTimerHandle = nil
	end
	self.scheduleLst = {}
end

--@brief 循环检测执行任务
function cls:update()
	for key, val in pairs(self.scheduleLst) do
		if not Net:isConnect() then
			return
		end
		local now = os.time()
		if now >= val.endTime then
			val.callback()
			if val.forever then
				val.endTime = now + val.delay -- 设定下次执行
			else
				self:removeTask(key) -- 删除任务
			end
		end
	end
end

return cls

