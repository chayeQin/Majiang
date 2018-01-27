--
--@brief: 
--@author: qyp
--@date: 2017/12/24
--

local cls = class("PlayView", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/PlayView.csb"

cls.RESOURCE_BINDING = {
}


-- local TABLE_START_POS = {
-- 	-- {x=开始x, y=开始y, delta1=重叠两只之间的距离, delta2=两栋之间距离}
-- 	[0] = {x=890, y=130, delta1=cc.p(0, 10), delta2=cc.p(-39, 0), res="#mjCardBg_2_7.png"},
-- 	[1] = {x=340, y=200, delta1=cc.p(0, 10), delta2=cc.p(0, 28), res="#mjCardBg_2_8.png"},
-- 	[2] = {x=400, y=580, delta1=cc.p(0, 10), delta2=cc.p(39, 0), res="#mjCardBg_2_7.png"},
-- 	[3] = {x=950, y=510,delta1=cc.p(0, 10), delta2=cc.p(0, -28), res="#mjCardBg_2_8.png"}
-- }

-- local PLAYER_CARD_POS = {
-- 	[0] = {x=178.5, y=52, delta=cc.p(71, 0), mType =1},
-- }

-- local OPEN_CARD_POS = { 
-- 	[0] = {x=1220, y=50, delta=cc.p(-48, 0), gDelta=cc.p(-30, 0), mType = 5, z=1},
-- 	[1] = {x=80, y=30, delta=cc.p(0, 28), gDelta=cc.p(0, 20), mType = 6, z=-1},
-- 	[2] = {x=380, y=570, delta=cc.p(40, 0), gDelta=cc.p(10, 0), mType = 7, z=1},
-- 	[3] = {x=1080, y=680, delta=cc.p(0, -28), gDelta=cc.p(0, -20), mType = 8, z=1},
-- }

function cls:ctor()
	cls.super.ctor(self)
	self.nxtOpenCardPos = {}
	self.cardLst = {}
end

function cls:updateUI()
	self.clockBg = display.newSprite("#playscene_img_fx1.png")
	self.clockBg:addTo(self)
	self.clockBg:pos(display.width/2, display.height/2 + 30)

	if true then -- 如果是游戏状态，则还原牌局
		self:initCards()
	else -- 发牌阶段
		self:initTable()
	end

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

function cls:initCards()
	print("******initPlayerCards")

	self.playerCards = PlayerCards.new(1)
	self.playerCards:addTo(self)
	self.playerCards:updateCards()

	self.playerCards = PlayerCards.new(2)
	self.playerCards:addTo(self)
	self.playerCards:updateCards()


	self.playerCards = PlayerCards.new(3)
	self.playerCards:addTo(self)
	self.playerCards:updateCards()


	self.playerCards = PlayerCards.new(4)
	self.playerCards:addTo(self)
	self.playerCards:updateCards()

	local openCards = PlayerOpenCards.new(1)
	openCards:updateCards()
	openCards:addTo(self)


	local openCards = PlayerOpenCards.new(2)
	openCards:updateCards()
	openCards:addTo(self)


	local openCards = PlayerOpenCards.new(3)
	openCards:updateCards()
	openCards:addTo(self)


	local openCards = PlayerOpenCards.new(4)
	openCards:updateCards()
	openCards:addTo(self)


	local tableCards = TableCards.new(1)
	tableCards:updateCards()
	tableCards:addTo(self)


	local tableCards = TableCards.new(2)
	tableCards:updateCards()
	tableCards:addTo(self)

	local tableCards = TableCards.new(3)
	tableCards:updateCards()
	tableCards:addTo(self)	

	local tableCards = TableCards.new(4)
	tableCards:updateCards()
	tableCards:addTo(self)	

	local tmp = ActionTips.new({1,2,3,4})
	tmp:addTo(self)
	tmp:pos(1020, 200)




	-- local cardLst = { 15}
	-- local posInfo = PLAYER_CARD_POS[0]
	-- for i, v in ipairs(cardLst) do
	-- 	local img = Majiang.new(posInfo.mType, v)
	-- 					:addTo(self)
	-- 	local x = posInfo.x + posInfo.delta.x * (i-1)
	-- 	local y = posInfo.y + posInfo.delta.y * (i-1)
	-- 	img:pos(x, y)
	-- end

	-- local openCardLst = {{14, 14, 14, 14}, {13,13, 13,13}, {12, 12, 12, 12}, {11,11,11, 11}}
	-- local playerPos = 0
	-- local openPosInfo = OPEN_CARD_POS[playerPos]
	-- local x = openPosInfo.x 
	-- local y = openPosInfo.y 
	-- for playerPos = 0, 3 do
	-- 	for i, group in ipairs(openCardLst) do
	-- 		self:addOpendCards(playerPos, group)
	-- 	end
	-- end
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

return cls