--
-- Author: lyt
-- Date: 2017-04-20 17:10:17
--
local cls = class("SDKUtil")

cls.SAVE_NAME = "SDK_UTIL_TIME"

function cls:ctor()
end

function cls:pay(param, rhand)
	local pay = PlatformInfo:getPayApi()

	if pay and pay ~= "" then -- 支付api
		pay = require("app.api.pay." .. pay).new()
		pay:pay(param, rhand)
		return true
	end

	Api:call("SDK","pay",param, rhand)
	return true
end

-- 必须返回TRUE,兼容旧代码
function cls:login(rhand)
	-- 测试时直接进入游戏
	if JION_USER then
		rhand()
		return true
	end

	-- 每次登录只能使用24小时
	if PlatformInfo:getSdkParam() and self:checkLoginTime() then
		rhand()
		return
	end

	self.loginRhand_ = rhand

	local login = PlatformInfo:getLoginApi()
	if login and login ~= "" then -- 登陆api
		login = require("app.api.account." .. login)
		login:call("login", handler(self, self.loginRhand))
		return true
	end

	Api:call("SDK", "login", nil, function(v)
		if not v or v == "" then
			return
		else
			v = json.decode(v)
		end

		PlatformInfo:setSdkParam(v)
		self:loginRhand()
	end)

	return true
end

function cls:checkLoginTime()
	local time = Util:load(cls.SAVE_NAME) or 0
	print("**** sdk util ", time)
	if os.time() - time < 24 * 3600 then
		print("**** not use sdk login")
		return true
	end

	return false
end

function cls:loginRhand()
	Util:save(cls.SAVE_NAME, os.time())
	self.loginRhand_()
end

return cls