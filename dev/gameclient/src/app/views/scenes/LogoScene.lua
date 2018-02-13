--
--@breif LOGO
--@author qyp
--@date 2016/2/3
--
local cls = class("LogoScene",  cc.load("mvc").ViewBase)

local SAVE_INIT_LANG_TW = "SAVE_INIT_LANG_TW" -- 繁体包处理
local Area = require("app.base.Area")

if GAME_CFG.test_game_path then
    local res = "res/" .. GAME_NAME .. "/share"
    cc.FileUtils:getInstance():addSearchPath(res)
    local res = "res/" .. GAME_NAME
    cc.FileUtils:getInstance():addSearchPath(res)
end

function cls:onCreate()
	local logoTime = 0.1
	local bgColor = GAME_CFG.game_init_bg_color
	local logo = GAME_CFG.game_init_logo
	if logo and logo ~= "" then
	else
		logo = "big_img_logo.png"
	end
	
	if bgColor == nil then
		bgColor = display.COLOR_BLACK
	elseif bgColor == 1 then
		bgColor = display.COLOR_WHITE
	end

	if TEST_DEV then
		logoTime = 0.01
	end

	local area = GAME_CFG.area or ""
	if area == Area.china then
		logoTime = 5
	end

	self.logoTime = logoTime

	self.bg = display.newLayer(bgColor)
					:addTo(self)
					:align(display.left_bottom, 0, 0)
	print(">>>logo scene")
	local size = self:getContentSize()
	self.logo = display.newSprite(logo)
						:addTo(self)
						:setPosition(display.cx, display.cy)

	-- require("app.views.game.common.GuangDian").new():addTo(self)
end

function cls:onEnter()
	self.startTime = os.time()
	local action = transition.sequence({
        cc.DelayTime:create(0),
 		cc.CallFunc:create(handler(self, self.delayRhand)),
    })
    self:runAction(action)
end

-- 下一帧才加载代码.让LOGO显示出来
function cls:delayRhand()
	app:initModule()

	SDK:init(function()
		-- URLConfig:retest()
		-- URLConfig:checkGameUrl(handler(self, self.configRhand))
		self:loadPlist()
		self:enterGame() --简单游戏直接进入登陆界面
	end)
end

function cls:loadPlist()
	print("****load plist")
	
end

-- 主页地址测试完成,并开始加载
function cls:configRhand()
	ServersUtil:loadServerInfo(handler(self, self.serverRhand))
end

-- 地址加载完成,并处理支持语言
function cls:serverRhand()
	PlatformInfo.isInitLang = true
	local str  = PlatformInfo.platInfo.lang or "en,cn,tw"
	local list = string.split(str, ",")
	local map  = {}
	for k,v in ipairs(list) do
		if v ~= "" then
			map[v] = true
		end
	end

	-- 删除不支持语言
	for k,v in pairs(Lang.FONTS) do
		if not map[k] then
			Lang.FONTS[k] = nil
			print("*** 删除不支持的语言:", k)
		end
	end

	-- 检查是否全部删除
	if table.nums(Lang.FONTS) == 0 then
		Msg.createSysMsg("WEB 没有配置使用语言,请配置后再启动游戏！")
		return
	end

	-- 如果是繁体语言第一次启动则设置一次语言
	local isResetLang = false
	local tw = Util:load(SAVE_INIT_LANG_TW)
	if not tw then
		local isTw = PlatformInfo.platform.isTw
		if isTw == true or isTw == 1 then
			Lang:setLang("tw")
			isResetLang = true
		end
		Util:save(SAVE_INIT_LANG_TW, true)
	end

	-- 使用不开放的语言.设置使用默认语言的第一个
	local lang = Lang:getLang()
	print("*** 当前使用语言:", lang)
	if not map[lang] then
		for k,v in ipairs(list) do
			if Lang.FONTS[v] then
				isResetLang = true
				Lang:setLang(v)
				print("*** 使用不允许的语言,切换为:", v)
				break
			end
		end
	end

	if isResetLang then
		app:clearModule()
		app:initModule()
		URLConfig:checkGameUrl(handler(self, self.serverRhand))
		return
	end

	self:enterGame()
end

function cls:enterGame()

	
	local dtime = self.logoTime - (os.time() - self.startTime)
	if dtime > 0 then
		local action = transition.sequence({
	        cc.DelayTime:create(dtime),
	 		cc.CallFunc:create(handler(app, app.startGame)),
	    })
	    self:runAction(action)
	else
		app:startGame()
	end
end

return cls