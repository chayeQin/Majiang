--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

local cls = class("TableCards", cc.load("mvc").ViewBase)

local function calCol(delta, i, count)
	return ((i-1) % count) *  delta
end

local function calRow(delta, i, count)
	return math.floor((i-1)/count) * delta
end

cls.POS_DELTA = {
	{calDeltaX=handler(52, calCol), calDeltaY = handler(-58, calRow)},
	{calDeltaX=handler(-66, calRow), calDeltaY = handler(-40, calCol)},
	{calDeltaX=handler(-52, calCol), calDeltaY = handler(58, calRow)},
	{calDeltaX=handler(66, calRow), calDeltaY = handler(40, calCol)},
}

-- 两人16只一排， 3人以上10只一排
function cls:ctor(tablePos, playerIndex, colCount)
	cls.super.ctor(self)
	self.cards = {}
	self.tablePos = tablePos
	self.playerIndex = playerIndex

	local tmpColCountMap = {
		14,5,14,5
	}
	self.colCount = colCount or tmpColCountMap[tablePos]

	self.selectedImg = Util:sprite("majiang/img_01")
							:addTo(self)
							:zorder(9999)
							:anchor(0.5, 0)
							:hide()
	self.selectedImg:run{"rep",
							{"seq",
								{"moveby", 0.5, cc.p(0, 15)},
								{"moveby", 0.5, cc.p(0, -15)},
							}
						}

	self:enableNodeEvents()
end

function cls:onEnter()
	--监听手牌变化
	self.onUpdateHandle = Util:addEvent(Event.gameInfoUpdate, handler(self, self.updateCards))
	self.onTipsCardsHandle = Util:addEvent(Event.tipsSendCard, handler(self, self.onTipsCards))
end

function cls:onExit()
	Util:removeEvent(self.onUpdateHandle)
	Util:removeEvent(self.onTipsCardsHandle)
end

function cls:onTipsCards(event)
	local card = event.params[1]
	for _, v in ipairs(self.cards) do
		if card and v.num == card then
			v:showBlueShadow(true)
		else
			v:showBlueShadow(false)
		end
	end
end

function cls:updateCards()
	for _, v in ipairs(self.cards) do
		v:remove()
	end
	self.cards = {}

	local cardLst = User:getTableCards(self.playerIndex)
	self.delta = cls.POS_DELTA[self.tablePos]
	for i, v in ipairs(cardLst) do
		local x = self.delta.calDeltaX(i, self.colCount) 
		local y = self.delta.calDeltaY(i, self.colCount) 
		local img = Majiang.new(self.tablePos+8, v)
						:addTo(self)
		img:pos(x, y)
		img:zorder(display.height-y)
		table.insert(self.cards, img)
	end

	local outPlayer = User:getPlayerCardInfoByIndex(User.gameInfo.outIndex) -- 当前出牌的玩家
	local hadOut = true
	if outPlayer then
		for _, v in ipairs(outPlayer.actions) do
			if v == ActionTips.ACTION_TYPE_CHUPAI then -- 玩家还没有出牌
				hadOut = false
				break
			end
		end
	end

	local lastCard = self.cards[#self.cards]
	if hadOut then -- 已经出牌了就指示玩家最后出的那张牌
		if lastCard and User.gameInfo.outIndex == self.playerIndex then
			self.selectedImg:show()
			local p = cc.pAdd(lastCard:pos(), cc.p(27, 80))
			self.selectedImg:pos(p)
		else
			self.selectedImg:hide()
		end
	else -- 指示上一个玩家打的最后一张牌
		-- 上一个玩家的Index
		local index = User.gameInfo.outIndex - 1
		if index == -1 then
			index = #User.gameInfo.players - 1
		end
		if lastCard and index == self.playerIndex then
			self.selectedImg:show()
			local p = cc.pAdd(lastCard:pos(), cc.p(27, 80))
			self.selectedImg:pos(p)
		else
			self.selectedImg:hide()
		end

	end


	self:adjustPos()

end

function cls:adjustPos()
	if self.tablePos == 1 then 
		self:pos(275, 210)
	elseif self.tablePos == 2 then
		self:pos(460, 450)
	elseif self.tablePos == 3 then
		self:pos(1005, 510)
	elseif self.tablePos == 4 then
		self:pos(750, 290)
		-- sel:pos(display.width - 130, display.height / 2 - self.delta.y * self:getCardCount() / 2)
	end
end

function cls:addCard()

end

function cls:removeCard()
end

return cls