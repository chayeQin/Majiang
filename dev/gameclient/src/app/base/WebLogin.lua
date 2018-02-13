--
-- Author: lyt
-- Date: 2015-01-23 12:19:14
-- WEB登录
local WebLogin = {}

function WebLogin.login(showLoading,rhand)
	WebLogin.showLoading = showLoading
	WebLogin.loadRhand = rhand

	if JION_USER then
		WebLogin.loginJion()
		return
	end

	if GAME_CFG.login_sdk then
		if TEST_DEV then
			WebLogin.loginByPC()
		else
			WebLogin.loginBySdk()
		end
	else
		WebLogin.loginByMac()
	end
end

-- 使用SDK登陆
function WebLogin.loginBySdk()
	local params = PlatformInfo:getSdkParam()
	local plat = PlatformInfo:getPlatformName()
	if not params or #params == 0 then
		params = "[]"
	else
		params = json.encode(params)
	end
	local url = URLConfig.FORMAT_SDK_LOGIN
	local postData = {
		plat = plat,
		lang = Lang:getLang(),
		data = params,
	}

	Http.load(url, WebLogin.rhand, Lang:find("sys_net_lose"), WebLogin.fhand, nil, showLoading, postData)
end

-- 使用PC登陆
function WebLogin.loginByPC()
	local params = PlatformInfo:getSdkParam()
	local plat = PlatformInfo:getPlatformName()
	if not params or #params == 0 then
		params = "[]"
	else
		params = json.encode(params)
	end
	local url = URLConfig.FORMAT_PC_LOGIN
	local postData = {
		plat = plat,
		lang = Lang:getLang(),
		data = params,
		sid  = PlatformInfo:getServerId(),
	}

	Http.load(url, WebLogin.rhand, Lang:find("sys_net_lose"), WebLogin.fhand, nil, showLoading, postData)
end

function WebLogin.loginJion()
	local params = {JION_USER.uid}
	params = json.encode(params)
	local url = URLConfig.FORMAT_PC_LOGIN
	local postData = {
		plat = "demo",
		lang = Lang:getLang(),
		data = params,
		sid  = JION_USER.sid,
	}

	print("**** url ", url)
	print("**** ", json.encode(postData))

	Http.load(url, WebLogin.rhand, Lang:find("sys_net_lose"), WebLogin.fhand, nil, showLoading, postData)
end

-- 直接用MAC登陆
-- 1.绑定登录接口
-- 	http://127.0.0.1/admin/bindLogin?phoneId=shebei1&plat=demo
-- 	参数：
-- 		phoneId=设备id
-- 		plat=平台
-- 	返回：
-- 		失败：fail
-- 		成功：
function WebLogin.loginByMac()
	local plat = PlatformInfo:getPlatformName()
	local mac = LoginCtrl:getPhoneMac()

	local url = URLConfig.FORMAT_BIND_LOGIN
	local postData = {
		plat    = plat,
		phoneId = mac,
	}

	Http.load(url, WebLogin.rhand, Lang:find("sys_net_lose"), WebLogin.fhand, nil, showLoading, postData)
end

--@return 平台类型,uid,时间戳,MD5,平台UID,禁言时间截止时间,进入服务器SID
function WebLogin.rhand(v)
	print("*** web login",v,"<--", GAME_CFG.login_sdk)
	v = v or "fail"
	if v == "" then
		v = "fail"
	end

	User.isInitFinished = false
	if v == "fail" then
        Loading.hide(true)
		Msg.new(db.TErrorCode[100].data, handler(app,app.restart))
		return
	end

	-- 直接设备ID登陆返回的结构[原接口数据,绑定使用的新结构]
	if not JION_USER and not GAME_CFG.login_sdk then
		local obj = json.decode(v)
		if not obj then
	        Loading.hide(true)
			Msg.new(db.TErrorCode[100].data, handler(app,app.restart))
			return
		end
		v = obj[1]
		PlatformInfo:initBind(obj[2])
	end

	local ary = string.split(v, ",")
	PlatformInfo:setUid(ary[2])
	PlatformInfo:setPlatformUid(ary[5])

	-- 测试使用服务器
	if TEST_SELECT_SERVER then
		PlatformInfo:selectServer(TEST_SELECT_SERVER)
	elseif ary[7] == "0" then
		Msg.new("你所有的分组没有一个服务器.请检查配置!")
		return
	else
		PlatformInfo:selectServer(checknumber(ary[7]))

		if not PlatformInfo:getServerInfo() then -- 容错
			local list = PlatformInfo.serverList
			PlatformInfo.serverInfo = list[#list]
			print("*** 容错服务器:" .. PlatformInfo:getServerId())
		end
	end

	WebLogin.loginRhandData1 = {PlatformInfo:getServerInfo().t, v}
	WebLogin.loginRhandData2 = nil

	Http.load(URLConfig.FORMAT_IP, WebLogin.IPrhand, false, WebLogin.IPrhand, nil, WebLogin.showLoading)
end

-- IP回调
function WebLogin.IPrhand(ip)
	ip = ip or ""

	IPSearchUtil.new(ip)

	--@brief web登陆成功， 向服务器发送验证
	local info2 = {LoginCtrl:getPhoneMac(), Lang:getLang(), ip}
	WebLogin.loginRhandData2 = table.concat(info2, ",")

	TestServerUtil.new(WebLogin.testServerRhand)
end

function WebLogin.testServerRhand()
	if not WebLogin.loginRhandData1 then
		return
	end

	if JION_USER then
		Net:call(WebLogin.jionRhand,"user","exist", PlatformInfo:getUid())
		return
	end

	WebLogin.startLogin()
end

-- 白名单进入玩家账号
function WebLogin.jionRhand(v)
	if v.result == 1 then
		WebLogin.startLogin()
		return
	end

	Msg.createSysMsg("进入用户失败:\n你输入的账号并没有创建游戏角色!", handler(app, app.restart))
end

function WebLogin.startLogin()
	local param1 = WebLogin.loginRhandData1
	local param2 = WebLogin.loginRhandData2
	table.insert(param1, param2)

	WebLogin.loginRhandData1 = nil
	WebLogin.loginRhandData2 = nil

	if #param1 ~= 3 then
		HeartBeatUtil:showMsg("")
		return
	end

	if WebLogin.showLoading then
		Net:call(WebLogin.loadRhand,"user","login", unpack(param1))
	else
		Net:call_(WebLogin.loadRhand,"user","login", unpack(param1))
	end
	CheckServerConnect:start()
end

--@brief 验证失败
function WebLogin.fhand(v)
	print("**** web login fail")
	Loading.hide(true)
	app:clearModule()
	app:restart()
end

return WebLogin