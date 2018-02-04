--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

local cls = class("PlayerCards", cc.load("mvc").ViewBase)

cls.POS_DELTA = {
	[1] = cc.p(70, 0),
	[2] = cc.p(0, -20),
	[3] = cc.p(-32, 0),
	[4] = cc.p(0, 20),
}

function cls:ctor(tablePos, playerIndex)
	cls.super.ctor(self)
	self.cards = {}
	self.tablePos = tablePos
	self.playerIndex = playerIndex
	self.selectedIndex = nil
	self:onTouch(handler(self, self.onTouchHandler))
	self:enableNodeEvents()
end

function cls:onEnter()
	-- 监听手牌变化
	self.onUpdateHandle = Util:addEvent(Event.gameInfoUpdate, handler(self, self.updateCards))
end

function cls:onExit()
	Util:removeEvent(self.onUpdateHandle)
end

function cls:updateCards()
	local info = User:getPlayerCardInfoByIndex(self.playerIndex)

	if not info then
		return
	end

	for _, v in ipairs(self.cards) do
		v:remove()
	end
	self.cards = {}
	local cardLst = User:getPlayerCards(self.playerIndex)
	table.sort(cardLst, function(v1, v2)
		return v1 < v2
	end)



	self.selectedIndex = nil
	self.delta = cls.POS_DELTA[self.tablePos]
	for i, v in ipairs(cardLst) do
		local img = Majiang.new(self.tablePos, v)
						:addTo(self)
		local x = self.delta.x * (i-1)
		local y = self.delta.y * (i-1)
		img:pos(x, y)
		img:zorder(display.height - y)
		table.insert(self.cards, img)
	end

	local isPlayerSendCard = false
	for _, v in pairs(info.actions) do
		if v == ActionTips.ACTION_TYPE_CHUPAI then
			isPlayerSendCard = true
			break
		end
	end
	if info.uid == User.info.uid and isPlayerSendCard then -- 如果是玩家出牌阶段
		local origX = self.cards[#self.cards]:x()
		self.cards[#self.cards]:x(origX + 15)
	end

	self:adjustPos()
end

function cls:adjustPos()
	-- TODO: 根据杠，碰的牌调整位置

	if self.tablePos == 1 then 
		local x = display.width / 2 - self.delta.x * self:getCardCount() / 2
		local cardLst = User:getOpenedCards(self.playerIndex)
		x = x + #cardLst*60
		self:pos(x, 0)
	elseif self.tablePos == 2 then
		print("*****adjust pos")
		local y = display.height / 2 - self.delta.y * self:getCardCount() / 2
		local cardLst = User:getOpenedCards(self.playerIndex)
		y = y -  #cardLst*57
		self:pos(130, y)
	elseif self.tablePos == 3 then
		local x = display.width / 2 - self.delta.x * self:getCardCount() / 2

		local cardLst = User:getOpenedCards(self.playerIndex)
		x = x - #cardLst*60
		self:pos(x,  display.height - 60)
	elseif self.tablePos == 4 then
		local y = display.height / 2 - self.delta.y * self:getCardCount() / 2
		local cardLst = User:getOpenedCards(self.playerIndex)
		y = y + #cardLst*57
		self:pos(display.width - 130, y)
	end
end


function cls:getCardCount()
	return #self.cards
end

function cls:onTouchHandler(event)
	if self.tablePos ~= 1 then 
		return
	end

	if GameModel:isListening() then -- 听牌中不准操作手牌
		return
	end

	if event.name == "began" then
		local np = self:convertToNodeSpace(event)
		if np.y > 105 or np.x < 0 then
			if self.selectedIndex then
				self.cards[self.selectedIndex]:y(0)
			end
			self.selectedIndex = nil
			return
		end

		local selectedIndex = math.floor(np.x / self.delta.x) + 1
		if self.selectedIndex and selectedIndex == self.selectedIndex then
			-- 玩家可以操作
			local isHasAction = false
			for _, v in ipairs(User.gameInfo.waitPlayers) do
				if v == User.info.uid then
					isHasAction = true
					break
				end
			end

			if isHasAction and User.gameInfo.outIndex == User:getUserIndex() then -- 玩家出牌阶段, 点击同一个牌打出去
				local num = self.cards[self.selectedIndex].num
				GameProxy:doAction(ActionTips.ACTION_TYPE_CHUPAI, {num})
			else
				self.cards[self.selectedIndex]:y(0)
			end
			self.selectedIndex = nil
			return
		end

		if self.selectedIndex and selectedIndex > #self.cards then
			self.cards[self.selectedIndex]:y(0)
			self.selectedIndex = nil
			return 
		end

		if self.selectedIndex then
			self.cards[self.selectedIndex]:y(0)
		end


		self.cards[selectedIndex]:y(30)
		self.selectedIndex = selectedIndex
		return true
	elseif event.name == "moved" then
	elseif event.name == "ended" then
	end
end


return cls
