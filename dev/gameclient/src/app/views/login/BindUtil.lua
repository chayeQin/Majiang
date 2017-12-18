--
-- Author: lyt
-- Date: 2016-11-23 18:49:39
--
local cls = class("BindUtil")

function cls:ctor()
end

-- 是否绑定过
function cls:hadBind()
	if GAME_CFG.login_sdk then
		return true
	end
	
	for k,v in pairs(BindConfig.SDKS) do
		local id = PlatformInfo:bindUserId(v.name)
		if id ~= nil and id ~= "" then
			return true
		end
	end

	return false
end

function cls:bind(data, rhand)
	-- 使用自己SDK
	if data.call == "" then
		LoginView.new(function()
			local obj = PlatformInfo:getSdkParam()
			self:bindHttp(data.name, obj[1], json.encode(obj), rhand)
		end)
		return
	end

	-- 第三方SDK
	Api:call("SDK", data.call, nil, function(v)
		if not v or v == "" then
			return
		end

		local obj = json.decode(v)

		self:bindHttp(data.name, obj[1], v, rhand)
	end)
end

function cls:bindHttp(sdkName, sdkUid, data, rhand)
	local puid = PlatformInfo:getPlatformUid()

	local url = URLConfig.FORMAT_BIND_ACCOUNT
	local postData = {
		id      = puid,
		type    = sdkName,
		account = sdkUid,
		data    = data,
	}

	Http.load(url, function(v)
		if v == "fail" then
			local msg = Lang:find("szjmErrorBd") .. "\n"
			msg = msg .. Lang:find("szjm_" .. sdkName) .. " : " .. sdkUid
			Msg.createTimeMsg(msg)
			return
		end

		PlatformInfo:setBindUserId(sdkName, sdkUid)
		Net:call(function(v)
			if v.error ~= 0 then
				return
			end
			-- [0=玩家其它数据(UPlayerExtra);1=奖励列表
			v = v.result
			if v[2] then
				PackModel:update(v[2], true)
			end
			Util:event(Event.bindAccount)
		end,"user", "receiveBindAccount", User.info.uid)

		self:checkInviteGift(sdkName, sdkUid)

		if rhand then rhand() end
	end,nil, nil , nil, true,postData)
end

function cls:unbind(sdkName, rhand)
	local sdkUid = PlatformInfo:bindUserId(sdkName)
	local url = URLConfig.FORMAT_BIND_REMOVE
	local postData = {
		type    = sdkName,
		account = sdkUid,
	}

	Http.load(url, function(v)
		if v == "fail" then
			Msg.createTimeMsg(db.TErrorCode[100].data)
			return
		end

		PlatformInfo:setBindUserId(sdkName, "")
		Util:event(Event.bindAccount)
		if rhand then rhand() end
	end,nil, nil , nil, true,postData)
end

-- 切换账号
function cls:switch(data)
	-- 使用自己SDK
	if data.call == "" then
		LoginView.new(function()
			local obj = PlatformInfo:getSdkParam()
			self:switchHttp(data.name, obj[1], json.encode(obj))
		end)
		return
	end

	-- 第三方SDK
	Api:call("SDK", data.call, nil, function(v)
		if not v or v == "" then
			return
		end

		local obj = json.decode(v)

		self:switchHttp(data.name, obj[1], v)
	end)
end

-- 参数：
-- 	type=账号类型
-- 	account=账号名称
-- 返回：
-- 	失败：fail
-- 	成功：{"id":1,"isUse":1,"jyx":"1","phoneId":"shebei1"}
function cls:switchHttp(sdkName, sdkUid, data)
	local url  = URLConfig.FORMAT_BIND_CHANGE
	local mac  = LoginCtrl:getPhoneMac()
	local sign = Crypto.md5(URLConfig.GAME_KEY .. sdkName .. sdkUid .. mac)
	local postData = {
		type    = sdkName,
		account = sdkUid,
		phoneId = mac,
		sign    = sign,
		data    = data,
	}

	Http.load(url, function(v)
		if v == "fail" then
			Msg.createTimeMsg(Lang:find("sjmErrorQh"))
			return
		end

		app:clearModule()
		app:restart()
	end,nil, nil , nil, true,postData)
end

function cls:newUser()
	ServerListNewUser.new(handler(self, self.selectServerRhand))
end

function cls:selectServerRhand(sid)
	local mac = LoginCtrl:getPhoneMac()

	local url = URLConfig.FORMAT_BIND_REGISTER
	local postData = {
		plat    = PlatformInfo:getPlatformName(),
		phoneId = mac,
		sid     = sid,
	}

	Http.load(url, function(v)
		if v == "fail" then
			Msg.createTimeMsg(db.TErrorCode[100].data)
			return
		end

		app:clearModule()
		app:restart()
	end,nil, nil , nil, true, postData)
end

-- 检查是否有被邀请奖励
function cls:checkInviteGift(sdkName, uid)
	local function rhand(v)
		if v == nil or v == "" then
			return
		end
		v = json.decode(v)
		if not v then
			return
		end

		-- SDK 里代码
		-- obj.put("fromId", from.getString("id"));
		-- obj.put("fromName", from.getString("name"));
		-- obj.put("uid", arg0.getString("id"));
		-- obj.put("name", arg0.getString("name"));
		-- obj.put("picture", arg0.getString("picture"));
		self:inviteGift(sdkName, v.uid, v.name, v.picture, v.fromId)
	end

	if sdkName == BindConfig.FACE_BOOK.name then
		FBInvite:getInviteFriend(rhand)
		FBInvite:getMe(handler(self, self.postMeHead))
		return
	end
end

-- 上传自己头像和名字
function cls:postMeHead(v)
	dump(v, "** 是否上传头像")
	if not v.name or not v.picture then
		print("没有facebook用户数据")
		return
	end
	Msg.new(Lang:find("zhbd_shtx"),function ()
		-- 上传头像、名字 设置facebook头像开关
		Net:call(function (v)
			if v.error ~= 0 then
				return
			end
			v = v.result
			if v[1] then
				User:initExtraInfo(v[1])
			end
			User:update(v[2])
			SystemSettingProxy:setting(SystemSettingType.operation, Const.TSetOption.facebook_icon,1,true)
		end, "User", "setFacebookInfo",User.info.uid,v.picture,v.name)
	end,function ()	end)
end

-- 获取被邀请奖励
-- type=facebook&uid=提交者&name=名字&icon=头像&uuid=邀请人
function cls:inviteGift(sdkName, uid, name, icon, fromId)
	local url = URLConfig.FORMAT_INVITE
	local postData = {
		type    = sdkName,
		plat    = PlatformInfo:getPlatformName(),
		uid     = User.info.uid,
		phoneId = LoginCtrl:getPhoneMac(),
		name    = name,
		icon    = icon,
		uuid    = fromId, -- 谁发起的邀请
	}

	Http.load(url, function(v)
		if v ~= "1" then
			return
		end

	end,nil, nil , nil, true,postData)
end

return cls