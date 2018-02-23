--
--@brief: 
--@author: qyp
--@date: 2017/12/24
--

local cls = class("GameModel")

--当局的骰子点数
function cls:getDiceNum()
	return 2
end

--庄家位置
function cls:getBankerPos()
	return 1
end

function cls:getPlayerPos()
	return 3
end

function cls:getTotalCount()
	return 136
end

function cls:getLeftCount()
	return 136
end

-- 手牌
function cls:getPlayerCards(tablePos)
	return {12, 12, 12, 12, 11,11, 11, 12, 12, 12, 12, 11,11, 11}
end

-- 杠碰的牌
function cls:getOpendCars(tablePos)
	return {{14, 14, 14, 14}, {13,13, 13,13}}
end

-- 打出去的牌
function cls:getTableCards(tablePos)
	return {12, 12, 12, 12, 11,11, 11, 12, 12, 12, 12, 11,11, 11, 13,13, 13,13, 15,15,15}
end

-- 玩家出牌阶段
function cls:isPlayerSendCard()
	return false
end


return cls