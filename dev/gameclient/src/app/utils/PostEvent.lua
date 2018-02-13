--
-- Author: lyt
-- Date: 2017-02-14 10:43:05
-- 上传用户操作
local cls = class("PostEvent")

local METHOD_LIST = {
	"startup","启动成功",
	"newPhone","新设备启动",

	"updateVer","获取服务器版本号",
	"updateList","获取服务器列表",
	"updateStart","开始更新",
	"updateComplete","更新完成",
	"updateErrorFile","更新下载文件失败",
	"updateErrorCopy","更新拷贝文件失败",

	"newPhoneReg","新设备注册",
	"newUser","注册",

	"loginStart","开始登陆",
	"loginComplete","登陆完成",

	"cgStart","开场动画开始",
	"cgComplete","开场动画结束",
	"cgStep","开场动画跳过",

	"flagQuick","自动选国旗",
	"flagShow","显示选国旗界面",
	"flagSelect","选国旗",

	"uiTask","打开任务界面",
	"uiBattle","打开战役界面",
	"uiBattleKill","战役攻击",
	"uiMail","打开邮件界面",
	"uiProp","打开物品界面",
	"uiFriend","打开好友界面",
	"uiUnion","打开联盟界面",

	"openSDK","打开SDK登录",
	"sdkBack","SDK登录返回",

	"puase","暂停游戏",
	"resume","恢复游戏",
	"netclose","网络断线",
	"netHeart","心跳包超时",
	"loginError","登录出错",
}

for i = 1, #METHOD_LIST, 2 do
	local method   = METHOD_LIST[i]
	local methodCN = METHOD_LIST[i + 1]

	cls[method] = function(self)
		self:call(methodCN)
	end
end

function cls:ctor()
end

function cls:post(method)
	if not self[method] then
		print("*** Error PostEvent no method", method)
	else
		self[method](self)		
	end
end

-- 上传数据
function cls:call(method)
	print("*** PostEvent :", method)
	-- local url   = URLConfig.FORMAT_LOG
	-- local param = {
	-- 	sid     = self:getSid(),
	-- 	uid     = self:getUid(),
	-- 	type    = method,
	-- 	phoneId = LoginCtrl:getPhoneMac()
	-- }

	-- -- 失败重试
	-- local tryCount = 3
	-- local load     = nil

	-- load = function()
	-- 	tryCount = tryCount - 1
	-- 	if tryCount <= 0 then
	-- 		return
	-- 	end

	-- 	Http.load(url, function(v)
	-- 		if v ~= "ok" then
	-- 			load()
	-- 		end
	-- 	end, false, load, nil, false, param)
	-- end

	-- load()
end

function cls:getUid()
	if User and User.info then
		return User.info.uid or 0
	end

	return 0
end

function cls:getSid()
	local info = PlatformInfo.serverInfo
	if info then
		return info.t
	end

	return 0
end

return cls