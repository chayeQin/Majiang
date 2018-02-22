--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

local cls = class("PlayerCards", cc.load("mvc").ViewBase)

cls.POS_DELTA = {
	[1] = cc.p(86, 0),
	[2] = cc.p(0, -26),
	[3] = cc.p(-36, 0),
	[4] = cc.p(0, 26),
}

function cls:ctor(tablePos, playerIndex)
	cls.super.ctor(self)
	self.cards = {}
	self.tablePos = tablePos
	self.playerIndex = playerIndex
	self.selectedIndex = nil
	self.isInited = false
	self:onTouch(handler(self, self.onTouchHandler))
	self:enableNodeEvents()
end

function cls:onEnter()
	-- 监听手牌变化
	self.onUpdateHandle = Util:addEvent(Event.gameInfoUpdate, handler(self, self.updateCards))
	self.tingHandle = Util:addEvent(Event.playerTing, handler(self, self.onTing))
end

function cls:onExit()
	Util:removeEvent(self.onUpdateHandle)
	Util:removeEvent(self.tingHandle)
end

function cls:onTing(event)
	local datas = event.params[1]
	local info = User:getPlayerCardInfoByIndex(self.playerIndex)
	if info.uid ~= User.info.uid then
		return
	end

	if datas then
		dump(datas, "ting cards map")
		self.tingCardsMap = datas
		local tingCardLst = {}

		for _, v in pairs(self.cards) do
			if v.num and datas[v.num] then
				table.insert(tingCardLst, v)
			end
		end
		self:updateShadow(tingCardLst)
	else
		self:updateShadow()
	end
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
		local val1 = v1 > 10 and v1 or v1 + 40  -- 花牌排最后
		local val2 = v2 > 10 and v2 or v2 + 40
		return val1 < val2
	end)

	local isPlayerSendCard = false
	for _, v in pairs(info.actions) do
		if v == ActionTips.ACTION_TYPE_CHUPAI then -- 玩家出牌阶段
			isPlayerSendCard = true
			break
		end
	end

	if self.isInited and 
	info.uid == User.info.uid and 
	isPlayerSendCard then -- 如果是玩家出牌阶段
		local tmpIndex = nil
		for i, v in ipairs(cardLst) do
			if v == User.gameInfo.getCard then
				tmpIndex = i
				break
			end
		end

		if tmpIndex then -- 刚摸回来的牌放最后
			local tmp = cardLst[tmpIndex]
			table.remove(cardLst, tmpIndex)
			table.insert(cardLst, tmp)
		end
	end

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

	if info.uid == User.info.uid and isPlayerSendCard then -- 如果是玩家出牌阶段
		local origX = self.cards[#self.cards]:x()
		self.cards[#self.cards]:x(origX + 15)
	end

	if info.uid == User.info.uid and info.listen then -- 玩家听牌中, 自动打牌
		self:updateShadow(self.cards)
		local isHu = false
		for _, v in pairs(info.actions) do
			if v == ActionTips.ACTION_TYPE_HU then
				isHu = true
				break
			end
		end 
		if isPlayerSendCard and not isHu then
			Util:tick(function()
				self:sendCard(#self.cards)
			end, 1)
		end
	end

	if info.uid == User.info.uid then
		Util:event(Event.tingOptUpdate)
	end

	self.isInited = true

	self:adjustPos()
end

function cls:updateShadow(cardLst)
	print("****update shadow")
	cardLst = cardLst or {}

	if self.shadow then
		self.shadow:remove()
		self.shadow = nil
	end

	self.listenCards = cardLst

	if #cardLst <= 0 then
		return
	end

	local tmpSpLst = {}
	for _, v in ipairs(cardLst) do
		local sp = Util:sprite("mjCardBg/mjCardBg_1_1"):scale(v:getScale()) 
		sp:anchor(0, 0)
		sp:pos(v:pos())
		table.insert(tmpSpLst, sp)
	end

	local sp = Util:sprite("mjCardBg/mjCardBg_1_1")
	local width = self.cards[#self.cards]:x() + self.delta.x + 1
	local height = sp:height() * self.cards[1]:getScale() - 2 
	local layer = display.newLayer(cc.c4b(0,0,0,0.6))
						:size(width, height)
						:anchor(0, 0)
	
	local src = gl.ZERO -- 不使用源颜色
	local dst = gl.ONE_MINUS_SRC_ALPHA -- 使用源透明度
	local blend = cc.blendFunc(src, dst)
	for _, v in ipairs(tmpSpLst) do
		v:setBlendFunc(blend)
	end
	local rt = cc.RenderTexture:create(width, height)
	rt:begin()
	layer:visit() -- dst
	for _, v in ipairs(tmpSpLst) do
		v:visit() -- src
	end

	rt:endToLua()
	local renderMist = cc.Sprite:createWithTexture(rt:getSprite():getTexture())
	renderMist:setFlippedY(true)
	renderMist:anchor(0, 0)
				:pos(0, 0)
	self.shadow = renderMist
	self.shadow:addTo(self, 999)
end

function cls:adjustPos()
	if self.tablePos == 1 then 
		local x = display.width / 2 - self.delta.x * self:getCardCount() / 2
		local cardLst = User:getOpenedCards(self.playerIndex)
		x = x + #cardLst*85
		self:pos(x, 0)
	elseif self.tablePos == 2 then
		local y = display.height / 2 - self.delta.y * self:getCardCount() / 2
		local cardLst = User:getOpenedCards(self.playerIndex)
		y = y -  #cardLst*55
		self:pos(130, y)
	elseif self.tablePos == 3 then
		local x = display.width / 2 - self.delta.x * self:getCardCount() / 2
		local cardLst = User:getOpenedCards(self.playerIndex)
		x = x - #cardLst*60
		self:pos(x,  display.height - 60)
	elseif self.tablePos == 4 then
		local y = display.height / 2 - self.delta.y * self:getCardCount() / 2
		local cardLst = User:getOpenedCards(self.playerIndex)
		y = y + #cardLst*70
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

	if self.shadow then
		print("***touch shadow")
		local isSwallow = true
		if self.shadow:isContain(event.x, event.y) then
			for _, v in ipairs(self.listenCards) do
				if v:isContain(event.x, event.y) then
					print("****contain")
					isSwallow = false
					break
				end
			end

			if isSwallow then
				return  
			end
		end
	end

	if event.name == "began" then
		local np = self:convertToNodeSpace(event)
		if np.y > 125 or np.x < 0 then
			if self.selectedIndex then
				self.cards[self.selectedIndex]:y(0)
				self.cards[self.selectedIndex]:zorder(self.cardOrigZ)
			end
			self.selectedIndex = nil
			Util:event(Event.tipsSendCard)
			return
		end

		local selectedIndex = math.floor(np.x / self.delta.x) + 1
		if self.selectedIndex and selectedIndex == self.selectedIndex then
			-- 玩家可以操作
			self:sendCard(self.selectedIndex)
			self.selectedIndex = nil
			Util:event(Event.tipsSendCard)
			return
		end

		if self.selectedIndex and selectedIndex > #self.cards then
			self.cards[self.selectedIndex]:y(0)
			self.cards[self.selectedIndex]:zorder(self.cardOrigZ)
			self.selectedIndex = nil
			Util:event(Event.tipsSendCard)

			return 
		end

		if self.selectedIndex then
			self.cards[self.selectedIndex]:y(0)
			self.cards[self.selectedIndex]:zorder(self.cardOrigZ)
		end

		self.cards[selectedIndex]:y(30)
		self.selectedIndex = selectedIndex
		self.lastPos = cc.p(event.x, event.y)
		self.cardOrigPos = self.cards[selectedIndex]:pos()
		self.cardOrigZ = self.cards[selectedIndex]:zorder()
		self.cards[selectedIndex]:zorder(999)

		Util:event(Event.tipsSendCard, self.cards[selectedIndex].num)
		if User:isCheckTing() and
			self.tingCardsMap then
			local opts = self.tingCardsMap[self.cards[self.selectedIndex].num]
			Util:event(Event.tingOptUpdate, opts)
		end
		return true
	elseif event.name == "moved" then
		if self.selectedIndex then
			local touchP = cc.p(event.x, event.y)
			local card = self.cards[self.selectedIndex]
			local p = card:pos()
			local delta = cc.pSub(touchP, self.lastPos)
			local newP = cc.pAdd(p, delta)
			card:pos(newP)
			self.lastPos = touchP
		end
	elseif event.name == "ended" then
		if self.selectedIndex then
			local card = self.cards[self.selectedIndex]
			if event.y > 170 then
				self:sendCard(self.selectedIndex)
			else
				card:pos(self.cardOrigPos)
				card:zorder(self.cardOrigZ)
			end
		end
	end
end

function cls:sendCard(index)
	-- 玩家可以操作
	local isHasAction = false
	for _, v in ipairs(User.gameInfo.waitPlayers) do
		if v == User.info.uid then
			isHasAction = true
			break
		end
	end

	if isHasAction and User.gameInfo.outIndex == User:getUserIndex() then -- 玩家出牌阶段, 点击同一个牌打出去
		local num = self.cards[index].num
		GameProxy:doAction(ActionTips.ACTION_TYPE_CHUPAI, {num})
	else
		self.cards[index]:y(0)
	end
	self.selectedIndex = nil
	Util:event(Event.tipsSendCard)
end


return cls
