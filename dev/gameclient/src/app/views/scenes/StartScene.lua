--
--@brief 开始场景，登陆，加载服务器列表
--@author qyp
--@date 2015/8/17
--

local cls = class("StartScene", BaseScene)

function cls:ctor(...)
	cls.super.ctor(self, ...)

	Net:close()
	StartView.new()
			:addTo(self)
end

function cls:onEnter()
	cls.super.onEnter(self)

	Sound:unloadSound()
    Sound:music("sound/bg/4", SOUND_PZ)
	Loading.hide(true)
	display.newLayer()
		:addTo(appView, TAGS.Exit) 
		:anchor(0, 0)
		:size(display.width, display.height)
		:onTouch(handler(self, self.onTouchHandler), nil, false)

	-- LoginCtrl:showStartView()

	LoginCtrl:loginStart()
end

function cls:onExit()
	cls.super.onExit(self)
	LoginCtrl:clear()
end

function cls:onTouchHandler(e)
	if e.name == "began" then
		local rect = cc.rect(0, 0, display.width, 200)
		if cc.rectContainsPoint(rect, cc.p(e.x, e.y)) then
			return true
		end
	elseif e.name == "ended" then
		local rect = cc.rect(0, display.height - 200, display.width, 200)
		if cc.rectContainsPoint(rect, cc.p(e.x, e.y)) then
			SDK:enableWhiteUser(true)
			app:clearModule()
			Msg.createSysMsg("切换中...")
			Util:tick(function()
				app:restart()
				local msg = Msg.createSysMsg("启动白名单,全选拷贝:\n \n ", function()end)
				local text = Util:editBox(cc.size(500,30), function()end)
					:addTo(msg.spiPanel, 100)
					:pos(280, 123)
				text:setText(PlatformInfo:getPlatformMac())
			end, 0)
		end
	end
end

return cls