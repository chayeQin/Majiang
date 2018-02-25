--
-- @brief 简单登录界面
-- @author myc
-- @date 2018/2/4
--

local cls = class("LoginView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/LoginView.csb"

cls.RESOURCE_BINDING = {
	["btn_login"] = {
		varname = "btn_login",
		method = "btn_loginHandler",
	},
	["img_name"] = {
		varname = "img_name",
	},
	["img_account"] = {
		varname = "img_account",
	},
	-- 昵称：
	["lab_title_0_0"] = {
		varname = "lab_title_0_0",
	},
	-- 账号：
	["lab_title_0"] = {
		varname = "lab_title_0",
	},
	-- 登录
	["lab_title"] = {
		varname = "lab_title",
	},
	["img_bg"] = {
		varname = "img_bg",
	},
}


function cls:onCreate()
	Util:popupHandler(self,self.img_bg,handler(self,self.btnCloseHandler))
	PopupManager:push(self)
	local uid = Util:load("uid")
	local nickName = Util:load("nickName")
	self.txt_account = Util:editBox(self.img_account:size(),nil,"com/com_img_panel_black.png")
	self.txt_account:addTo(self.img_account)
					:center()
	self.txt_name = Util:editBox(self.img_name:size(),nil,"com/com_img_panel_black.png")
	self.txt_name:addTo(self.img_name)
					:center()
	self.txt_account:setText(uid)
	self.txt_name:setText(nickName)
end

function cls:btn_loginHandler(target)
	local uid = self.txt_account:getText()
	local nickName = self.txt_name:getText()
	local headUrl = ""
	if uid == "" or nickName == "" then return end
	self.uid = uid
	self.nickName = nickName
	Api:call("test","test",{uid,nickName})
	GameProxy:login(self.uid, self.nickName, headUrl, handler(self, self.onRegister))
end

function cls:onRegister(v)
	Util:save("uid", self.uid)
	Util:save("nickName", self.nickName)
	self:onLogin(v)
end

function cls:onLogin(v)
	Util:initTime(v.r.serverTime, v.r.serverTimeZone)
	User:setUserInfo(v.r)
	GameProxy:getRoomStatus(function(v2)
		local roomId = tostring(v2.r)
		User:setRoomId(roomId)
		app:enterScene("scenes.MainScene")
	end)
end

function cls:btnCloseHandler()
	PopupManager:popView(self)
end

return cls