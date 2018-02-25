--
-- @brief 微信登录
-- @author myc
-- @date 2018/1/4
--

local cls = class("WeChatLoginCtrl")

function cls:startLogin()
	if Util:load("access_token") then
		-- 已有曾经登录的token
		local data = Util:load("access_token")
		if data and data.expires_in_time 
			and data.expires_in_time - 120 > os.time()
			and data.access_token then
			self:getUserInfo(data)
			return
		end
		-- token已过期需要重新登录
	end
	Api:call("WeChatSDK","login",nil,handler(self,self.tokenHandler))
end

function cls:tokenHandler(v)
	local data = json.decode(v)
	local token = data.token
	dump(token)
	-- if not token or token == "" then print("登录失败") return end	-- 登录失败
	local url = string.format(URLConfig.WECHAT_LOGIN,URLConfig.WECHAT_APPID,URLConfig.WECHAT_APPSECRET,token)
	dump(url)
	Http.load(url,handler(self,self.loginSuccessHandler),nil,function ()
		print("login failed")
	end)
end

-- url返回
--[[
{ 
	"access_token":"ACCESS_TOKEN", 
	"expires_in":7200, 
	"refresh_token":"REFRESH_TOKEN",
	"openid":"OPENID",
	"scope":"SCOPE",
	"unionid":"o6_bmasdasdsad6_2sgVt7hMZOPfL"
}
]]
function cls:loginSuccessHandler(v)
	local data = json.decode(v)
	if data and data.errcode and data.errcode ~= 0 then
		print("获取access_token失败")
		dump(data)
		return
	end
	data.expires_in_time = os.time() + data.expires_in
	Util:save("access_token",data)
	self:getUserInfo(data)
end

function cls:getUserInfo(data)
	dump(data)
	local url = string.format(URLConfig.WECHAT_USER,data.access_token,data.openid)
	Http.load(url,handler(self,self.startSeverLogin),nil,function ()
		print("access_token failed")
	end)
end

-- 用户信息url返回
--[[
{ 
	"openid":"OPENID", 普通用户的标识，对当前开发者帐号唯一
	"nickname":"NICKNAME",普通用户昵称
	"sex":1,普通用户性别，1为男性，2为女性
	"province":"PROVINCE",普通用户个人资料填写的省份
	"city":"CITY",普通用户个人资料填写的城市
	"country":"COUNTRY",国家，如中国为CN
	"headimgurl": "http://wx.qlogo.cn/mmopen/g3MonUZtNHkdmzicIlibx6iaFqAc56vxLSUfpb6n5WKSYVY0ChQKkiaJSgQ1dZuTOgvLLrhJbERQQ4eMsv84eavHiaiceqxibJxCfHe/0",
	用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空
	"privilege":[
	"PRIVILEGE1", 
	"PRIVILEGE2"
	],用户特权信息，json数组，如微信沃卡用户为（chinaunicom）
	"unionid": " o6_bmasdasdsad6_2sgVt7hMZOPfL",用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
}
]]

function cls:startSeverLogin(v)
	local data = json.decode(v)
	if data == "" then return end
	dump(data)
	local uid = data.openid
	local nickname = data.nickname
	local headimgurl = data.headimgurl or ""
	GameProxy:login(uid,nickname,headimgurl,function (v)
		dump(v)
		Util:initTime(v.r.serverTime, v.r.serverTimeZone)
		User:setUserInfo(v.r)
		GameProxy:getRoomStatus(function(v2)
			local roomId = tostring(v2.r)
			User:setRoomId(roomId)
			app:enterScene("scenes.MainScene")
		end)
	end)
end

function cls:shareToFriend(title,description)
	Api:call("WeChatSDK","shareToFriend",{title = title, description = description},function ()
		print("分享成功===============")
		Msg.new("分享成功")
	end)
end

function cls:shareToCircle(title,description)
	Api:call("WeChatSDK","shareToCircle",{title = title, description = description},function ()
		print("分享成功===============")
		Msg.new("分享成功")
	end)
end

return cls