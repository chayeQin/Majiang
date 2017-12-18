--
-- @brief 
-- @author: qyp
-- @date: 2016/03/12
--

local cls = class("TestCocosCode", cc.Node)

function cls:ctor()
	local testLst = {
		{"测试富文本", handler(self, self.testRichText)}
	}

	-- for i, v in ipairs(testLst) do
	-- 	Util:button("button/button_bg_01", function()
	-- 		v[2]()
	-- 	end, v[1])
	-- 		:addTo(self)
	-- 		:pos(300, display.height - i*100)
	-- end

	-- local str = "asdfSDDSFASDFñlñppñlsdf12l"


	local lst = ChatModel:getPublicChat()
	local listView = ListView.new(400, 500)
		:addTo(self)
		:pos(300, 200)
	listView.cell = self.cell
	self.listView = listView
	listView.callback = handler(self, self.listViewEvent)
	listView:update(lst)

end

function cls:listViewEvent(event)
	if event.name == ListView.ELASTIC_TOP_EVENT then
		ChatModel:getPublicChatHistory(handler(self, self.historyRhand))
	end
end

function cls:onExit()
	ChatModel.publicHistoryRhand = nil
end

function cls:historyRhand(lst)
	for _, v in ipairs(lst) do
		self.listView:insert(v, 1)
	end
end

function cls:newMsg(event)
	local msg = event.params[1]
	self.listView:insert(msg)
end

function cls.cell(i, data)
	local bg = Util:sprite9Lib("9sprite/9sp_01"):anchor(0, 0)
	local txt = Util:label("第"..data.id.."条 ： " .. data.content .. " " .. data.id, nil, nil, cc.size(400, 0))
				:anchor(0,0)
				:addTo(bg)

	bg:size(txt:width(), txt:height())
	return bg
end

function cls:onPressed()
end

function cls:testRichText()
	local str = Lang:find("buildLimit", "{1}", 8)
	local lst = Util:split2rich(str, {1}, Const.Color.QualityWhite, Const.Color.SystemHint)
	Util:richText(lst)
		:addTo(self)
		:pos(300, 300)
end

return cls
