--
-- Author: qyp
-- Date: 2018/01/07
-- Brief: 
--

local cls = class("PlayerOpenCards", cc.load("mvc").ViewBase)


cls.POS_DELTA = {
	[1] = cc.p(32, 0),
	[2] = cc.p(0, -22),
	[3] = cc.p(-32, 0),
	[4] = cc.p(0, 22),
}

cls.GROUP_POS_DELTA = {
	[1] = cc.p(8, 0),
	[2] = cc.p(0, -14),
	[3] = cc.p(-8, 0),
	[4] = cc.p(0, 14),
}


function cls:ctor(tablePos, playerIndex)
	cls.super.ctor(self)
	self.tablePos = tablePos
	self.playerIndex = playerIndex
	self.cards = {}
	self:enableNodeEvents()
end

function cls:onEnter()
	--监听手牌变化
	self.onUpdateHandle = Util:addEvent(Event.gameInfoUpdate, handler(self, self.updateCards))
end

function cls:onExit()
	Util:removeEvent(self.onUpdateHandle)
end

function cls:updateCards()
	self.delta = cls.POS_DELTA[self.tablePos]
	self.groupDelta = cls.GROUP_POS_DELTA[self.tablePos]

	for _, v in ipairs(self.cards) do
		v:remove()
	end
	self.cards = {}
	local cardLst = User:getOpenedCards(self.playerIndex)
	local x = 0
	local y = 0
	for i, group in ipairs(cardLst) do
		for j, v in ipairs(group) do
			local img = Majiang.new(self.tablePos + 4, v)
							:addTo(self)
			
			img:pos(x, y)
			img:zorder(display.height - y)
			table.insert(self.cards, img)
			x = x + self.delta.x
			y = y + self.delta.y
		end
		x = x + self.groupDelta.x
		y = y + self.groupDelta.y
	end
	self:adjustPos()
end

function cls:adjustPos()
	if self.tablePos == 1 then 
		self:pos(130, 30)
	elseif self.tablePos == 2 then
		self:pos(130, 580)
	elseif self.tablePos == 3 then
		self:pos(1000, 670)
	elseif self.tablePos == 4 then
		self:pos(1150, 140)
		-- sel:pos(display.width - 130, display.height / 2 - self.delta.y * self:getCardCount() / 2)
	end
end

return cls