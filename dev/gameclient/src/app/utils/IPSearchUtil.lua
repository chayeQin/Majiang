--
-- Author: lyt
-- Date: 2017-02-09 09:30:15
-- IP查询
local cls = class("IPSearchUtil")

function cls:ctor(ip)
	self.ip = ip

	-- if not ip or ip == "" then
	-- 	return
	-- end

	-- self.saveKey = "IP" .. ip
	-- -- 上次查询记录
	-- local isSave = Util:load(self.saveKey)
	-- if isSave then
	-- 	return
	-- end

	-- 查询IP
	-- local url = "http://ip.taobao.com/service/getIpInfo.php?ip=" .. ip
	local url = "http://ip.taobao.com/service/getIpInfo.php?ip=myip"
	Http.load(url, handler(self, self.searchRhand), false, function()end, nil, false)
end

function cls:searchRhand(str)
	self.str = str
	local data = json.decode(str)
	if not data or data.code ~= 0 or not data.data.country_id then
		return
	end

	local ip         = data.data.country_id or ""
	local country_id = data.data.country_id or ""
	local country    = data.data.country or ""
	local str        = string.format("%s_%s_%s_%s", ip, country_id, country, "jyxgamemd5test")
	local key        = Crypto.md5(str)
	local param = {
		ip         = ip,
		country_id = country_id,
		country    = country,
		key        = string.upper(key),
	}
	Util:save("ipParam",param)

	self.param = param
	Http.load(URLConfig.FORMAT_IP_PUSH, handler(self, self.postRhand), false, function()end, nil, false, param)
end

function cls:postRhand(str)
	if str ~= "ok" then
		print("*** post ip error")
		return
	end

	Util:save(self.saveKey, self.param)

end

return cls