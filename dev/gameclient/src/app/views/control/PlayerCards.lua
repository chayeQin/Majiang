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

function cls:ctor(tablePos)
	self.cards = {}
	self.tablePos = tablePos
	self.selectedIndex = nil
	self:onTouch(handler(self, self.onTouchHandler))
	self:enableNodeEvents()
end

function cls:onEnter()
	-- 监听手牌变化
end

function cls:updateCards()
	for _, v in ipairs(self.cards) do
		v:remove()
	end
	self.cards = {}
	local cardLst = GameModel:getPlayerCards(self.tablePos)
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

	self:adjustPos()
end

function cls:adjustPos()
	if self.tablePos == 1 then 
		-- TODO: 根据杠，碰的牌调整位置
		self:pos(display.width / 2 - self.delta.x * self:getCardCount() / 2, 0)
	elseif self.tablePos == 2 then
		self:pos(130, display.height / 2 - self.delta.y * self:getCardCount() / 2)
	elseif self.tablePos == 3 then
		self:pos(display.width / 2 - self.delta.x * self:getCardCount() / 2,  display.height - 60)
	elseif self.tablePos == 4 then
		self:pos(display.width - 130, display.height / 2 - self.delta.y * self:getCardCount() / 2)
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
			if GameModel:isPlayerSendCard() then -- 玩家出牌阶段, 点击同一个牌打出去
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
