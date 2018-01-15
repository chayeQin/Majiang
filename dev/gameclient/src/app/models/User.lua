--
-- Author: qyp
-- Date: 2017/12/13
-- Brief: 
--

local cls = class("User")

--[[ 
用户信息 info
 "headimgurl" = ""
 "nickname"   = "ae3vze31ach"
 "num"        = 4  				
 "uid"        = "ae3vze31ach"


房间信息 roomInfo
  roomId: 房间id 
  status: 房间状态
  players: 房间内的玩家列表
	[
	  index: 玩家所在位置
	  uid: 玩家uid
	  state: 玩家的状态
	  nickname: 玩家昵称
	  headimgurl: 玩家的头像
	]
]]

function cls:ctor()
	self.info = {}
	self.roomId = -1
	self.roomInfo = {}
	self.gameInfo = {}
end

function cls:setUserInfo(info)
	self.info = info
end

function cls:getUid()
	return self.info.uid or ""
end

function cls:setRoomId(id)
	self.roomId = id
end

function cls:getRoomId()
	return self.roomId
end

function cls:setRoomInfo(info)
	self.roomInfo = info
end

function cls:getRoomInfo()
	return self.roomInfo
end

function cls:setGameInfo(info)
	self.gameInfo = {}
end


function cls:getGameInfo()
	return self.gameInfo
end

-- 玩家是否在房间中
function cls:isInRoom()
	return self.roomId and self.roomId ~= -1
end

-- 牌局是否开始
function cls:isGameStart()
	return self.roomInfo.status
end


return cls