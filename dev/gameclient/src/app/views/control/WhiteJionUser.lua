--
-- Author: lyt
-- Date: 2017-05-08
-- 进入玩家
local cls = class("WhiteJionUser", function()
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

	self.lsv1 = lsv1

	-- 输入账号
	Util:sprite9Lib("9sprite/a_9sp_10"):addTo(self)
			:pos(730, 500)
			:size(450,58)
	self.txtName = Util:editBox(cc.size(430,50))
			:addTo(self)
			:pos(730, 500)
	self.txtName:setPlaceHolder(Lang:find("input_account"))
	self.txtName:setPlaceholderFontColor(Const.Color.SystemImport)

	self.selectIndex1 = 1
	local list = PlatformInfo:getServerList()
	if JION_USER and JION_USER.uid then
		self.txtName:setText(JION_USER.uid)
		for k,v in ipairs(list) do
			if v.t == JION_USER.sid then
				self.selectIndex1 = k
				break
			end
		end
	end
	lsv1:update(list, self.selectIndex1)
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
end

function cls:btnOkHandler()
	local data1 = self.lsv1.data_[self.selectIndex1]

	JION_USER = self.txtName:getText()
	if JION_USER == "" then
		Tips.new("请输入UID")
		return
	end

	JION_USER = {
		uid = JION_USER,
		sid = data1.t,
	}

	TEST_SELECT_SERVER = data1.t

	local function rhand()
		Tips.new("设置成功\n" .. json.encode(JION_USER))
		PopupManager:popView(self)

		ViewStack:clear()
		ViewStack:pop()
		LoginCtrl:sdkLogin()
	end

	LoginCtrl:regUser(JION_USER.uid, "1111", rhand, rhand)
end

return cls