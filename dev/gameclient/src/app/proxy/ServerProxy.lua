--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

local cls = class("ServerProxy")

function cls:connectServer(ip, port, rhand, fhand)
	Net:connect(ip, port, rhand, fhand)
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

function cls:ready(rhand)
	print("**************ready")
	Net:call(rhand, "room", "prepare", User:getUid())
end

function cls:start(rhand)
	Net:call(rhand, "room", "start", User:getUid())
end

function cls:doAction(actType, cardLst, rhand)
	Net:call(rhand, "room", "doAction", User:getUid(), actType, cardLst)
end

function cls:sendChat(content,rhand)
	Net:call(rhand,"room","chat",User:getUid(),content)
end

function cls:dismiss(rhand, param)
	Net:call(rhand, "room", "exit", User:getUid(), param)
end

return cls