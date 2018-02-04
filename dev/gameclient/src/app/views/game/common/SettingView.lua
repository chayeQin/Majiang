--
-- @brief 设置界面
-- @author myc
-- @date 2017/12/19
--

local cls = class("SettingView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/SettingView.csb"

cls.RESOURCE_BINDING = {
	["btn_dismiss"] = {
		varname = "btn_dismiss",
		method = "btn_dismissHandler",
	},
	["img_music"] = {
		varname = "img_music",
	},
	["img_effect"] = {
		varname = "img_effect",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
}

function cls:ctor(isMainView)
	cls.super.ctor(self)
	PopupManager:push(self)
	Util:touchLayer(self)
	self.img_effect:addEventListener(handler(self,self.effectTouchHandler))
	self.img_music:addEventListener(handler(self,self.musicTouchHandler))
	self.isMainView = isMainView
	local path = "other/other_txt_tc"
	if isMainView ~= true then
		path = "other/other_txt_sqjs"
	end
	local sp = Util:sprite(path)
	sp:addTo(self.btn_dismiss)
		:center()
	self:update()
end

function cls:update()
	self.img_effect:setPercent(1 / Sound:getEffectsVolume() * 100)
	self.img_music:setPercent(1 / Sound:getMusicVolume() * 100)
end

function cls:effectTouchHandler(target)
	local volume = target:getPercent() / 100
	print("volume = " .. volume)
	Sound:setEffectsVolume(volume)
end

function cls:musicTouchHandler(target)
	local volume = target:getPercent() / 100
	print("volume = " .. volume)
	Sound:setMusicVolume(volume)
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

function cls:btn_dismissHandler(target)
	if self.isMainView then
		app:restart()
	else
		-- TODO 解散房间
		GameProxy:dismiss(handler(self, self.btn_closeHandler), 1)
	end
end

return cls