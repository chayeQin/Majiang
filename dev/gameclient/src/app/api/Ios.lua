--
-- Author: lyt
-- Date: 2014-03-26 10:32:15
--
local Ios = class("Ios", require("app.api.Api"))

local luaoc = require("cocos.cocos2d.luaoc")

-- 评论
function Ios:like()
	device.openURL(sdkcfg.like)
end

-- 分享
function Ios:share(msg)
	-- self:call("Notis", "share",{msg=msg})
end

-- 震动(毫秒)
function Ios:shake(time)
	if not self.super.shake(self) then
		return
	end
	local args = {time=time,type=1}
	if type(time) == "table" then
		args.type = 2
	end
	self:call("Notis", "shake",args)
end

-- 消息推送,多少秒后
function Ios:notis(msg,time)
	self:call("JpushInfo", "send", {body=msg,delay=time})
end

-- 视频播放完成
local playRhand = nil
function cc.exports.ios_play_rhand()
	if playRhand then
		playRhand()
	end
end

-- 播放视频
function Ios:play(url,rhand)
	util:tick(rhand,0.01)
end

function cc.exports.ios_call(v)
	if Ios.callRhand then
		Ios.callRhand(v)
	end
end

--@notice param 必须为 {key,value} 形式
function Ios:call(clsName,method,param,rhand)
	if not param then
		param = "{}"
	else
		param = json.encode(param)
	end

	local args = {}
	args.className = clsName
	args.method    = method
	args.param     = param

	if rhand then
		Ios.callRhand  = rhand -- 旧包使用的回调
		args.rhand     = function(v) rhand(v) end -- 新包使用的回调
	end

	luaoc.callStaticMethod("LuaCall", "call",args)
end

function Ios:openUrl(url)
	self:call("Notis", "openUrl", {url=url})
end

return Ios