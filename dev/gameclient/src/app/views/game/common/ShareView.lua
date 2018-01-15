--
-- @brief 分享界面
-- @author myc
-- @date 2017/12/19
--

local cls = class("ShareView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/ShareView.csb"

cls.RESOURCE_BINDING = {
	["btn_wechat"] = {
		varname = "btn_wechat",
		method = "btn_wechatHandler",
	},
	["btn_friend"] = {
		varname = "btn_friend",
		method = "btn_friendHandler",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
}

function cls:onCreate()
	PopupManager:push(self)
	Util:touchLayer(self)
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

function cls:btn_wechatHandler(target)
	-- TODO 微信分享
	local content = ""
	WeChatLoginCtrl:shareToCircle(content)
end

function cls:btn_friendHandler(target)
	-- TODO 朋友圈分享
	local content = ""
	WeChatLoginCtrl:shareToFriend(content)
end

return cls