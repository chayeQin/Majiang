--
-- Author: lyt
-- Date: 2017-02-17 17:19:32
--
local cls = class("SDKEvent")

local METHOD = {
	"start", -- 游戏启动
	"updateStart", -- 开始更新
	"updateComplete", -- 更新完成
	"newUser", -- 角色注册
	"loginStart", -- 开始载入
	-- "loginComplete", -- 载入完成 特殊接口。单独定义
	"CGStart", -- CG开始
	"CGSkip", -- CG跳过
	"CGComlete", -- CG完成
	"FlagSelect", -- 国旗选择
	"FirstTask", -- 完成第一个任务
	"Fort", -- 达到X级堡垒
	-- "levelUp", -- 角色升级
	"selectLangShow", -- 选择语言
	"selectLangClick", -- 选择语言
	"selectLangClose", -- 选择语言
}

for k,v in ipairs(METHOD) do
	cls[v] = function(self, param)
		if User and User.info then
		    param           = param or {}
		    param.uid       = User.info.uid
		    param.level     = User.info.level
		    param.fortLevel = BuildingModel:getMainCityLevel() + 1
		end

		Api:call("SDK", v, param)
	end
end

-- 登录完成
function cls:loginComplete()
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
		gem   = PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel),
	}
	Api:call("SDK", "loginComplete", params)
end

-- 角色升级
function cls:levelUp()
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
		gem   = PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel),
	}
	Api:call("SDK", "levelUp", params)
end

-- 充值成功
function cls:payComplete()
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
		gem   = PackModel:getItemCount(Const.TData.TPropCannot, Const.TPropCannot.jewel),
	}
	Api:call("SDK", "payComplete", params)
end

function cls:ctor()
end

return cls