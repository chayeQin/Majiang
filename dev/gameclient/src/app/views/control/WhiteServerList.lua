--
-- Author: lyt
-- Date: 2017-02-09 10:17:52
-- 服务器选择列表
local cls = class("WhiteServerList", function()
    return display.newLayer(Const.LayerColor)
			:size(display.width,display.height)
end)

function cls:ctor()
	Util:touchLayer(self)
	PopupManager:push(self)

	Util:sprite9Lib("9sprite/9sp_16"):addTo(self)
		:pos(display.cx, display.cy)
		:size(display.width - 100, display.height - 100)

	Util:sprite9Lib("9sprite/9sp_08"):addTo(self)
		:pos(265, 370)
		:size(302, 502)
	Util:sprite9Lib("9sprite/9sp_08"):addTo(self)
		:pos(380 + 350, 370)
		:size(572, 502)

	Util:button("button/button_bg_01", handler(self, self.btnOkHandler), "确定")
		:addTo(self)
		:pos(1100, 220)
		:setTitleFontName(nil)
	Util:button("button/button_bg_01", function()
		PopupManager:popView(self)
	end, "取消")
		:addTo(self)
		:pos(1100, 150)
		:setTitleFontName(nil)

	local lsv1 = ListView.new(300, 500)
					:addTo(self)
					:pos(115, 120)
	lsv1.cell = handler(self, self.cell1)
	lsv1.callback = handler(self, self.touch1)

	local lsv2 = ListView.new(570, 500)
					:addTo(self)
					:pos(95 + 350, 120)
	lsv2.cell = handler(self, self.cell2)
	lsv2.callback = handler(self, self.touch2)

	self.lsv1 = lsv1
	self.lsv2 = lsv2

	self.selectIndex1 = 1
	lsv1:update(PlatformInfo:getServerList())
	self:select1(lsv1.data_[1])
end

function cls:cell1(i,data)
	local node = display.newNode():size(300,50)
	node.data = data

	node.select = Util:sprite9Lib("9sprite/a_9sp_10"):addTo(node)
		:pos(150, 25)
		:size(300,50)

	Util:systemLabel(data.n,22):addTo(node,1)
		:pos(150, 25)

	if self.selectIndex1 ~= i  then
		node.select:hide()
	end

	return node
end

function cls:touch1(event)
	if event.name ~= ListView.SELECT_END_EVENT then
		return
	end

	self.selectIndex1 = event.index
	local data = event.target.data
	for k,v in pairs(self.lsv1.cellLst_) do
		if v ~= event.target then
			v.select:hide()
		end
	end
	event.target.select:show()
	self:select1(data)
end

function cls:select1(data)
	local strIp = data.i
	local strPort = data.p
	local arrIp = string.split(strIp, ";")
	local arrPort = string.split(strPort, ";")
	local list = {}
	for k,v in ipairs(arrIp) do
		local name = v .. ":" .. arrPort[k]
		table.insert(list, name)
	end

	self.selectIndex2 = 1
	self.lsv2:update(list)
end

function cls:cell2(i,data)
	local node = display.newNode():size(570,50)
	node.data = data

	node.select = Util:sprite9Lib("9sprite/a_9sp_10"):addTo(node)
		:pos(node:width() / 2, 25)
		:size(node:size())

	Util:systemLabel(data,22):addTo(node,1)
		:align(display.LEFT_CENTER, 35, 25)

	if i ~= self.selectIndex2 then
		node.select:hide()
	end

	local arr = string.split(data, ":")
	TestHttp.test(arr[1], function(http)
		if tolua.isnull(node) then
			return
		end
		
		local time = http.time
		if not http.req then
			time = -1
		end

		WhiteUser.createTime(time):addTo(node, 1)
			:align(display.RIGHT_CENTER, node:width() - 35, 25)
	end)

	return node
end

function cls:touch2(event)
	if event.name ~= ListView.SELECT_END_EVENT then
		return
	end

	self.selectIndex2 = event.index
	local data = event.target.data
	for k,v in pairs(self.lsv2.cellLst_) do
		if v ~= event.target then
			v.select:hide()
		end
	end
	event.target.select:show()
end

function cls:btnOkHandler()
	local data1 = self.lsv1.data_[self.selectIndex1]
	local data2 = self.lsv2.data_[self.selectIndex2]

	cc.exports.TEST_SELECT_SERVER    = data1.t
	cc.exports.TEST_SELECT_SERVER_IP = data2

	Tips.new("设置成功\n" .. data1.n .. "\n" .. data2)
	PopupManager:popView(self)
end

return cls