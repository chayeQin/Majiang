--
-- @brief 推送消息处理器
-- @author qyp
-- @date 2015/09/18
--

local cls = class("NotifyHandler")


-- 注册服务器推送事件
cc.exports.NotifyEvent = {
	errorMsg 						= "100",   -- 错误信息
	update_room						= "101",   -- 更新房间
	update_game 					= "102",   -- 更新游戏信息
	do_action						= "103",   -- 执行动作
	chat							= "104",   -- 聊天
}

-- 输出推送信息
local DEBUG_NOTIFY = {
	["activity_update"] = true,
}

function cls.handleEvent(v, msg)
	dump(v)
	local strType = tostring(v.t)
	local func = NotifyEvent.MAP[strType]
	print("***收到推送", strType)
	if func then
		func(NotifyHandler, v)
	else
		print("ERROR***  客户端添加推送事件！！！！  " , strType)
	end
end

function cls:errorMsg(v)
	print("ERROR**** receive Error Msg", v.r)
	Util:event(Event.netError, v)
	Tips.show(v.r)
end

-- 房间信息推送
function cls:update_room(v)
	dump(v)
	User:setRoomInfo(v.r)
end

function cls:update_game(v)
	dump(v)
	User:setGameInfo(v.r)
end

function cls:do_action(v)
	dump(v)
	Util:event(Event.doAction, v.r)
end

function cls:chat(v)
	local uid = v[1]
	local content = v[2]
	dump(v)
end

-- 将TYPE转为function
NotifyEvent.MAP = {}
for key, eventType in pairs(NotifyEvent) do
	NotifyEvent.MAP[eventType] = cls[key]
end

return cls