--
-- @brief 加入房间
-- @author myc
-- @date 2017/12/19
--

local cls = class("JoinRoom",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/JoinRoom.csb"

cls.RESOURCE_BINDING = {
	["btn_delete"] = {
		varname = "btn_delete",
		method = "btn_deleteHandler",
	},
	["btn_reset"] = {
		varname = "btn_reset",
		method = "btn_resetHandler",
	},
	["btn_num_0"] = {
		varname = "btn_num_0",
		method = "btn_numHandler",
	},
	["btn_num_9"] = {
		varname = "btn_num_9",
		method = "btn_numHandler",
	},
	["btn_num_8"] = {
		varname = "btn_num_8",
		method = "btn_numHandler",
	},
	["btn_num_7"] = {
		varname = "btn_num_7",
		method = "btn_numHandler",
	},
	["btn_num_6"] = {
		varname = "btn_num_6",
		method = "btn_numHandler",
	},
	["btn_num_5"] = {
		varname = "btn_num_5",
		method = "btn_numHandler",
	},
	["btn_num_4"] = {
		varname = "btn_num_4",
		method = "btn_numHandler",
	},
	["btn_num_3"] = {
		varname = "btn_num_3",
		method = "btn_numHandler",
	},
	["btn_num_2"] = {
		varname = "btn_num_2",
		method = "btn_numHandler",
	},
	["btn_num_1"] = {
		varname = "btn_num_1",
		method = "btn_numHandler",
	},
	-- 1
	["lab_num_6"] = {
		varname = "lab_num_6",
	},
	-- 1
	["lab_num_5"] = {
		varname = "lab_num_5",
	},
	-- 1
	["lab_num_4"] = {
		varname = "lab_num_4",
	},
	-- 1
	["lab_num_3"] = {
		varname = "lab_num_3",
	},
	-- 1
	["lab_num_2"] = {
		varname = "lab_num_2",
	},
	-- 1
	["lab_num_1"] = {
		varname = "lab_num_1",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
}

local MAX_ROOM_NUM = 6

function cls:onCreate()
	PopupManager:push(self)
	Util:touchLayer(self)
	self.numList = {}
	self:updateRoomNum()
end

function cls:updateRoomNum()
	for index = 1,MAX_ROOM_NUM do
		local target = self["lab_num_" .. index]
		if not target then return end
		target:setString(self.numList[index] or "")
	end
end

function cls:insertNum(num)
	if #self.numList >= MAX_ROOM_NUM then
		return
	end
	num = checknumber(num)
	table.insert(self.numList,num)
	self:updateRoomNum()
	if #self.numList >= MAX_ROOM_NUM then
		self:checkEnterRoom()
	end
end

function cls:btn_numHandler(target)
	local number = 0
	for i = 0,9 do
		if target == self["btn_num_" .. i] then
			number = i
			break
		end
	end
	self:insertNum(number)
end

function cls:btn_resetHandler(target)
	self.numList = {}
	self:updateRoomNum()
end

function cls:btn_deleteHandler(target)
	if #self.numList > 0 then
		table.remove(self.numList,#self.numList)
	end
	self:updateRoomNum()
end

function cls:checkEnterRoom()
	if #self.numList < MAX_ROOM_NUM then
		return
	end
	local roomNum = table.concat(self.numList)
	print("房间号为:" .. roomNum)
	GameProxy:joinRoom(roomNum)
	PopupManager:popView(self)
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

return cls