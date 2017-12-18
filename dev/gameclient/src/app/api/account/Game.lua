--
-- @brief PC登陆API
-- @author qyp
-- @date 2015/09/07
--
local cls = class("Game")

function cls:call(method, params)
    self[method](self, params)
end

-- PC 登录
function cls:login(rhand)
    print(">>>>>>>>>PC SDK 登录")
    self.rhand_ = rhand
    local username = Util:load("reg_username")
    if not username then -- 新用户
        LoginCtrl:showLoginView()
        return
    end
    username = string.lower(username)
    local password = Util:load("reg_password") or ""
    LoginCtrl:login(username, password, rhand, function()
        LoginCtrl:showLoginView()
    end)
end

function cls:onLoginFail()
end

return cls