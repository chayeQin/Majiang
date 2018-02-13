--
-- Author: lyt
-- Date: 2016-11-23 18:43:44
-- 切换账号列表
local cls = class("BindList", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/BindList.csb"

cls.RESOURCE_BINDING = {
	["panel_list"] = {
		varname = "panel_list",
	},
	-- Text Label
	["lang_szjmBdzh"] = {
		varname = "lang_szjmBdzh",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
	-- 1.绑定后,你可以通过平台账号登陆游戏为。2.你可以在不同设备上，登陆已绑定的游戏进度。
	["lang_szjmBdzhts"] = {
		varname = "lang_szjmBdzhts",
	},
}

local CELL_SIZE = cc.size(610, 70)

function cls:ctor(bindUser)
	self.bindUser = bindUser
	cls.super.ctor(self)
	Util:touchLayer(self)

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
	local node = display.newNode():size(CELL_SIZE)
	local sdkId = PlatformInfo:bindUserId(data.name)
	local lang = nil
	local bg = nil
	if sdkId and sdkId ~= "" then
		lang = "szjmJcbdmz"
		bg = "button/btn_37"
		node.isBind = true
	else
		lang = "szjmBdzhmz"
		bg = "button/btn_36"
		node.isBind = false
	end

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
		if node.isBind then
			Msg.createMsg(Lang:find("szjmKsxyx3"), function()
				BindUtil:unbind(node.data.name, function()
					if not tolua.isnull(self) then
						self.listView:update(BindConfig.SDKS)
						self.bindUser:showTips()
					end
				end)
			end, function()end)
		else
			BindUtil:bind(node.data, function()
				if not tolua.isnull(self) then
					self.listView:update(BindConfig.SDKS)
					self.bindUser:showTips()
				end
				self:btn_closeHandler()
			end)
		end
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