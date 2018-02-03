--
--@brief: 
--@author: qyp
--@date: 2017/12/24
--

local cls = class("PlayView", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/PlayView.csb"

cls.RESOURCE_BINDING = {
}

function cls:ctor()
	cls.super.ctor(self)
	self.nxtOpenCardPos = {}
	self.cardLst = {}
end

function cls:onEnter()
	self.gameUpdateHandle = Util:addEvent(Event.gameInfoUpdate, handler(self, self.onGameUpdate))
end

function cls:onExit()
	Util:removeEvent(self.gameUpdateHandle)
end

function cls:onGameUpdate()
end

function cls:updateUI()
	self.clockBg = display.newSprite("#playscene_img_fx1.png")
	self.clockBg:addTo(self)
	self.clockBg:pos(display.width/2, display.height/2 + 30)
	self:initCards()
end

function cls:initCards()
	print("******initPlayerCards")


	local indexMap = {}
	local orig = 0
	local sortKey = orig
	-- 找出玩家自己的位置
	for i, v in ipairs(User.roomInfo.players) do
		if v.uid == User.info.uid then
			sortKey = sortKey - 4
			if not v.state then -- 未准备
				GameProxy:ready()
			end
		else
			sortKey = sortKey + 1
		end
		indexMap[i] = {i, sortKey}
	end
	table.sort(indexMap, function(v1, v2)
		return v1[2] < v2[2]
	end)

	local posMap = {}
	if User.roomInfo.maxSize == 2 then
		posMap[1] = 1
		posMap[2] = 3
	else 
		posMap = {1,2,3,4}
	end

	for i, v in ipairs(indexMap) do
		local tablePos = posMap[i]
		local info = User.roomInfo.players[v[1]]
		print("***tablepos", tablePos)
		local playerCards = PlayerCards.new(tablePos, info.index)
		playerCards:addTo(self)
		playerCards:updateCards()

		local openCards = PlayerOpenCards.new(tablePos, info.index)
		openCards:updateCards()
		openCards:addTo(self)

		local tableCards = TableCards.new(tablePos, info.index)
		tableCards:updateCards()
		tableCards:addTo(self)	
	end

	local tmp = ActionTips.new()
	tmp:addTo(self)
	tmp:pos(1020, 200)


end

function cls:adjustPlayerCardPos()
end

function cls:addOpendCards(playerPos, cards)
	local startPos = self.nxtOpenCardPos[playerPos]
	local openPosInfo = OPEN_CARD_POS[playerPos]

	for j, v in ipairs(cards) do
		local img = Majiang.new(openPosInfo.mType, v)
						:addTo(self)
		img:pos(startPos.x, startPos.y)
		if openPosInfo.z == -1 then
			img:zorder(display.height - startPos.y)
		end
		if playerPos == 0 then
			img:scale(1.2)
		end
		startPos.x = startPos.x + openPosInfo.delta.x
		startPos.y = startPos.y + openPosInfo.delta.y 
	end
	startPos.x = startPos.x + openPosInfo.gDelta.x
	startPos.y = startPos.y + openPosInfo.gDelta.y
	self.nxtOpenCardPos[playerPos] = startPos
end


-- 初始化还没摸的牌局
function cls:initTable()
	-- 剩余x 张牌
	local startPos = self:getStartPos()
	for i = 1, 4 do
		local k = (startPos + i - 1) % 4
		local tableStartPos = TABLE_START_POS[k]
		for j =1, 34 do
			local col = math.floor((j-1) / 2)
			local row = (j-1) % 2
			local startP = cc.p(tableStartPos.x, tableStartPos.y)
			local p = cc.pAdd(startP, cc.pMul(tableStartPos.delta2, col))
			local tmpP = cc.pMul(tableStartPos.delta1, row)
			local pos = cc.pAdd(p, tmpP)
			local img = display.newSprite(tableStartPos.res)
							:addTo(self)
							:pos(pos)
			if k == 1 then
				img:zorder(20-col)
			end
		end
	end

end

-- 获取从哪个玩家的位置开始摸牌
function cls:getStartPos()
	local diceNum = GameModel:getDiceNum() -- 玩家x开局的骰子摇到y
	-- 位置定义，顺时针 0,1,2,3 （东南西北）
	local bankerPos = GameModel:getBankerPos() -- 庄家位置
	local playerPos = GameModel:getPlayerPos()-- 玩家位置

	-- 在玩家视角(以玩家作为东风)， 庄家的位置所在
	local realBankerPos = bankerPos - playerPos
	if realBankerPos < 0 then
		realBankerPos = 4 - realBankerPos
	end
	local tmp = (diceNum + realBankerPos -1) % 4

	return tmp
end


return cls