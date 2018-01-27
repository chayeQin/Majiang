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
 "num"        = 4  		房卡数		
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

推送-游戏信息更新
  消息类型t: 102
  内容:
   roomId: 房间id
   status: 房间状态
   count: 当前场次
   bankerIndex: 庄家下标
   librarySize: 剩余的牌堆数量
   players: 房间内的玩家列表
   index: 玩家所在位置
   uid: 玩家uid
   hand: 玩家手牌(list)
   lose: 玩家丢弃的牌(list)
   top: 头顶上特殊处理的牌 (list[])
   listen: 是否听牌了
   socre: 当前分数
   actions: 玩家可以有的操作[吃,碰,杠,胡,听] 
   outIndex: 出牌的人
   outCard: 出牌的牌

]]

function cls:ctor()
	self.info = {}
	self.roomId = nil
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
	self:setRoomId(info and info.roomId or "")
	Util:event(Event.roomInfoUpdate)
end

function cls:getRoomInfo()
	return self.roomInfo
end

function cls:setGameInfo(info)
	self.gameInfo = info
end


function cls:getGameInfo()
	return self.gameInfo
end

-- 玩家是否在房间中
function cls:isInRoom()
	print("self.roomId", self.roomId)
	if self.roomId and self.roomId ~= "" and self.roomId ~= "-1" then
		return true
	end
end

-- 牌局是否开始
function cls:isGameStart()
	return self.roomInfo.status
end

return cls
