-- 
--@brief SDK
--@author qyp
--@date 2015/8/13
--
local cls = class("SDK")
local TEXT_MAC_KEY = "TEXT_MAC_KEY"

function cls:ctor()
	self.login_ = nil -- 登录api
	self.pay_   = nil -- 支付api
    self.notice = nil -- 游戏公告
    self.isWhiteUser = nil -- 白名单
end

--@brief 初始化SDK
function cls:init(rhand)
	local param = {
		lang  = Lang:getLang(),
		isRTL = Lang.isRTL,
	}
	Api:call("SDK", "platform", param, function(v)
		if not v or v == "" then
			-- 生成测试MAC
			local mac = Util:load(TEXT_MAC_KEY)
			if not mac then
				mac = os.time()
				Util:save(TEXT_MAC_KEY, mac)
			end
		   	v = {
				name    = PLAT_NAME,
				mac     = mac,
				version = "1.0.0"
		    }
		else
			v = json.decode(v)
		end

		PlatformInfo:setPlatform(v)

		-- 已经使用推送。调用推送设置
		if Util:load(Const.OPEN_PUSH_TAG) then
			NotisUtil:open()
		end

		rhand()
	end)
end

function cls:enableWhiteUser(boo)
	self.isWhiteUser = boo
end

function cls:login(rhand)
	if not GAME_CFG.login_sdk then
		rhand()
		return
	end

	SDKUtil:login(rhand)
end

function cls:pay(item, rhand)
	local param = {}
	param.sid   = PlatformInfo:getServerId()
	param.sname = PlatformInfo:getServerName()
	param.uid   = User.info.uid
	param.uname = User.info.name
	param.puid  = PlatformInfo:getPlatformUid()
	param.item  = item
	
	SDKUtil:pay(param, rhand)
end

function cls:post()
    -- 玩家角色ID
    -- 玩家角色名
    -- 玩家角色等级
    -- 游戏区服ID
    -- 游戏区服名称
    -- 平台uid
	local params = {
		uid   = User.info.uid,
		name  = User.info.name,
		level = User.info.level,
		sid   = PlatformInfo:getServerId(),
		sname = PlatformInfo:getServerName(),
		puid  = PlatformInfo:getPlatformUid(),
	}
    Api:call("DataEyeInfo", "post", params)
	Api:call("SDK", "post", params)
end

function cls:exit()
	if PlatformInfo:isShowPlatformExit() then
		Api:call("SDK", "exit")
		return
	end

	if not appView:getChildByTag(TAGS.Exit) then
		local msg = Msg.createSysMsg(Lang:find("exitSure"), function()
			os.exit()
		end, function()end)
		msg:setTag(TAGS.Exit)
		msg:setLocalZOrder(TAGS.Exit)
	end
end

return cls
