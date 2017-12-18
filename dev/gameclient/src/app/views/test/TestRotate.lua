--
--@brief: 
--@author: qyp
--@date: 2016/02/29
--


local cls = class("TestRotate", cc.load("mvc").ViewBase)

function cls:onCreate()
	self.switchWorldPanel = require("app.views.game.SwitchWorldPanel").new()
							:addTo(self, 1)



	local btn = Util:button("button/button_bg_01", function()
		Util:event(Event.gameSwitch, "test.TestSelectView")
		-- self:remove()
	end, "场景测试"):addTo(self)
			:pos(300, 300)

	-- local timeLab = Util:label("00:00:00")
	-- 					:addTo(self)
	-- 					:pos(display.center)

	CircleMenu.new()
		:addTo(self)
		:pos(display.center)

end

function cls:observerTime()
end


return cls