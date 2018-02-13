--
-- Author: lyt
-- Date: 2017-05-22 09:33:36
-- 爱贝支付基础类
local cls = class("IAppPay")

cls.WEB_PAY_URL = "https://web.iapppay.com/pay/gateway?data={1}&sign={2}&sign_type=RSA"

function cls:ctor()
end

function cls:pay(param, rhand)
	self.param = param
	self.rhand = rhand

	if PlatformInfo:isInReview() then
		self:payForSdk()
		return
	end
	
	self:payForWeb()
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
	local iap          = self.param.item.iap
	local rnd          = os.time()
	local str          = string.format("%d_%s_%d_%d_%d_%s_%d", sid, uid, payType, itemId, price, PlatformInfo:getPlatformName(), rnd)

	local product_name = self.param.item.name or ("充值" .. math.ceil(price / 100))

	local data = {
		code      = PlatformInfo:getPlatformName(),
		waresId   = iap,
		cpOrderId = str,
		appuserid = uid,
		price     = math.ceil(price / 100),
		itemName  = product_name,
		info      = str,
	}
	
	local url = URLConfig.IAPPPAY_ORDER
	Http.load(url, handler(self, self.createOrderRhand), nil, nil, nil, nil, data)
end

function cls:createOrderRhand(tid)
	local data = {
		code  = PlatformInfo:getPlatformName(),
		tid   = tid,
	}

	local url = URLConfig.IAPPPAY_ENCRY
	Http.load(url, handler(self, self.createUrlRhand), nil, nil, nil, nil, data)
end

function cls:createUrlRhand(url)
	Api:openUrl(url)
end

return cls