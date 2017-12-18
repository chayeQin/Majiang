--
-- @brief 登录界面
-- @author: qyp
-- @date: 2016/04/18
--
--

local cls = class("LoginView", function()
    return display.newLayer(cc.c4b(0,0,0,0)):size(display.width,display.height)
end)

function cls:ctor(rhand, loginTitle, regTitle)
	self.rhand = rhand
	Util:jpg("bg/login_bg_01"):addTo(self):center()
	local loginBg = Util:sprite9("login/denglu_bg_01",70,120,70,120)
						:size(700,350)
						:addTo(self)
						:center()
	local btnBg = Util:button("login/denglu_guanbianniu",function ()
		if rhand then
			PopupManager:popView(self)
		else
			LoginCtrl:closeLoginView()
		end
	end):addTo(loginBg)
		:align(display.RIGHT_TOP,loginBg:width() - 40,loginBg:height() - 40)
	Util:label(Lang:find(Lang:find("account")),24)
		:addTo(loginBg)
		:align(display.RIGHT_CENTER, 150, 240)
	local accountBg = Util:sprite9("login/denglu_bg_02",54,16,54,16)
							:size(440,50)
	accountBg:addTo(loginBg)
			:align(display.LEFT_CENTER,160,240)
	self.edit1 = Util:editBox(cc.size(430,50),handler(self,self.checkValidUsrName))
			:addTo(accountBg):center()
	self.edit1:setPlaceHolder(Lang:find("input_account"))

	Util:label(Lang:find("password"),24)
		:addTo(loginBg):align(display.RIGHT_CENTER, 150, 170)
	local passwordBg = Util:sprite9("login/denglu_bg_02",54,16,54,16)
							:size(440,50)
	passwordBg:addTo(loginBg)
			:align(display.LEFT_CENTER,160,170)
	self.edit2 = Util:editBox(cc.size(430,50), handler(self,self.checkValidUsrName))
		:addTo(passwordBg):center()
	self.edit2:setPlaceHolder(Lang:find("input_password"))

	local name = Util:load("reg_username")
	self.edit1:setText(name)
	name = Util:load("reg_password")
	self.edit2:setText(name)

	-- 登录
	loginTitle = loginTitle or Lang:find("login")
	local btn_login = Util:button({"button/btn_27","button/btn_27_02"},handler(self,self.login),loginTitle,22)
					:addTo(loginBg):pos(220,90)
	btn_login:ignoreContentAdaptWithSize(false)
	btn_login:size(200,60)
	btn_login:setScale9Enabled(true)

	-- 注册
	regTitle = regTitle or Lang:find("regist")
	local btn_regist = Util:button({"button/btn_27","button/btn_27_02"},handler(self,self.reg),regTitle,22)
					:addTo(loginBg):pos(480,90)
	btn_regist:ignoreContentAdaptWithSize(false)
	btn_regist:size(200,60)
	btn_regist:setScale9Enabled(true)
	-- -- 一键注册
	-- Util:button("button/btn_03",handler(self,self.oneKey),Lang:find("一键注册"))
	-- 	:addTo(self):pos(display.width*3/4,90)

	Util:label(Lang:find("dljm_zcsm"), 22):addTo(loginBg)
		:pos(345, 0)

	self:onTouch(function() return true end,nil,true)

	if rhand then
		PopupManager:push(self)
	end
end

function cls:createArow(lab)
	if self.arrow then
		self.arrow:remove()
	end

	self.arrow = Util:createAniWithCsb("jiantou", 2, nil, nil, true)
					:addTo(lab:getParent())
	local effect = Util:createAniWithCsb("texiao", 2, nil, nil, false)
							:addTo(self.arrow)

	local x,y = lab:getPosition()
	self.arrow:pos(x,y + 50)

	effect:run{
		"seq",
		{"delay", 75/90},
		{"remove"},
	}
end

function cls:checkInputText()
	local str1 = self.edit1:getText()
	if str1 == "" then
		Tips.show(db.TErrorCode[4].data)
		self:createArow(self.edit1)
		return true
	end

	local str2 = self.edit2:getText()
	if str2 == "" then
		Tips.show(db.TErrorCode[4].data)
		self:createArow(self.edit2)
		return true
	end

	return false
end

function cls:login()
	if self:checkInputText() then
		return
	end

	Util:save("reg_username",self.edit1:getText())
	Util:save("reg_password",self.edit2:getText())
	self:callback()
end

function cls:reg()
	if self:checkInputText() then
		return
	end

	local str1 = self.edit1:getText()
	local str2 = self.edit2:getText()
	LoginCtrl:regUser(str1, str2, function()
		self:callback()
	end, function(errCode)
        if errCode == -2 then
            Tips.show(Lang:find("account_exist"))
        else
            Tips.show("error = "..result.error)
        end
	end)
end

function cls:oneKey()
	local usrName, pass = LoginCtrl:randUsr()
	print("....one key reg", usrName, pass)
	LoginCtrl:regUser(usrName, pass, function()
		self:callback()
	end, handler(self, self.oneKey))
end

function cls:checkValidUsrName(e)
	local text = e:getText()
	local len = string.len(text)
	local i = 1
	--只允许输入数字和字母
	while i <= len do
	    local c = string.byte(text,i)
	    if (c >=48 and c <= 57) 
	    	or (c >=65 and c <= 90)
	    	or (c >=97 and c <= 122) then
	        i = i + 1
	   	else
	   		Tips.show(db.TErrorCode[7].data)
	   		e:setText("")
	   		return
	  	end
	end
end

function cls:ok(e)

end

function cls:callback()
	if self.rhand then
	    local username = Util:load("reg_username")
    	username = string.lower(username)
    	local password = Util:load("reg_password") or ""
		LoginCtrl:login(username, password, function()
			self.rhand()
			PopupManager:popView(self)
		end, function()end)
		return
	end
	
	LoginCtrl:sdkLogin()
	LoginCtrl:closeLoginView()
end

return cls