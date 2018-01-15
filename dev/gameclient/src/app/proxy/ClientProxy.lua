--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

local cls = class("ClientProxy", require("app.proxy.GameProxy"))

function cls:connectServer(ip, port, rhand, fhand)
end

function cls:register(userName, password, rhand)
end

function cls:login(userName, password, rhand)
end


return cls