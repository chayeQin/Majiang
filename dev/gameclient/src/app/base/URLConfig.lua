--
-- Author: lyt
-- Date: 2016-12-06 09:34:25
-- URL地址设置
local cls = class("URLConfig")

cls.FORMAT_TEST          = "http://{1}/yhbz/server_test.zip" -- 测试服务器

cls.GAME_KEY             = "ZFJBKARBARE2XJL6F4QO27569VWIVPN0"
cls.LOGIN_PORT           = 8079 -- 登陆服务器使用端口
cls.PAY_PORT             = 8080 -- 充值服务器使用端口
cls.PAY_DIR              = "ws" -- 充值WEB相应的目录

cls.TEST_LOGIN_PORT      = 8080  -- 测试使用的端口
cls.TEST_PAY_DIR         = "web" -- 测试使用目录

cls.FORMAT_JYX_LOGIN     = "http://{1}:{2}/account/login?uid=%s&pass=%s&time=%s&sign=%s" -- JYX 账号系统登陆
cls.FORMAT_JYX_REG       = "http://{1}:{2}/account/register?uid=%s&pass=%s&time=%d&sign=%s" -- JYX 账号系统注册

cls.FORMAT_SDK_LIST      = "http://{1}:{2}/account/game?plat=%s&ver=%s&mac1=%s" -- 游戏服务器列表地址
cls.FORMAT_SDK_LOGIN     = "http://{1}:{2}/account/sdklogin" -- 游戏登陆地址
cls.FORMAT_PC_LOGIN      = "http://{1}:{2}/account/pCLogin" -- PC登陆地址
cls.FORMAT_BIND_LOGIN    = "http://{1}:{2}/account/bindLogin" -- 游戏游客登陆地址
cls.FORMAT_BIND_ACCOUNT  = "http://{1}:{2}/account/bindAccount" -- 绑定账号
cls.FORMAT_BIND_REMOVE   = "http://{1}:{2}/account/bindRemove" -- 解除绑定
cls.FORMAT_BIND_CHANGE   = "http://{1}:{2}/account/bindChange" -- 切换账号
cls.FORMAT_BIND_REGISTER = "http://{1}:{2}/account/bindRegister" -- 创建新账号
cls.FORMAT_INVITE        = "http://{1}:{2}/account/friend" -- 邀请好友
cls.FORMAT_MAC           = "http://{1}:{2}/account/random" -- 生成唯一ID
cls.FORMAT_IP            = "http://{1}:{2}/account/IP" -- 获取服务器IP
cls.FORMAT_IP_PUSH       = "http://{1}:{2}/account/IPPush" -- 上传查询IP结果
cls.FORMAT_LOG           = "http://{1}:{2}/account/log" -- 上传事件

cls.FORMAT_SDK_PAY       = "http://{1}:{2}/{3}/pcpay?game=%s&lang=%s&sid=%d&uid=%s&num=%d&item=%d" -- 游戏模拟充值地址
cls.FORMAT_FEED_BACK     = "http://{1}:{2}/{3}/apijsp/feedback.jsp" -- 客服意见
cls.FORMAT_ERROR         = "http://{1}:{2}/{3}/error" -- 上传错误信息
cls.FORMAT_RED_PACK      = "http://{1}:{2}/{3}/redPack" -- 生成充值红包信息
cls.FORMAT_PING          = "http://{1}:{2}/{3}/apijsp/ping.jsp" -- 网络请求
cls.FORMAT_URL           = "http://{1}:{2}/{3}/" -- 网站地址

cls.IAPPPAY_ORDER        = "http://{1}:{2}/{3}/iapppayOrder" -- 创建爱贝订单
cls.IAPPPAY_ENCRY        = "http://{1}:{2}/{3}/iapppayEncry" -- 创建爱贝WEB支付连接

function cls:ctor()
end

-- self 是实例后的变量名,cls.是构造器的(这里不能改,只能改实例化的)
function cls:reset(urlBase)
	self.urlBase = urlBase
	self.FORMAT_JYX_LOGIN     = Lang:format(cls.FORMAT_JYX_LOGIN, urlBase, cls.LOGIN_PORT)
	self.FORMAT_JYX_REG       = Lang:format(cls.FORMAT_JYX_REG, urlBase, cls.LOGIN_PORT)
	self.FORMAT_SDK_LIST      = Lang:format(cls.FORMAT_SDK_LIST, urlBase, cls.LOGIN_PORT)
	self.FORMAT_SDK_LOGIN     = Lang:format(cls.FORMAT_SDK_LOGIN, urlBase, cls.LOGIN_PORT)
	self.FORMAT_PC_LOGIN      = Lang:format(cls.FORMAT_PC_LOGIN, urlBase, cls.LOGIN_PORT)
	self.FORMAT_BIND_LOGIN    = Lang:format(cls.FORMAT_BIND_LOGIN, urlBase, cls.LOGIN_PORT)
	self.FORMAT_BIND_ACCOUNT  = Lang:format(cls.FORMAT_BIND_ACCOUNT, urlBase, cls.LOGIN_PORT)
	self.FORMAT_BIND_REMOVE   = Lang:format(cls.FORMAT_BIND_REMOVE, urlBase, cls.LOGIN_PORT)
	self.FORMAT_BIND_CHANGE   = Lang:format(cls.FORMAT_BIND_CHANGE, urlBase, cls.LOGIN_PORT)
	self.FORMAT_BIND_REGISTER = Lang:format(cls.FORMAT_BIND_REGISTER, urlBase, cls.LOGIN_PORT)
	self.FORMAT_INVITE        = Lang:format(cls.FORMAT_INVITE, urlBase, cls.LOGIN_PORT)
	self.FORMAT_MAC           = Lang:format(cls.FORMAT_MAC, urlBase, cls.LOGIN_PORT)
	self.FORMAT_IP_PUSH       = Lang:format(cls.FORMAT_IP_PUSH, urlBase, cls.LOGIN_PORT)
	self.FORMAT_LOG           = Lang:format(cls.FORMAT_LOG, urlBase, cls.LOGIN_PORT)
	self.FORMAT_IP            = Lang:format(cls.FORMAT_IP, urlBase, cls.LOGIN_PORT)

	self.FORMAT_SDK_PAY       = Lang:format(cls.FORMAT_SDK_PAY, urlBase, cls.PAY_PORT, cls.PAY_DIR)
	self.FORMAT_FEED_BACK     = Lang:format(cls.FORMAT_FEED_BACK, urlBase, cls.PAY_PORT, cls.PAY_DIR)
	self.FORMAT_ERROR         = Lang:format(cls.FORMAT_ERROR, urlBase, cls.PAY_PORT, cls.PAY_DIR)
	self.FORMAT_RED_PACK      = Lang:format(cls.FORMAT_RED_PACK, urlBase, cls.PAY_PORT, cls.PAY_DIR)
	self.FORMAT_PING    	  = Lang:format(cls.FORMAT_PING, urlBase, cls.PAY_PORT, cls.PAY_DIR)
	self.FORMAT_URL    	      = Lang:format(cls.FORMAT_URL, urlBase, cls.PAY_PORT, cls.PAY_DIR)
	self.IAPPPAY_ORDER    	  = Lang:format(cls.IAPPPAY_ORDER, urlBase, cls.PAY_PORT, cls.PAY_DIR)
	self.IAPPPAY_ENCRY    	  = Lang:format(cls.IAPPPAY_ENCRY, urlBase, cls.PAY_PORT, cls.PAY_DIR)

	Api:call("SDK", "payUrl", {url = self.FORMAT_URL}, function()end)
end

-- 检查游戏WEB哪个更快
function cls:checkGameUrl(rhand)
	if TEST_SERVER then
		print("*******test server",TEST_SERVER)
		cls.LOGIN_PORT = cls.TEST_LOGIN_PORT
		cls.PAY_DIR    = cls.TEST_PAY_DIR
		self:reset(TEST_SERVER)
		if rhand then
			rhand()
		end
		return
	end

	local old = Util:load(Const.CHECK_GAME_URL_KEY)
	if old and old ~= "" then
		for k,url in ipairs(SERVER_BASE_LIST) do
			if old == url then
				self:reset(old)
				if rhand then
					rhand()
				end
				return
			end
		end
	end

	print("*** 开始测试域名")
	self.testRhand = rhand
	self:testGameUrl()
end

function cls:testGameUrl()
	self.testIndex = #SERVER_BASE_LIST
	local func = handler(self, self.testGameUrlRhand)
	for k,base in ipairs(SERVER_BASE_LIST) do
		local http = TestHttp.test(base, func)
		http.index = k
	end
end

function cls:testGameUrlRhand(http)
	print("**** 测试WEB结果:", http.index, http.time)
	if self.testIndex < 1 then
		return
	end

	self.testIndex = self.testIndex - 1

	local index = http.index
	if http.req then
		self.testIndex = 0
	else
		if self.testIndex > 0 then
			return
		end

		index = 1
		print("*** 没有一个域名可用,使用第一个!")
	end

	local base = SERVER_BASE_LIST[index]
	print("*** 使用域名:", base)
	self:reset(base)
	Util:save(Const.CHECK_GAME_URL_KEY, base)

	if self.testRhand then
		self.testRhand()
	end
end

-- 取消上次测试结果
function cls:retest()
	Util:save(Const.CHECK_GAME_URL_KEY, "")
end

return cls