--
-- @brief 房间规则查看
-- @author myc
-- @date 2018/1/26
--

local cls = class("RoomRuleView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/RoomRuleView.csb"

cls.RESOURCE_BINDING = {
	-- Text Label
	["lab_play"] = {
		varname = "lab_play",
	},
	-- 玩法：
	["lab_play_desc"] = {
		varname = "lab_play_desc",
	},
	-- Text Label
	["lab_count"] = {
		varname = "lab_count",
	},
	-- 人数：
	["lab_count_desc"] = {
		varname = "lab_count_desc",
	},
	-- Text Label
	["lab_round"] = {
		varname = "lab_round",
	},
	-- Text Label
	["lab_round_desc"] = {
		varname = "lab_round_desc",
	},
	["img_play"] = {
		varname = "img_play",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
}

local config = require ("app.".. GAME_NAME .. ".CreateRoomConfig")

function cls:onCreate()
	if not User:isInRoom() then
		return
	end
	Util:touchLayer(self)
	PopupManager:push(self)
	self:updateRule()
end

function cls:updateRule()
	-- 人数
	local maxSize = User:getMaxSize()
	self.lab_count:setString(maxSize .. "人");
	local round = User:getMaxCount()
	if (maxSize >= 4) then
		self.lab_round_desc:setString("圈数：")
		round = math.floor(round / maxSize) .. "圈"
	else
		self.lab_round_desc:setString("场次：")
		round = round .. "场"
	end
	self.lab_round:setString(round)
	-- 玩法
	local types = User:getPlayTypes()
	local typeStr = {}
	for _,v in pairs(Util:strSplit(types,",")) do
		local t = checknumber(v)
		if (config.PLAY[t]) then
			table.insert(typeStr,config.PLAY[t].desc)
		end
	end
	self.lab_play:setString(table.concat(typeStr,"、"))
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

return cls
