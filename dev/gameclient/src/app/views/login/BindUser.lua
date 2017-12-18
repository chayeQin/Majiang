--
-- Author: lyt
-- Date: 2016-11-23 16:48:30
-- 账号系统
local cls = class("BindUser", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/BindUser.csb"

cls.RESOURCE_BINDING = {
	["node_name"] = {
		varname = "node_name",
	},
	["sp_head"] = {
		varname = "sp_head",
	},
	["btn_newuser"] = {
		varname = "btn_newuser",
		method = "btn_newuserHandler",
	},
	["btn_switch"] = {
		varname = "btn_switch",
		method = "btn_switchHandler",
	},
	["btn_bind"] = {
		varname = "btn_bind",
		method = "btn_bindHandler",
	},
	-- 首次绑定
	["lab_tips"] = {
		varname = "lab_tips",
	},
	-- 首次绑定
	["lang_szjmScbd"] = {
		varname = "lang_szjmScbd",
	},
	-- Text Label
	["lab_level"] = {
		varname = "lab_level",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
	-- Text Label
	["lang_szjmZhxt"] = {
		varname = "lang_szjmZhxt",
	},
}


function cls:ctor()
	cls.super.ctor(self)
	Util:touchLayer(self)

	self.userIcon = UserIcon.new(User.info):addTo(self.sp_head)
		:pos(49, 49)

	local lab_name = Util:systemLabel(User.info.name,20)
		:addTo(self.node_name)
		:align(display.LEFT_CENTER,0,0)
	local lab_servername = Util:systemLabel(PlatformInfo:getServerName(),20,cc.c3b(0xff,0xf4,0x9b))
								:addTo(self.node_name)
								:rightTo(lab_name,10)
	self.lab_name = lab_name
	self.lab_servername = lab_servername
	self.lab_level:setString(Lang:find("szjmZcdj", BuildingModel:getMainCityLevel()))
	self:updateUserInfo()

	PopupManager:push(self)
end

function cls:onEnter()
	self.userUpdateEvent = Util:addEvent(Event.roleUpdate, handler(self,self.updateUserInfo))
end

function cls:onExit()
	Util:removeEvent(self.userUpdateEvent)
end

function cls:updateUserInfo()
	self.lab_name:setString(User.info.name)
	self.lab_servername:rightTo(self.lab_name,10)
	if SystemSettingModel:getSetStatus(SystemSettingType.operation, Const.TSetOption.facebook_icon) and 
	User.extraInfo.iconUrl and User.extraInfo.iconUrl ~= "" then
		self.userIcon:loadIcon(User.extraInfo.iconUrl)
	end
end

function cls:onCreate()
	if GAME_CFG.login_sdk then
		self.lab_tips:hide()
		self.lang_szjmScbd:hide()
		self.btn_newuser:hide()
		self.btn_switch:hide()

		self.btn_bind:setTitleText(Lang:find("szjmQhzh"))
	else
		self:showTips()
	end

	if PlatformInfo.getVer then
		Util:label(PlatformInfo:getVer()):addTo(self)
			:align(display.RIGHT_BOTTOM, display.width - 5, 3)
	end

	local jyxId = PlatformInfo:bindUserId(BindConfig.JYX.name)
	if jyxId and jyxId ~= "" then
		local lab = Lang:find("szjm_jyx")
		lab = Lang:find("szjmQhzhcell", lab) .. ":" .. jyxId

		Util:label(lab):addTo(self)
			:pos(647, 387)
	end
end

function cls:showTips()
	if BindUtil:hadBind() then
		self.lab_tips:setString(Lang:find("szjmZhaq"))
		self.lab_tips:setTextColor(Const.Color.QualityGreen)
		self.lang_szjmScbd:hide()
	else
		self.lab_tips:setString(Lang:find("szjmZhwx"))
		self.lab_tips:setTextColor(Const.Color.QualityRed)
		self.lang_szjmScbd:show()
	end
end

function cls:btn_closeHandler()
	PopupManager:popView(self)
end

function cls:btn_newuserHandler()
	if not BindUtil:hadBind() then
		Msg.createMsg(Lang:find("szjmKsxyx1"), handler(self, self.btn_bindHandler), function()end)
		return
	end

	Msg.createMsg(Lang:find("szjmKsxyx2"), handler(BindUtil,BindUtil.newUser), function()end)
end

function cls:btn_switchHandler()
	if not BindUtil:hadBind() then
		if User.info.level < 5 then
			self:showSureSwitch()
		else
			Msg.createMsg(Lang:find("szjmKsxyx4"), handler(self, self.btn_bindHandler), function()end)
		end

		return
	end

	BindSwitch.new(self)
end

-- 低级账号确定切换窗口
function cls:showSureSwitch()
	local msg = Msg.createMsg(Lang:find("szjmBindLowLevel"), function()
		BindSwitch.new(self)
	end, function()end)

	local lab = msg.btnYes:getTitleText()
	local i = 6
	local function tick()
		i = i - 1
		if i <= 0 then
			msg.btnYes:stopAllActions()
			msg.btnYes:setTitleText(lab)
			msg.btnYes:setTouchEnabled(true)
			Util:gray(msg.btnYes, false)
		else
			msg.btnYes:setTitleText(i)
		end
	end

	msg.btnYes:setTouchEnabled(false)
	Util:gray(msg.btnYes, true)
	msg.btnYes:schedule(tick, 1)
	tick()
end

function cls:btn_bindHandler()
	if GAME_CFG.login_sdk then
		PlatformInfo.isLogout = true
		Api:call("SDK", "logout", nil, function()end)
		PlatformInfo:setSdkParam(nil)

		app:clearModule()
		app:restart()
		return
	end

	BindList.new(self)
end

return cls