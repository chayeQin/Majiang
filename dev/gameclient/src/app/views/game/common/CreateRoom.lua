--
-- @brief 创建房间
-- @author myc
-- @date 2018/1/13
--

local cls = class("CreateRoom",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/CreateRoom.csb"

cls.RESOURCE_BINDING = {
	["btn_create"] = {
		varname = "btn_create",
		method = "btn_createHandler",
	},
	["btn_playContent"] = {
		varname = "btn_playContent",
		method = "btn_playContentHandler",
	},
	-- 注:房卡在开始游戏后第一局结算后扣除，提前解散不扣除房卡
	["lab_notice"] = {
		varname = "lab_notice",
	},
	["node_play"] = {
		varname = "node_play",
	},
	-- 玩法选择：
	["node_play.lab_play"] = {
		varname = "lab_play",
	},
	["node_count"] = {
		varname = "node_count",
	},
	-- 房间人数：
	["node_count.lab_count"] = {
		varname = "lab_count",
	},
	["node_round"] = {
		varname = "node_round",
	},
	-- 局数选择：
	["node_round.lab_round"] = {
		varname = "lab_round",
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
local MAX_ROUND = 3
local MAX_COUNT = 3

function cls:onCreate()
	PopupManager:push(self)
	Util:touchLayer(self)
	self:initCheckBox()
end

function cls:initCheckBox()
	self.chkRoundLst = {}
	self.chkCountLst = {}
	self.chkPlayLst = {}
	self.selectedId = 1
	self.selectedPlayIds = {}
	local roomConfig = config.ROOM[self.selectedId]
	if not roomConfig then return end
	local lst = {}
	for i = 1,MAX_ROUND do
		local chk = Util:button("com/com_img_checkboxbg",handler(self,self.selectedRound),nil,
			nil,nil)
		chk.selectedSp = Util:sprite("com/com_img_checkbox")
		chk.selectedSp:addTo(chk):center():hide()
		chk.lab = Util:label("",24)
		chk.lab:addTo(chk):align(display.LEFT_CENTER,chk:width() + 5,chk:height() / 2)
		chk:addTo(self.node_round)
			:align(display.CENTER,170 + (i - 1) * 210 ,0)
		chk.index = i
		table.insert(self.chkRoundLst,chk)
		self:setSelected(chk,roomConfig.roomMode == chk.index)
	end
	for i = 1,MAX_COUNT do
		local chk = Util:button("com/com_img_checkboxbg",handler(self,self.selectedCount),nil,
			nil,nil)
		chk.selectedSp = Util:sprite("com/com_img_checkbox")
		chk.selectedSp:addTo(chk):center():hide()
		chk.lab = Util:label("",24)
		chk.lab:addTo(chk):align(display.LEFT_CENTER,chk:width() + 5,chk:height() / 2)
		chk:addTo(self.node_count)
			:align(display.CENTER,170 + (i - 1) * 210 ,0)
		chk.index = i + 1
		chk.lab:setString(chk.index .. "人")
		self:setSelected(chk,roomConfig.count == chk.index)
		table.insert(self.chkCountLst,chk)
		if (roomConfig.count == chk.index) then
			self:selectedCount(chk)
		end
	end
	local y = 0
	local subLst = Util:convertSubLst(config.PLAY,3)
	for _,v in ipairs(subLst) do
		for i,data in ipairs(v) do
			local chk = Util:button("com/com_img_checkboxbg2",handler(self,self.selectedPlay),nil,
			nil,nil)
			chk.selectedSp = Util:sprite("com/com_img_checkbox2")
			chk.selectedSp:addTo(chk):center(5,5)
			chk.lab = Util:label(data.desc,24)
			chk.lab:setTextColor(Const.COLOR_GREEN)
			chk.lab:addTo(chk):align(display.LEFT_CENTER,chk:width() + 5,chk:height() / 2)
			chk:addTo(self.node_play)
				:align(display.CENTER,170 + (i - 1) * 210 ,y)
			chk.index = data.id
			table.insert(self.selectedPlayIds,data.id)
			table.insert(self.chkPlayLst,chk)
		end
		y = y - 60
	end
	
end

function cls:setSelected(chk,boolean)
	boolean = boolean == true
	chk.selectedSp:setVisible(boolean)
	chk.lab:setTextColor(boolean and Const.COLOR_GREEN or Const.COLOR_GRAY)
end

function cls:selectedRound(chk)
	local roomMode = chk.index
	local roomConfig = config.ROOM[self.selectedId]
	if not roomConfig then return end
	local count = roomConfig.count
	local id = nil
	for _,v in pairs(config.ROOM) do
		if v.count == count and v.roomMode == roomMode then
			id = v.id
		end
	end
	if not id then print("找不到ID") return end
	self.selectedId = id
	for _,v in pairs(self.chkRoundLst) do
		self:setSelected(v,v == chk)
	end
end

function cls:selectedCount(chk)
	local count = chk.index
	local roomConfig = config.ROOM[self.selectedId]
	if not roomConfig then return end
	local roomMode = roomConfig.roomMode
	local id = nil
	for _,v in pairs(config.ROOM) do
		if v.count == count and v.roomMode == roomMode then
			id = v.id
		end
	end
	if not id then print("找不到ID") return end
	self.selectedId = id
	for _,v in pairs(self.chkCountLst) do
		self:setSelected(v,v == chk)
	end
	-- 更新房间模式文本显示
	for _,v in pairs(config.ROOM) do
		if v.count == count and self.chkRoundLst[v.roomMode] then
			self.chkRoundLst[v.roomMode].lab:setString(v.desc)
		end
	end
end

function cls:selectedPlay(chk)
	local index = table.indexof(self.selectedPlayIds,chk.index)
	if index then
		table.remove(self.selectedPlayIds,index)
		self:setSelected(chk,false)
	else
		table.insert(self.selectedPlayIds,chk.index)
		self:setSelected(chk,true)
	end
end

function cls:btn_createHandler(target)
	local roomConfig = config.ROOM[self.selectedId]
	if not roomConfig then return end
	local round = roomConfig.round
	local playStr = table.concat(self.selectedPlayIds,",")
	local count = roomConfig.count
	GameProxy:createRoom(round,playStr,count)
	PopupManager:popView(self)	
end

function cls:btn_playContentHandler(target)
	require("app.views.game.common.PlayContent").new()
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)	
end

return cls