--
-- Author: lyt
-- Date: 2016-11-23 18:34:54
--
local cls = class("BindSwitch", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/BindSwitch.csb"

cls.RESOURCE_BINDING = {
	["panel_list"] = {
		varname = "panel_list",
	},
	-- 切换已经绑定的游戏账号
	["lang_szjmQhzhts"] = {
		varname = "lang_szjmQhzhts",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
	-- Text Label
	["lang_szjmQhzh"] = {
		varname = "lang_szjmQhzh",
	},
}

local CELL_SIZE = cc.size(610, 70)

function cls:ctor(bindUser)
	cls.super.ctor(self)
	Util:touchLayer(self)
	self.bindUser = bindUser

	PopupManager:push(self)
end

function cls:onCreate()
	self.listView = ListView.new(self.panel_list:width(), self.panel_list:height(), false)
							:addTo(self.panel_list)
	self.listView.cell = handler(self, self.createCell)
	self.listView.callback = handler(self, self.onListViewEvent)
	self.listView:update(BindConfig.SDKS)
end

function cls:createCell(i, data)
	local node  = display.newNode():size(CELL_SIZE)
	local sdkId = PlatformInfo:bindUserId(data.name)
	local lang  = "szjmQhzhcell"
	local bg    = "button/btn_36"

	local btn = Util:sprite(bg):addTo(node):pos(CELL_SIZE.width/2, CELL_SIZE.height/2)
	Util:sprite(data.icon):addTo(btn):pos(37, 34)

	local name = Lang:find("szjm_" .. data.name)
	local text = Lang:find(lang, name)
	Util:label(text, 22):addTo(btn):pos(200, 35)
	node.data = data
	node.btn = btn

	return node
end

function cls:onListViewEvent(event)
	if event.name == ListView.SELECT_END_EVENT then
		local node = event.target
		BindUtil:switch(node.data)
		node.btn:run{
			"seq",
			{"scaleto", 0, 0.98},
			{"scaleto", 0.1, 1},
		}
	end
end

function cls:btn_closeHandler()
	PopupManager:popView(self)
end

return cls