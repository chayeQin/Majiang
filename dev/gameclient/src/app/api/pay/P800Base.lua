--
-- Author: lyt
-- Date: 2017-04-20 14:49:44
--
local cls = class("P800Base")

cls.URL = "http://recharge.iwantang.com/yhbz"

local P800Msg = import(".P800Msg")

function cls:ctor(site, key, aid)
	self.site = site
	self.key  = key      
	self.aid  = aid      
end

function cls:pay(param, rhand)
	self.param = param
	self.rhand = rhand

	if PlatformInfo:isInReview() then
		self:payForSdk()
		return
	end
	
	P800Msg.new(self)
end

function cls:payForSdk()
	Api:call("SDK","pay", self.param, self.rhand)
end

function cls:payForWeb()
	local sid          = self.param.sid
	local uid          = self.param.uid
	local payType      = self.param.item.payType
	local itemId       = self.param.item.id
	local price        = self.param.item.price
	local rnd          = os.time()
	local str          = string.format("%d_%s_%d_%d_%d_%s_%d", sid, uid, payType, itemId, price, PlatformInfo:getPlatformName(), rnd)
	local product_name = self.param.item.name or ("充值" .. math.ceil(price / 100))
	local param = {
		site         = self.site,
		key          = self.key,
		aid          = self.aid,
		uid          = PlatformInfo:getPlatformUid(),
		cp_order_id  = str,
		roleid       = PlatformInfo:getPlatformUid(),
		rolename     = string.urlencode(self.param.uname),
		serverid     = sid,
		servername   = string.urlencode(self.param.sname),
		money        = math.ceil(price / 100),
		productid    = self.param.item.iap,
		product_name = string.urlencode(product_name),
		ext          = str,
	}

	local url = cls.URL .. "?"
	for k,v in pairs(param) do
		url = url .. k .."=" .. v .. "&"
	end
	url = url .. "v=" .. os.time()

	Api:openUrl(url)
end

return cls