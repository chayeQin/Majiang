--
-- @brief 游戏结果
-- @author myc
-- @date 2018/1/31
--

local cls = class("GameResultView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/GameResultView.csb"

cls.RESOURCE_BINDING = {
	["btn_continue"] = {
		varname = "btn_continue",
		method = "btn_continueHandler",
	},
	-- Text Label
	["lab_time"] = {
		varname = "lab_time",
	},
	-- Text Label
	["lab_play"] = {
		varname = "lab_play",
	},
	-- Text Label
	["lab_mj_name"] = {
		varname = "lab_mj_name",
	},
	["node_result_4"] = {
		varname = "node_result_4",
	},
	["lab_total_4"] = {
		varname = "lab_total_4",
	},
	["lab_gang_4"] = {
		varname = "lab_gang_4",
	},
	["lab_hu_4"] = {
		varname = "lab_hu_4",
	},
	["node_result_3"] = {
		varname = "node_result_3",
	},
	["lab_total_3"] = {
		varname = "lab_total_3",
	},
	["lab_gang_3"] = {
		varname = "lab_gang_3",
	},
	["lab_hu_3"] = {
		varname = "lab_hu_3",
	},
	["node_result_2"] = {
		varname = "node_result_2",
	},
	["lab_total_2"] = {
		varname = "lab_total_2",
	},
	["lab_gang_2"] = {
		varname = "lab_gang_2",
	},
	["lab_hu_2"] = {
		varname = "lab_hu_2",
	},
	["node_result_1"] = {
		varname = "node_result_1",
	},
	["lab_total_1"] = {
		varname = "lab_total_1",
	},
	["lab_gang_1"] = {
		varname = "lab_gang_1",
	},
	["lab_hu_1"] = {
		varname = "lab_hu_1",
	},
	["node_mj_4"] = {
		varname = "node_mj_4",
	},
	["node_mj_3"] = {
		varname = "node_mj_3",
	},
	["node_mj_2"] = {
		varname = "node_mj_2",
	},
	["node_mj_1"] = {
		varname = "node_mj_1",
	},
	["node_player4"] = {
		varname = "node_player4",
	},
	["node_player3"] = {
		varname = "node_player3",
	},
	["node_player2"] = {
		varname = "node_player2",
	},
	["node_player1"] = {
		varname = "node_player1",
	},
	["node_result"] = {
		varname = "node_result",
	},
}

local config = require ("app.".. GAME_NAME .. ".CreateRoomConfig")
local resultType = {
	[1] = ["com/com_txt_zm"];
	[2] = ["com/com_txt_hp"];
	[3] = ["com/com_txt_dp"]
}

local fengType = {
	[1] = ["report/report_icon_dong"];
	[2] = ["report/report_icon_nan"];
	[3] = ["report/report_icon_xi"];
	[4] = ["report/report_icon_bei"];
}

function cls:onCreate()
	PopupManager:push(self)
	Util:touchLayer(self)
	self.lab_mj_name:setString("【】")
	self:showResult()
end

function cls:showResult() 
	self.lab_time:setString(Util:date("%Y/%m/%d %H:%M:%S"))
	self:showRule()
	local roomInfo = User:getRoomInfo()
	local gameInfo = User:getGameInfo()
	if not roomInfo.players or not gameInfo.setts or not gameInfo.players then return end
	for _,player in ipairs(roomInfo.players) do
		local playerInfo = player
		local playerCardInfo = nil
		local setts = nil
		for _,v in pairs(gameInfo.players) do
			if player.uid == v.uid then
				playerCardInfo = v
				break
			end
		end
		for _,v in pairs(gameInfo.setts) do
			if v.uid == player.uid then
				setts = v
				break
			end
		end
		if playerCardInfo and setts then
			self:showPlayerInfo(playerInfo,playerCardInfo,setts,
				playerCardInfo.index,playerCardInfo.index == gameInfo.bankerIndex)
		end
	end
end

-- 玩法
function cls:showRule()
	local types = User:getPlayTypes()
	local typeStr = {}
	for _,v in pairs(Util:strSplit(types,",")) do
		local t = checknumber(v)
		if (config.PLAY[t]) then
			table.insert(typeStr,config.PLAY[t].desc)
		end
	end
	self.lab_play:setString(table.concat(typeStr,"\n\n"))
end

-- 显示玩家信息
function cls:showPlayerInfo(playerInfo,playerCardInfo,setts,index,isBanker)
	local iconNode = self["node_player" .. index]
	local icon = PlayerIcon.new(playerInfo.headimgurl)
	-- 当前风
	if fengType[playerCardInfo.index] then
		Util:sprite(fengType[playerCardInfo.index])
			:addTo(icon)
			:pos(icon:width() / 2,icon:height() / 2)
	end
	if isBanker then
		Util:sprite("report/report_icon_zhuang")
			:addTo(iconNode)
			:pos(-80,0)
	end
	if playerCardInfo.listen then
		Util:sprite("majiang/text_27")
			:addTo(icon)
			:pos(-icon:width() / 2,icon:height() / 2)
	end
	-- 牌
	self:showPlayerCard(playerCardInfo,index)
	-- 胡、杠、总计分
	self["lab_hu_" .. index]:setString(setts.score[1] or 0)
	self["lab_gang_" .. index]:setString(setts.score[2] or 0)
	self["lab_total_" .. index]:setString(setts.score[3] or 0)
	-- 结果类型
	if setts.type and resultType[setts.type] then
		Util:sprite(resultType[setts.type])
			:addTo(self["node_result_" .. index])
	end
end

function cls:showPlayerCard(playerCardInfo,index)
	local node = self["node_mj_" .. index]
	local cardLst = playerCardInfo.top
	local x = 0
	local y = 0
	for i, group in ipairs(cardLst) do
		for j,v in ipairs(group) do
			local img = Majiang.new(5, v)
						:addTo(node)
			img:pos(x,y)
			x = x + 32
		end
		x = x + 10
	end
end

function cls:btn_continueHandler(target)
	PopupManager:popView(self)
end

return cls