--
-- @brief 登录控制
-- @author: qyp
-- @date: 2016/04/18
--
local cls = class("LoginCtrl", Controller)

-- 服务器生成的唯一ID
local LOCAL_MAC_KEY = "LOCAL_MAC_KEY"

local SAVE_NEW_PHONE = "SAVE_NEW_PHONE" -- 第一次启动
local SAVE_FIRST_REG   = "SAVE_FIRST_REG" -- 第一次启动并注册

function cls:init()
end

function cls:clear()
end

function cls:loginStart()
	print("检测更新")
	local function updateRhand(state, data)
		print("***state", state)
		Util:event(Event.gameUpdateProgress, {state = state, data = data})
	end
	Util:tick(function()
		Updater:checkUpdate(updateRhand)
	end)
	-- Util:event(Event.gameUpdateProgress, {state = Updater.STATE_UPDATE_FINISH, data = data})
end

function cls:loadServerRhand()
	-- if PlatformInfo:isInReview() then
	-- 	cc.exports.TEST_TUTORIAL       = -1
	-- 	cc.exports.TEST_UNLOCK         = true
	-- 	cc.exports.TEST_SKIP_ANIMATION = true
	-- end

	Util:event(Event.loadServerFinish)

	-- 检查包是否允许登录
	if WhiteTestUser.show()then
		return
	end

	-- 如果是白名单用户显示GM设置界面
	if PlatformInfo:isWhiteUser() then
		WhiteUser.new()
		return
	end

	-- 开了白名单后不自动进游戏
	if SDK.isWhiteUser then
		return
	end

	if GAME_CFG.login_sdk then

		-- 如果默认开发模式是不自动点击登录
		-- 如果点击切换账号也不自动点击
		if not TEST_DEV and not PlatformInfo.isLogout then
			self:sdkLogin()
		end
		PlatformInfo.isLogout = false
	else
		self:sdkLogin()
	end
end

-- sdk登录
function cls:sdkLogin()
	print("SDK登陆")

	SDK:login(handler(self, self.startLoadUser))
end

function cls:showNotice()
	self.isShowNotice = true
	require("app.views.game.UINotice").new()
end

function cls:startUpdate()
	-- 重新加载服务器信息，检测检测服务器状态	
	print("检测更新")
	local function updateRhand(state, data)
		Util:event(Event.gameUpdateProgress, {state = state, data = data})
		if state == Updater.STATE_UPDATE_FINISH then
			self:checkServerLogin(false)
		end
	end

	local function loadServerRhand()
		if self:getServerStatus() ~= -1 or TEST_DEV then
			Updater:checkUpdate(updateRhand)
		else
			Msg.createSysMsg(self:getMaintenanceMessage(), 
			function()end, 
			function() os.exit() end, Lang:find("retry"), Lang:find("lmjshtc"))
		end
	end



	ServersUtil:loadServerInfo(loadServerRhand)
end

function cls:getMaintenanceMessage()
	local strTime = PlatformInfo.platInfo.m
	local arr1 = string.split(strTime, " ")
	local arr2 = string.splitInt(arr1[1], "-")
	local arr3 = string.splitInt(arr1[2], ":")

	local time = os.time({
		year  = arr2[1] or 0,
		month = arr2[2] or 0,
		day   = arr2[3] or 0,
		hour  = arr3[1] or 0,
		min   = arr3[2] or 0,
		sec   = arr3[3] or 0,
	})

	-- 时区
	local zone = Util:timeZone(os.time())

	-- 本机时间比服务端超前多少
	zone = zone - 8 * 3600

	-- 转换成本地时间
	local localTime = time + zone
	local showTime = os.date("%Y-%m-%d %H:%M:%S", localTime)
	return Lang:find("server_maintenance", showTime)
end

function cls:startLoadUser()
	-- 再次检测更新
	self:startUpdate(function()
		print("加载用户数据")
		self:checkServerLogin(false)
	end)
end

--@brief 登陆验证
function cls:checkServerLogin(onlyLogin)
	print(".......CHECK LOGIN...")
	WebLogin.login(onlyLogin, function(v, msg)
		if v.error ~= 0 then
			local data = db.TErrorCode[v.error] or db.TErrorCode[Const.TErrorCode.player_action]
			Msg.new(data.data, function()
				app:restart()
			end)
			return
		end
		Net.isLogin = true
		if onlyLogin then
			Loading.show()
			InitUser:load(handler(self, self.refreshView))
			return
		end
		self:serverLoginRhand(v.result[1],v.result[2],v.result[3],v.result[4], v.result[5])
	end)
end

function cls:refreshView()
	print("*** 重连成功!")
	Loading.hide(true)
	local sceneName = "scenes." .. appView.__cname
	app:enterScene(sceneName)
end

--@brief 登陆成功
--@param[isNew] 是否新号
--@param[userData] 用户信息
--@param[time] 时间
--@param[zone] 时区
--@param[reloginUid] 重登验证id
function cls:serverLoginRhand(isNew, userData, time, timezone, reloginId)
	Util:initTime(time, timezone)
	User.reloginId = reloginId
	User:init(userData) -- 打开本地数据库
	isNew = isNew == 0
	User:setNewUser(isNew)
	Sqlite.open("jyx_" .. User.info.uid, isNew)

	-- 调用第三方统计
	if isNew then
		local params = {
			uid   = User.info.uid,
			name  = User.info.name,
			level = User.info.level,
			sid   = PlatformInfo:getServerId(),
			sname = PlatformInfo:getServerName(),
			puid  = PlatformInfo:getPlatformUid()
		}
	    Util:save(Const.TUTORIAL_VER_TAG, Const.TUTORIAL_VER, User)

		if not Util:load(SAVE_FIRST_REG) then
			Util:save(SAVE_FIRST_REG, true)
		end
	end


	InitUser:load(function()
		app:enterScene("scenes.MainScene")
	end)
end

-- 服务器状态
function cls:getServerStatus()
	for _, v in ipairs(PlatformInfo.serverList) do
		return v.s
	end

	return 0 -- 正常状态
end

-- 登陆用户
function cls:login(username, password, rhand, fhand)
    local time = Util:time()
    local key = URLConfig.GAME_KEY .. username .. password .. time
    key = Crypto.md5(key)
    local url = URLConfig.FORMAT_JYX_LOGIN
    url = string.format(url,username,password,time,key)
    
    Http.load(url, function(result)
    	local obj = json.decode(result)
    	if not obj then
    	    fhand()
    	    return
    	end
    	if obj.error ~= 1 then
    	    if obj.error == -2 then
    	        Tips.show(Lang:find("sys_account_invalid"))
    	    elseif obj.error == 0 then
    	        Tips.show(Lang:find("sys_code_error"))
    	    else
    	        Tips.show("error = "..result.error)
    	    end
    	    fhand()
    	    return 
    	end
    	PlatformInfo:setSdkParam({username})
    	PlatformInfo:setSession(obj.result)
    	rhand()
	end, nil, fhand)
end

-- 注册用户
function cls:regUser(username,password, rhand, fhand)
	local function regUsrRhand(v)
	    local result = json.decode(v)
	    if result.error ~= 1 then
	    	if fhand then
	    		fhand(result.error)
	    	end
	
	        return 
	    end

	    Util:save("reg_username", username)
	    Util:save("reg_password", password)
	    Tips.show(Lang:find("regist_success"))
	    PlatformInfo:setSdkParam({username})
	    PlatformInfo:setSession(result.result)
	    if rhand then
		    rhand()
		end
	end

    username = string.lower(username)
    local time = Util:time()
    local key = URLConfig.GAME_KEY .. username .. password .. time
    key = Crypto.md5(key)
    local url = URLConfig.FORMAT_JYX_REG
    url = string.format(url, username, password, time, key)
    Http.load(url, regUsrRhand)
end

--@brief 随机账号密码
function cls:randUsr()
	local usrName = "a"
	local pass = ""
	for i = 1,10 do
		local v = math.random()
		if v > 0.4 then
			v = string.char(math.random(97,122))-- 小写
		else
			v = math.random(0,9)
		end
		usrName = usrName .. v
	end
	for i = 1,4 do
		local v = math.random(0,9)
		pass = pass .. v
	end

	return usrName, pass
end

-- 获取设备ID
function cls:getPhoneMac()
	local mac = Util:load(LOCAL_MAC_KEY)
	
	if mac and string.len(mac) == 32 then
		return mac
	end

	return nil
end

function cls:setPhoneMac(mac)
	Util:save(LOCAL_MAC_KEY, mac)
end

return cls