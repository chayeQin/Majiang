--
-- Author: lyt
-- Date: 2014-03-26 10:27:37
--

local Android = class("Android", require("app.api.Api"))

local luaj = require("cocos.cocos2d.luaj")

-- 评论
function Android:like()
	-- self:call("openUrl",{sdkcfg.like},function()end)
end

-- 分享
function Android:share()
end

-- 震动(毫秒)
function Android:shake(time)
	if not self.super.shake(self) then
		return
	end
	if type(time) == "table" then
		time = json.encode(time)
	end
	local args = {time}
	self:call("Notis", "shake",args)
end

-- 消息推送,多少秒后
function Android:notis(msg,time)
	self:call("JpushInfo", "send", {body=msg,delay=time})
end

-- 播放视频
function Android:play(url,rhand)
	util:tick(rhand,0.01)
end

function Android:call(className,method,param,rhand)
	if not param then
		param = "{}"
	else
		param = json.encode(param)
	end
    luaj.callStaticMethod("com.jyx.LuaCall", "call", {
        className,
        method,
        param,
        function(v)
            if rhand then 
            	rhand(v) 
            end
        end
        });
end

function Android:openUrl(url)
	self:call("SDK", "openUrl",{url=url})
end

return Android