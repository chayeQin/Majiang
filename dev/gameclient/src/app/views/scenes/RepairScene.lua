--
-- Author: lyt
-- Date: 2017-03-06 18:05:00
-- 程序出错时显示的修复界面
local cls = class("RepairScene", cc.load("mvc").ViewBase)

local LANG = {
	cn = {
		tips         = "程序出错,正在修复中!",
		ok           = "修复完成!正在尝试启动游戏...",
		fail_windows = "修复失败!",
		fail_ios     = "修复失败,请卸载后再重新安装!",
		fail_android = "修复失败,请到应用设置页清除应用数据!",
	},
	tw = {
		tips         = "程式出錯，正在修復中！",
		ok           = "修復完成！正在嘗試啟動遊戲…",
		fail_windows = "修復失敗！",
		fail_ios     = "修復失敗，請卸載後再重新安裝！",
		fail_android = "修復失敗，請到應用設定頁清除應用數據！",
	},
	en = {
		tips         = "Program error, repair!",
		ok           = "Repair finished! Trying to start the game ...",
		fail_windows = "Repair failed!",
		fail_ios     = "Repair failed, please uninstall and then re-install!",
		fail_android = "Repair failed, please go to the application settings page to clear the application data!",
	}
}

-- device.platform
-- device.language
function cls:ctor()
	LOAD_FAIL_COUNT = LOAD_FAIL_COUNT + 1

	local lang = cc.UserDefault:getInstance():getStringForKey("game_lang")
	if lang == nil or lang == "" then
		lang = device.language
	end
	self.langData = LANG[lang] or LANG.en

	cls.super.ctor(self)
	print("*** 进入修复程序!!")
end

function cls:onCreate()
	if TEST_DEV then
		self:label("")
			:pos(display.cx, display.cy)
			:setString("程序出错!")
		return
	end

	self.lab = self:label("tips")
		:pos(display.cx, display.cy)

	if LOAD_FAIL_COUNT > 3 then
		self.lab:setString(self:lang("fail_" .. device.platform))
		self:tick(handler(self, self.openSet), 2)
		return
	end

	self:tick(handler(self,self.clearCode))
end

function cls:clearCode()
	self.lab:setString(self:lang("tips"))
	clearUpload()
	app:clearModule()

	local writablePath = cc.FileUtils:getInstance():getWritablePath()
	-- 创建upload 目录
	local uploadPath = writablePath .. "upload"

	local cmd = nil
	if device.platform == "windows" then
		cmd = "rmdir /s /q " .. string.gsub(uploadPath, "/", "\\")
	else
		cmd = "rm -rf " .. uploadPath
	end
	print("*** cmd:", cmd)
	local o = io.popen(cmd)
	o:read("*all")
	o:close()

	self:tick(handler(self,self.showStart), 0.1)
end

function cls:showStart()
	if app:initModule() then
		print("*** 尝试修复成功!")

		self.lab:setString(self:lang("ok"))
		self:tick(handler(app, app.restart), 1)
	else
		print("*** 尝试修复失败!")

		self.lab:setString(self:lang("fail_" .. device.platform))
		self:tick(handler(self, self.openSet), 2)
	end
end

function cls:openSet()
	if device.platform ~= "android" then
		return
	end

	local luaj = require("cocos.cocos2d.luaj")

    luaj.callStaticMethod("com.jyx.LuaCall", "call", {
        "JpushInfo",
        "openSet",
        "{}",
        function(v)end
        });
end

function cls:tick(callback, delay)
	delay = delay or 0.01
	local scheduleNode = display.newNode()
	self:add(scheduleNode)
	local action = transition.sequence({
	    cc.DelayTime:create(delay),
	    cc.CallFunc:create(callback),
	})
	scheduleNode:runAction(action)
end

function cls:lang(key)
	print("**** key ", key)
	return self.langData[key] or ""
end

function cls:label(key)
	local text = self:lang(key)

	local color4b = cc.convertColor(display.COLOR_WHITE, "4b")
	local lab = cc.Label:createWithSystemFont(text, nil, 20)
	lab:setTextColor(color4b)
	lab:setDimensions(display.width - 10, 0)
	lab:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_TOP)
	lab:addTo(self)

	return lab
end

return cls