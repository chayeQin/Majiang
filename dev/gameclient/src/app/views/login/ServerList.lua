--
-- @brief 服务器列表
-- @author: qyp
-- @date: 2016/02/01
--

local SELECT_TAG = 100001

local cls = class("ServerList", cc.Node)

-- 2火爆 1-顺畅 0正常 -1维护中 -2 未开服
function cls:ctor(rhand)
	self.rhand = rhand
	-- local t = Util:sprite9("union/union_item_bg_02",100,25,340,10)
	-- 				:height(512)
	-- 				:addTo(self)
	local listView = ListView.new(500, 320)
						:addTo(self)
						:pos(-250,15)
	listView.cell = handler(self, self.cell)
	listView.callback = handler(self, self.onListViewEvent)
	self.listView = listView
	self.listView:update(PlatformInfo:getServerList())
end

function cls:cell(i,data)
	local node = Util:sprite("login/login_item_01")
						:anchor(0,0)
	Util:systemLabel(data.n,22):addTo(node,2):center()
	node.data_ = data
	return node
end

function cls:onListViewEvent(event)
	if event.name == ListView.SELECT_END_EVENT then
		local cell = event.target
		self:selectCell(cell, cell.data_.t)
	end
end

function cls:selectCell(cell, serverId)
	for _, v in pairs(self.listView.cellLst_) do
		if v and v:getChildByTag(SELECT_TAG) then
			v:removeChildByTag(SELECT_TAG)
		end
	end

	Util:sprite("login/login_item_02")
		:addTo(cell, 0, SELECT_TAG)
		:center()
	PlatformInfo:selectServer(serverId)
	Util:save("last_login_server", serverId)
	if self.rhand then
		self.rhand(serverId)
	end
end


return cls
