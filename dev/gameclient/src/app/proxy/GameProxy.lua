--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 代理接口，与服务端通信或者客户端自己模拟
--

local cls = class("GameProxy")

function cls:connectServer(ip, port, rhand, fhand)
	print("***GameProxy:connectServer")
end

function cls:register(userName, password, rhand)
end

function cls:login(userName, password, rhand)
end

function cls:getGameState()
end

return cls