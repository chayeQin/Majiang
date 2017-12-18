--
-- @brief 关闭充值
-- @author: lyt
-- @date 2017/11/14
--
local cls = class("NOPay")

function cls:pay(param, rhand)
	Msg.createMsg("充值已关闭")
end

return cls