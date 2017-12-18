--
-- @brief 
-- @author: qyp
-- @date: 2016/11/24
--

local cls = class("GMUtil")

--@brief gm工具
function cls:oneKeyUpgrade(plotId, buildingType, lv, callback)
	if PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.age_lv) < #db.DCivilization then
		local count = #db.DCivilization - PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.age_lv)
		Util:gm(Const.TData.TPropCannot, Const.TPropCannot.age_lv, count)
	end

	local building = BuildingModel:getBuilding(buildingType)
	if plotId then
		building = BuildingModel:getBuildingByPlotId(plotId)
	end

	if building and building.lv >= lv then
		if callback then
			callback()
		end
		return true
	end


	local function doUpgrade()
		if not building then -- 如果未建造，则查找空地块建造

			local dbData = db.DBuildConfig_type_lv_map[buildingType][1]
			local requireLst = Util:getBuildingUpgradeRequire(dbData)
			local preBuilding = nil
			local ageLv = nil
			for _, v in ipairs(requireLst) do
				if v.type == Const.TData.TBuild then
					local buildingInfo = BuildingModel:getBuilding(v.id)
					if not buildingInfo or buildingInfo.lv < v.count then
						preBuilding = v
						break
					end
				end
			end


			-- 前置建筑要求
			if preBuilding then
				self:oneKeyUpgrade(nil, preBuilding.id, preBuilding.count, function()
					self:oneKeyUpgrade(plotId, buildingType, lv, callback)
				end)
			else
				local emptyPlot = nil
				for i = 1, 100 do
					local v = db.DPlot[i]
					if v and v.type == dbData.plotType and not BuildingModel:getBuildingByPlotId(v.id) then
						emptyPlot = v.id
						break
					end
				end
				if not emptyPlot then
					print("没有查找到空地块")
					return false
				end
				local immCost = AlgoUtil:immediatelyUpgradeCost(nil, buildingType)
				print("立即升级需要的钻石", immCost)
				print("背包拥有的钻石", PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel))
				if PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel) < immCost then
					Net:call(function(v, msg)
						if v.error ~= 0 then
							return 
						end
						Util:tick(function()
							self:oneKeyUpgrade(plotId, buildingType, lv, callback)
						end)
					end, "gm", "sendItem", User.info.uid,Const.TData.TPropCannot, Const.TPropCannot.jewel, 1000000)
				else
					Net:call(function(v, msg)
						if v.error ~= 0 then
							return
						end
						PackModel:update(v.result[1])
						BuildingModel:update(v.result[2])
						self:oneKeyUpgrade(plotId, buildingType, lv, callback)
					end, "MainCity", "immediatelyBuild", User.info.uid, tostring(emptyPlot), buildingType)
				end
			end
		elseif building.lv < lv then
			local nxtLvData = db.DBuildConfig_type_lv_map[building.type][building.lv+1]
			if not nxtLvData then
				return
			end
			local requireLst = Util:getBuildingUpgradeRequire(nxtLvData)
			local preBuilding = nil
			for _, v in ipairs(requireLst) do
				if v.type == Const.TData.TBuild then
					local buildingInfo = BuildingModel:getBuilding(v.id)
					if not buildingInfo or buildingInfo.lv < v.count then
						preBuilding = v
						break
					end
				end
			end

			-- 前置建筑要求
			if preBuilding then
				self:oneKeyUpgrade(nil, preBuilding.id, preBuilding.count, function()
					self:oneKeyUpgrade(plotId, building.type, lv, callback)
				end)
			else
				local plotId = tostring(building.typeId)
				local immCost = AlgoUtil:immediatelyUpgradeCost(plotId)
				print("立即升级需要的钻石", immCost)
				print("背包拥有的钻石", PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel))
				if PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel) < immCost then
					Net:call(function(v, msg)
						if v.error ~= 0 then
							return 
						end
						Util:tick(function()
							self:oneKeyUpgrade(plotId, building.type, lv, callback)
						end)
					end, "gm", "sendItem", User.info.uid,Const.TData.TPropCannot, Const.TPropCannot.jewel, 1000000)
				else
					Net:call(function(v, msg)
						if v.error ~= 0 then
							return
						end
						
						PackModel:update(v.result[1])
						BuildingModel:update(v.result[2])
						self:oneKeyUpgrade(plotId, building.type, lv, callback)
					end, "MainCity", "immediatelyUpgrade", User.info.uid, plotId)
				end
			end
		end
	end
	doUpgrade()
	-- Net:call(function(v, msg)
	-- 	if v.error ~= 0 then
	-- 		return
	-- 	end

	-- 	local count = v.result
	-- 	local clientCount = PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel)
	-- 	if clientCount ~= count then
	-- 		print("服务端客户端数据不一致", clientCount, count)
	-- 	else
	-- 		doUpgrade()
	-- 	end
	-- end, "Player", "getItemCount", User.info.uid, Const.TData.TPropCannot, Const.TPropCannot.jewel)
end

function cls:allBuildMaxLv()
	for buildType, _ in pairs(db.TBuild) do
		local tmp = BuildingModel:getBuilding(buildType)
		if tmp then
			local currLv = tmp.lv
			local maxLv = #db.DBuildConfig_type_lv_map[buildType]
			local c = maxLv - currLv
			if c > 0 then
				Util:gm(Const.TData.TBuild, buildType, c)

				Net:call_(function(v, msg)
					if v.error ~= 0 then
						return
					end

					local newBuildInfo = v.result
					if not newBuildInfo then -- 删除建筑
						BuildingModel:remove(tmp.typeId)
					else
						BuildingModel:update(newBuildInfo)	
					end
					self:allBuildMaxLv()
				end, "DataInfo", "getBuild", User.info.uid, tmp.typeId)
				break
			end
		else
			local buildCfg = db.DBuildConfig_type_lv_map[buildType][1]
			local plotId = CityCtrl:getEmptyPlot(buildCfg.plotType)
			if plotId then
				self:oneKeyUpgrade(plotId, buildType, 1, handler(self, self.allBuildMaxLv))
				break
			end
		end
	end
end

--@brief gm工具
function cls:gmDoTask()
	local showTask = TaskModel:getShowTask()
	local taskDb = db.DMainTask[showTask.taskId]
	if TEST_GM_TASK_ID == showTask.taskId then
		return
	end
	if taskDb.taskType == 5 then --建造任务
		local buildingType = taskDb.needId
		local building = nil
		local buildingLst = BuildingModel:getBuildingByType(buildingType)
		local immCost = 0
		local buildingCount = 0
		for _, v in pairs(buildingLst) do
			if v.lv < taskDb.needLv then
				building = v
			else
				buildingCount = buildingCount + 1
			end
		end
		local upgradeFunc = function()end
		if buildingCount >= taskDb.needCount then -- 可以完成任务
			Net:call(function(v, msg)
				if v.error ~= 0 then
					return
				end
				if v.result then
					if  v.result[1] then
						local rewards = PackModel:update(v.result[1], 1)
					else
						dump(taskDb, "*****没法完成任务")
						return
					end

					TaskModel:updateTask(v.result[2])
					self:gmDoTask()
				end
			end, "Task", "gainMainReward", User.info.uid, showTask.typeId)
			return
		elseif not building then
			immCost = AlgoUtil:immediatelyUpgradeCost(nil, buildingType)
			local plotType = db.DBuildConfig_type_lv_map[buildingType][1].plotType
			local plotId = CityCtrl:getEmptyPlot(plotType)
			upgradeFunc = function ()
				Net:call(function(v)
					if v.error ~= 0 then
						return
					end
					PackModel:update(v.result[1])
					BuildingModel:update(v.result[2])
					self:gmDoTask()
				end, "MainCity", "immediatelyBuild", User.info.uid, tostring(plotId), buildingType)
			end
		else -- 升级建筑
			local plotId = checknumber(building.typeId)
			immCost = AlgoUtil:immediatelyUpgradeCost(plotId)
			upgradeFunc = function ()
				Net:call(function(v, msg)
					if v.error ~= 0 then
						return
					end
					
					PackModel:update(v.result[1])
					BuildingModel:update(v.result[2])
					self:gmDoTask()
				end, "MainCity", "immediatelyUpgrade", User.info.uid, tostring(plotId))
			end
		end

		if PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel) < immCost then
			Net:call(function(v, msg)
				if v.error ~= 0 then
					return 
				end
				upgradeFunc()
			end, "gm", "sendItem", User.info.uid,Const.TData.TPropCannot, Const.TPropCannot.jewel, 1000000)
		else
			upgradeFunc()
		end

	end
end

function cls:onkeyAllSoldier()
	for _, v in pairs(db.TForceType) do
		Util:gm(Const.TData.TForce, v.id, 10000000)
	end
end

function cls:settingBattlePoint(pointId)
	Net:call(function (v)
		if v.error ~= 0 then
			return
		end
		local data = {}
		data[1] = v.result[1]
		data[2] = v.result[2]
		BattleModel:init(data)
		BattleModel:initUpdatePointMap(v.result[3])
	end,"gm","settingBattle",User.info.uid,pointId)
end

function cls:settingBattleElitePoint(pointId)
	Net:call(function (v)
		if v.error ~= 0 then
			return
		end
		local data = {}
		data[1] = v.result[1]
		data[2] = v.result[2]
		EliteBattleModel:setInfo(data[1])
		EliteBattleModel:updateChapterLst(data[2])
	end,"gm","settingEliteBattle",User.info.uid,pointId)
end


return cls
