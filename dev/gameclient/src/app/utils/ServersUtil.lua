--
-- Author: lyt
-- Date: 2017-01-05 18:49:18
-- 加载服务器列表
local cls = class("ServersUtil")

function cls:ctor()
end

--@brief 加载服务器信息
function cls:loadServerInfo(rhand)
	self.loadServerInfoRhand_ = rhand
	self.tryCount             = 2 -- 重试X次

	self:tryConnect()
end

function cls:tryConnect()
	self.tryCount = self.tryCount - 1
	self.status   = 1
	-- 请求平台信息
	local mac = ""
	if SDK.isWhiteUser then
		mac = PlatformInfo:getPlatformMac()
	end
	local url = string.format(URLConfig.FORMAT_SDK_LIST,
					PlatformInfo:getPlatformName(),
					PlatformInfo:getPlatformVersion(),
					mac)

	Http.load(url,
		handler(self, self.loadServerRhand), 
		false,
		handler(self, self.loadServerFhand),
		nil,
		false)
end

function cls:loadServerRhand(v)
	self.status = 2
	local platInfo = json.decode(v) -- 解析json数据
	if not platInfo then
		self:loadServerFhand()
		return
	end

	PlatformInfo:init(platInfo)

	local mac = LoginCtrl:getPhoneMac()
	if not mac then -- 生成唯一账号
		self.status = 3
		Http.load(URLConfig.FORMAT_MAC, 
			handler(self, self.loadMacRhand), 
			false,
			handler(self, self.loadServerFhand),
			nil,
			true)
		return
	end

	if self.loadServerInfoRhand_ then
		self.loadServerInfoRhand_()
	end
end

function cls:loadMacRhand(v)
	self.status = 4
	if string.len(v) ~= 32 then
		self:loadServerFhand()
		return
	end

	LoginCtrl:setPhoneMac(v)

	if self.loadServerInfoRhand_ then
		self.loadServerInfoRhand_()
	end
end

function cls:loadServerFhand(v)
	if self.tryCount > 0 then
		Util:tick(handler(self, self.tryConnect), 0.1)
		return
	end

	URLConfig:retest()
	
	local msg = Msg.createSysMsg(Lang:find("sys_list_error"), 
		function()
			if PlatformInfo.isInitLang then
				app:restart()
			else
				app:enterScene("scenes.LogoScene")
			end
		end,function()
			NotisUtil:openSet()
		end,Lang:find("retry"), Lang:find("zhjmShzh"))

	msg.btnYes:setPositionX(452)
	msg.btnNo:setPositionX(274)

	-- 显示反馈问题按钮
	Util:button("button/btn_32", handler(LikePageUtil, LikePageUtil.openFeedBack), Lang:find("fkyj_fkyj"), 20)
		:addTo(msg.spiPanel)
		:pos(95, msg.btnYes:getPositionY())
		:setScale9Enabled(true)
		:size(160,60)
end

return cls