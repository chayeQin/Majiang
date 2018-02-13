--
-- Author: qyp
-- Date: 2017/04/27
-- Brief: 
--

local cls = class("GMLogView", cc.load("mvc").ViewBase)


function cls:onCreate()
	display.newLayer(cc.c3b(0x00,0x00,0x00))
		:size(display.size)
		:addTo(self)
		:onTouch(function() return true end, nil, true)
	self.listView = ListView.new(display.width, display.height)
						:addTo(self)

	self.listView.cell = handler(self, self.cell)
	self.listView:update(CACHE_DEBUG_LOG, #CACHE_DEBUG_LOG)
	self:onTouch(handler(self, self.onTouchHandler), nil, true)

	Util:button("com/com_btn_create", function()
			CACHE_DEBUG_LOG = {}
			self.listView:update(CACHE_DEBUG_LOG, #CACHE_DEBUG_LOG)
		end, "清除")
		:addTo(self)
		:pos(display.width - 50, 120)
		:setTitleFontName(nil)

	Util:button("com/com_btn_create", function()
			PopupManager:popView(self)
			appView:checkWhiteUser()
		end, "关闭")
		:addTo(self)
		:pos(display.width - 50, 50)
		:setTitleFontName(nil)
	PopupManager:push(self)

	if appView.logBtn then
		appView.logBtn:remove()
		appView.logBtn = nil
	end
end

function cls:cell(i, data)
	return Util:systemLabel(data, 20, cc.c3b(0xff,0xff,0xff), cc.size(self.listView:width(), 0 ))
				:anchor(0, 0)
end



return cls