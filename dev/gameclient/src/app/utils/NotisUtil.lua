--
-- Author: lyt
-- Date: 2016-12-23 10:19:08
-- 推送
local cls = class("NotisUtil")

local eventDispatcher   = cc.Director:getInstance():getEventDispatcher()
local EVENT_NAME_RESUME = "event_come_to_foreground" -- 恢复游戏
local EVENT_NAME_PAUSE  = "event_come_to_background" -- 切后台

function cls:ctor()
    self.listener1 = cc.EventListenerCustom:create(EVENT_NAME_RESUME, handler(self,self.onResume))  
	eventDispatcher:addEventListenerWithFixedPriority(self.listener1, -2)

	self.listener2 = cc.EventListenerCustom:create(EVENT_NAME_PAUSE, handler(self,self.onPause))  
	eventDispatcher:addEventListenerWithFixedPriority(self.listener2, -1)
end

function cls:clear()
	if not self.listener1 then
		return
	end

	eventDispatcher:removeEventListener(self.listener1)
	eventDispatcher:removeEventListener(self.listener2)

	self.listener1 = nil
	self.listener2 = nil
end

-- 使用推送功能
function cls:open(rhand)
	Api:call("JpushInfo", "open", nil, rhand)
	Util:save(Const.OPEN_PUSH_TAG, true)
end

-- 是否开启推送
function cls:check(rhand)
	Api:call("JpushInfo", "check", nil, function(v)
		local result = true
		if v ~= "true" then
			result = false
		end

		if rhand then
			rhand(result)
		end
	end)
end

-- 打开应用推送设置页
function cls:openSet()
	Api:call("JpushInfo", "openSet", nil)
end

-- 恢复
function cls:onResume()
	print("********************* onResume")

	if User and User.info and User.info.uid then
	end
end

-- 切换后台
function cls:onPause()
	print("********************* onPause")

	if User and User.info and User.info.uid then
		self:build()
		self:makeArmy()
		self:research()
		self:onlineGift()
		self:phy()
		self:resource()
		self:equip()
		self:kingdomOpen()
	end
	self:random()
	Sound:unloadSound()
	HeartBeatUtil:pause()

end

-- 升级与打造
function cls:build()
	for k,v in pairs(BuildQueueModel.queues) do
		local build = BuildingModel:getBuildingByPlotId(v.plotId)
		if build then
			build = db.DBuildConfig_type_lv_map[build.type][build.lv]
			if build then
				self:notis(1, v.endTime, build.name .. "Lv." .. (build.lv + 1))
			end
		end
	end
end

-- 制作军队,制作陷阱
function cls:makeArmy()
	local map = {}
	for k, v in pairs(ProductionModel.productionQueues) do
		local id,time,name = 2, v.endTime, Lang:find("jtxq_zj") -- 制作军队
		local key = id .. "_" .. math.floor(time / 30) -- X秒内相同
		local v2 = map[key]
		if not v2 then
			v2 = {}
			v2.id = id
			v2.time = time
			v2.list = {name}
			map[key] = v2
		else
			v2.time = math.max(v2.time, time) -- 取最后一个
		end
	end

	for k,v in pairs(map) do
		local name = table.concat(v.list, ",")
		self:notis(v.id, v.time, name)
	end
end

-- 研究科技
function cls:research()
	local queueLst = ScienceModel:getScienceQueue()
	if not queueLst then return end
	for _,queue in pairs(queueLst) do
		if not queue then
			return
		end

		local science = db.TScience[queue.type]
		if not science then
			return
		end

		science = db[science.key]
		if not science then
			return
		end

		local data = science[queue.id]
		if not data then
			return
		end

		local name = data.name .. "Lv." .. data.lv
		self:notis(4, queue.endTime, name)
	end
end

-- 资源生产
function cls:resource()
	local map = {} -- 不要相同的时间
	for k,v in pairs(ProductionModel.collectionLst) do
		local endTime = v.time + 36000 -- 每样资源上限10倍于自己的产量,所以上次采集时间+10倍时间就可以
		local key = math.floor(endTime / 180) -- 3分钟内只有一个
		if not map[key] then
			self:notis(12, endTime)
			map[key] = true
		end
	end
end

-- 在线奖励
function cls:onlineGift()
	self:notis(13, OnlineGiftModel:getEndTime())
	self:notis(14, 24 * 3600 + Util:time())
end

-- 体力恢复
function cls:phy()
	local physical = PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.physical)
	local physicalmax = db.DLevel[User.info.level].physical
	physical = physical < 0 and 0 or physical
	local endTime = math.ceil((physicalmax - physical) * AlgoUtil:phyRecovery()) + Util:time()

	self:notis(17, endTime)
end

-- 装备制造
function cls:equip()
	if not EquipForgeModel.equipQueue then
		return
	end
	self:notis(19, EquipForgeModel.equipQueue.endTime)
end

-- 随机显示
function cls:random()
	local time = Util:time() - 300 -- 提前5分钟提示
	for i = 1,3 do
		self:notis(-1, time + i * 24 * 3600) -- N天后.随机提示
	end
end

-- 什么时候推送
function cls:notis(id, endTime, ...)
	local data = db.DPushMsg[id]
	local msg = nil
	if data then
		if not SystemSettingInformUtil:check(data.id) then
			return
		end
		
		local lang = Lang:getLang()
		lang       = "desc" .. string.upper(lang)
		msg        = data[lang]
	end

	-- 取不出提示需要
	if not msg then
		msg = Util:randomTips(1)
	else
		msg = Lang:format(msg, ...)
	end

	local time = endTime - Util:time()
	if time < 1 then
		return
	end
	Api:notis(msg, time)
end

function cls:kingdomOpen()
	local activtyData = ActivityModel:getActivityData(Const.TActivityType.Kingdom)
	if not activtyData then
		print("ERROR*** 没有国王活动数据")
		return
	end

	if not activtyData.open then -- 如果是保护状态
		self:notis(21, Util:time() + activtyData.startTime)
	end
end

return cls