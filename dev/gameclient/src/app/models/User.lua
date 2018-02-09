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
   roomType: 房间类型
   maxCount: 场次
   types: 玩法字符串
   maxSize: 人数
   players: 房间内的玩家列表
    index: 玩家所在位置
    uid: 玩家uid
    state: 玩家的状态  false=未准备;true=准备;
    nickname: 玩家昵称
    headimgurl: 玩家的头像

推送-游戏信息更新
   roomId: 房间id
   status: 房间状态
   roomType: 房间类型
   maxCount: 场次
   types: 玩法字符串
   maxSize: 人数
   count: 当前场次
   bankerIndex: 庄家下标
   librarySize: 剩余的牌堆数量
   baopai: 宝牌
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
   setts: 房间的结算数据
    uid: 玩家uid
    score: 分数列表（胡分、杠分、总计）
    type: 类型;1=自摸;2=胡牌;3=放炮

]]
local test_table_pos = false


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
	Util:event(Event.gameInfoUpdate)
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

function cls:getPlayerCards(playerIndex)
	if test_table_pos then
		return {
			1,2,3,
			1,2,3,
			1,2,3,
			1,2,3,
			1,2
		}
	end
	if not self.gameInfo or not self.gameInfo.players then
		return {}
	end

	for _, v in pairs(self.gameInfo.players) do
		if v.index == playerIndex then
			return v.hand
		end
	end
	return {}
end

-- 玩家自己所在的位置
function cls:getUserIndex()
	for _, v in pairs(self.roomInfo.players) do
		if v.uid == self.info.uid then
			return v.index
		end
	end
end

function cls:getOpenedCards(playerIndex)
	if test_table_pos then
		return {
			{1,1,1,1}, 
			{1,1,1,1}, 
			{1,1,1,1}, 
			{1,1,1,1}
		}
	end
	if not self.gameInfo or not self.gameInfo.players then
		return {}
	end

	for _, v in pairs(self.gameInfo.players) do
		if v.index == playerIndex then
			return v.top
		end
	end
	return {}
end

function cls:getTableCards(playerIndex)
	if test_table_pos then
		return {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1}
	end
	if not self.gameInfo or not self.gameInfo.players then
		return {}
	end

	for _, v in pairs(self.gameInfo.players) do
		if v.index == playerIndex then
			return v.lose
		end
	end
	return {}
end

function cls:getUserCardInfo()
	if not self.gameInfo or not self.gameInfo.players then
		return 
	end

	for _, v in pairs(self.gameInfo.players) do
		if v.uid == self.info.uid then
			return v
		end
	end
	return 
end

function cls:getPlayerCardInfoByIndex(playerIndex)
	if test_table_pos then
		return {actions={}, uid = self.info.uid} 
	end
	if not self.gameInfo or not self.gameInfo.players then
		return 
	end

	for _, v in pairs(self.gameInfo.players) do
		if v.index == playerIndex then
			return v
		end
	end
	return 
end

-- 房间规则(人数)
function cls:getMaxSize()
	return self.roomInfo.maxSize
end

-- 房间规则(玩法)
function cls:getPlayTypes()
	return self.roomInfo.types
end

-- 房间规则(场次)
function cls:getMaxCount()
	return self.roomInfo.maxCount
end

return cls
