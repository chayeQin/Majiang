--
--@brief 账号信息
--@author qyp
--@date 2015/8/13
--

local cls = class("PlatformInfo")

function cls:ctor()
	self.platInfo = {}
end

function cls:init(platInfo)
	self.isInited         = true
	self.platInfo         = platInfo
	self.serverList       = platInfo.d
	self.cdn              = platInfo.u
	self.uid              = 0
	self.bindLoginSdkData = {}

	print("*** cnd", platInfo.u)
	
	table.sort(self.serverList, function(v1, v2)
		return v1.t < v2.t
	end)
end

--@brief 平台
--[[{
	name,
	version,
	mac,
	showExit,
	isTw,
}--]]
function cls:setPlatform(platform)
	self.platform = platform
end

function cls:getPlatform()
	return self.platform
end

--@brief 设备uid
function cls:getPlatformUid()
	return self.platUid
end

function cls:setPlatformUid(pUid)
	self.platUid = pUid
end

--@brief 设备ID
function cls:setDeviceId(idfa)
	self.idfa = idfa
end

--@brief 服务器列表
function cls:getServerList()
	return self.serverList
end

function cls:getPlatformName()
	return self.platform.name
end

function cls:getPlatformVersion()
	return self.platform.version
end

function cls:getPlatformMac()
	return self.platform.mac
end

function cls:isShowPlatformExit()
	return self.platform.showExit
end

function cls:getPayApi()
	return self.platInfo.pay
end

function cls:getLoginApi()
	return self.platInfo.login
end

--@brief 是否在审核
function cls:isInReview()
	if IN_REVIEW then
		return true
	end
	
	return self.platInfo.inreview
end

-- 服务器维护信息
function cls:getMessage()
	return Lang:find("server_maintenance", self.platInfo.m)
end

-- 客服信息
function cls:getQQ()
	return self.platInfo.qq
end

-- 获取CND列表
function cls:getCdnList()
	if true then
		return {CDN_URL}
	end
	local str = self.platInfo.u
	str = string.gsub(str, "[\r\n]","[br]")
	local list = string.split(str, "[br]")
	for i = #list, 1, -1 do
		local url = list[i]
		if url == "" or
			string.len(url) < 5 or
			string.upper(string.sub(url,1,4)) ~= "HTTP" then

			table.remove(list, i)
		elseif string.sub(url,#url) ~= "/" then
			list[i] = url .. "/"
		end
	end

	return list
end

--@brief 白名单
function cls:isWhiteUser()
	return self.platInfo.v == 1
end

--@brief sdk登陆参数
function cls:setSdkParam(param)
	if not param then
		self.sdkParam = nil
		return
	end
	self.sdkParam = {}
	for k, v in ipairs(param) do
		self.sdkParam[k] = tostring(v)
	end
end

function cls:getSdkParam()
	return self.sdkParam
end

--@brief
function cls:setSession(session)
	self.session = session
end

function cls:getSession()
	return self.session
end

--@brief 选择服务器,
function cls:selectServer(serverId)
	for _, v in ipairs(self.serverList) do
		if v.t == serverId then
			self.serverInfo = v
		end
	end
end

function cls:getServerById(serverId)
	for _, v in ipairs(self.serverList) do
		if v.t == serverId then
			return v
		end
	end	
end

--@brief 当前服务器信息
--[[return serverInfo
serverInfo.t 服务器id
serverInfo.i 服务器ip
serverInfo.p 服务器端口pid
serverInfo.n 服务器名字
serverInfo.s 服务器状态 (-1:维护)
]]
function cls:getServerInfo()
	if self.serverInfo == nil and self.serverList then
		return self.serverList[#self.serverList]
	end

	return self.serverInfo
end

function cls:getServerId()
	return self:getServerInfo().t
end

function cls:getServerIp()
	return self:getServerInfo().i
end

function cls:getServerPort()
	return self:getServerInfo().p
end

function cls:getServerName()
	return self:getServerInfo().n
end

function cls:getServerStatus()
	return self:getServerInfo().s
end

function cls:setUid(uid)
	self.uid = uid
end

function cls:getUid()
	return self.uid
end

-- 初始绑定平台的ID
function cls:initBind(data)
	self.bindLoginSdkData = data or {}
end

-- 绑定的某SDK的UID
function cls:bindUserId(name)
	return self.bindLoginSdkData[name]
end

-- 设置SDK绑定的ID
function cls:setBindUserId(name, id)
	self.bindLoginSdkData[name] = id
end

-- 游戏运行版本号
function cls:getVer()
	local result = "1.0.0:0"
    local ver = cc.FileUtils:getInstance():getStringFromFile(UPDATA_VER)
    if not ver or ver == "" then
    	return result
    end

    ver = json.decode(ver)
    if not ver then
    	return result
    end

    result = ver.ver .. ":" .. ver.code

    return result
end

function cls:clear()
	self.platform = nil
	self.idfa = ""
	self.payApi = ""
	self.loginApi = ""
	self.inreview = nil
	self.sdkParam = nil
	self.serverList = {}
end

return cls
