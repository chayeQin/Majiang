--
-- Author: lyt
-- Date: 2016-10-29 17:09:06
-- 黑屏LOGO，切场景使用
local cls = class("Logo", cc.load("mvc").ViewBase)

function cls:ctor()
	cls.super.ctor(self)

	display.newLayer(display.COLOR_BLACK):addTo(self)

	local path = GAME_CFG.game_logo
	if path and path ~= "" then
		path = string.gsub(path, "lang", Lang:getLang())
		if Util:exists(path) then
			self.logo = display.newSprite(path)
		end
	end

	if not self.logo then
		self.logo = Util:sprite("lang/logo")
	end

	self.logo:addTo(self)
		:pos(display.cx, display.cy)

	Util:label(Util:randomTips(1), 20,Const.Color.QualityOrange)
						:addTo(self)
						:pos(display.width / 2,80)

	self:addTo(appView)
end

return cls