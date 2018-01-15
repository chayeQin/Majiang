--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

local cls = class("ServerProxy", require("app.proxy.GameProxy"))

function cls:connectServer(ip, port, rhand, fhand)
	Net:connect("192.168.1.72", "10002", rhand, fhand)
end

function cls:login(uid, nickName, headUrl, rhand)
	Net:call(rhand, "player", "login", uid, nickName, headUrl)
end

-- 获取房间状态
function cls:getRoomStatus(rhand)
	Net:call(rhand, "room", "getRoomStatus", User:getUid())
end

-- 获取游戏状态
function cls:getGameStatus(rhand)
	Net:call(rhand, "room", "getGameStatus", User:getUid())
end

-- uid, count=场次, types=玩法字符串, size=人数
function cls:createRoom(count, types, size, rhand)
	Net:call(rhand, "room", "create", User:getUid(), count, types, size)
end

function cls:joinRoom(rommId, rhand)
	Net:call(rhand, "room", "join", User:getUid(), rommId)
end

function cls:doAction()

end


return cls