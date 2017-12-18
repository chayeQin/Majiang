--
-- @brief 测试使用的支付
-- @author: qyp
-- @date 2015/09/07
--

local cls = class("Empty")

-- itemType, 1充值, 2礼包
-- SDK支付自定义订单拼接 sid_uid_num_type_code_time
function cls:pay(param, rhand)
	local productId,itemType = param.item.id, param.item.payType

	local sid = PlatformInfo:getServerId()
	local uid= User.info.uid
	local url = URLConfig.FORMAT_SDK_PAY
	--pcpay?sid=%d&uid=%s&num=%d&item=%d
	url = string.format(url, GAME_NAME, Lang:getLang(), sid, uid, productId, itemType)
	print("*** 测试充值",url)
	Http.load(url, function(str)
		local jsonObj = json.decode(str)
		if jsonObj == -1 then
			print("充值失败")
		elseif jsonObj == 1 then
			print("充值成功")
		end
	end)
end

function cls:getRandomString(len)
    local str=""
    for i=1,len do 
        str=str .. string.char(64 + math.random(1,26))
    end
    return str
end

return cls