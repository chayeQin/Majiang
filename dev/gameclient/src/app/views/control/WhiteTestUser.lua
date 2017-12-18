--
-- Author: lyt
-- Date: 2017-03-08 08:42:42
-- 测试包测试KEY输入界面
local cls = class("WhiteTestUser", cc.load("mvc").ViewBase)

cls.SAVE_KEY = "WHITE_TEST_USER_KEY"

function cls.show()
	local apk = PlatformInfo.platInfo.apk or ""
	if string.sub(apk, 1, 5) ~= "test:" then
		return false
	end

	local key1 = string.sub(apk, 6)
	local key2 = Util:load(cls.SAVE_KEY)

	local arr = string.split(key1, ",")
	local map = {}
	for k,v in ipairs(arr) do
		map[v] = true
	end

	if map[key2] then
		return false
	end

	cls.new(map)

	return true
end

function cls:ctor(map)
	self.map = map
	cls.super.ctor(self)

	Util:touchLayer(self)
	PopupManager:push(self)
end

function cls:onCreate()
	Util:sprite9Lib("9sprite/9sp_16"):addTo(self)
		:pos(display.cx, display.cy)
		:size(display.width - 100, display.height - 100)

	Util:label("请输入你的测试码:\n如果没有请与QQ:42356234索取(08:30~21:30)"):addTo(self)
		:pos(display.cx, 550)

	Util:sprite9("9sprite/a_9sp_16"):addTo(self)
		:pos(display.cx, 450)
		:size(cc.size(500,50))

	local text = Util:editBox(cc.size(500,50)):addTo(self)
		:pos(display.cx, 450)
	text:setPlaceHolder(Lang:find("cjlmDjjr"))
	self.text = text

	Util:button("button/button_bg_01", handler(self, self.btnHandler), "确定")
		:addTo(self)
		:pos(display.cx, 300)
		:setTitleFontName(nil)
end

function cls:btnHandler()
	local key = self.text:getText()
	if not self.map[key] then
		Tips.new("您输入的测试码不正确!")
		return
	end

	Util:save(cls.SAVE_KEY, key)
	LoginCtrl:sdkLogin()
	PopupManager:popView(self)
end

return cls