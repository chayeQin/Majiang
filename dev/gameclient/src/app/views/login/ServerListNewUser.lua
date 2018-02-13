--
-- Author: lyt
-- Date: 2017-02-21 14:42:40
--
local cls = class("ServerListNewUser", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/ServerList.csb"

cls.RESOURCE_BINDING = {
	["node_list"] = {
		varname = "node_list",
	},
	-- 服务器列表..
	["lang_fwqlb_title"] = {
		varname = "lang_fwqlb_title",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
}

function cls:ctor(rhand)
	self.rhand = rhand
	cls.super.ctor(self)

	PopupManager:push(self)
end

function cls:onCreate()
	self.listView = ListView.bind(self, self.node_list)
	self.listView.cell = handler(self, self.cell)
	self.listView.callback = handler(self, self.touchHandler)
	self.listView:update(PlatformInfo:getServerList())
end

function cls:cell(i,data)
	local node = display.newNode():size(626,60)
	node.data = data

	Util:sprite("login/denglu_bg_03"):addTo(node)
		:pos(318, 28)

	Util:systemLabel(data.n,22):addTo(node,1)
		:pos(318, 28)

	return node
end

function cls:touchHandler(event)
	if event.name ~= ListView.SELECT_END_EVENT then
		return
	end

	local data = event.target.data

	if not self.rhand then
		return
	end

	self.rhand(data.t)
end

function cls:btn_closeHandler()
	PopupManager:popView(self)
end

return cls