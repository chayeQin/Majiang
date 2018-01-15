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
	{calDeltaX=handler(32, calCol), calDeltaY = handler(-40, calRow)},
	{calDeltaX=handler(-40, calRow), calDeltaY = handler(-22, calCol)},
	{calDeltaX=handler(-32, calCol), calDeltaY = handler(40, calRow)},
	{calDeltaX=handler(40, calRow), calDeltaY = handler(22, calCol)},
}

-- 两人16只一排， 3人以上10只一排
function cls:ctor(tablePos, colCount)
	cls.super.ctor(self)
	self.cards = {}
	self.tablePos = tablePos
	self.colCount = colCount or 12
	self:enableNodeEvents()
end

function cls:onEnter()
	--监听手牌变化
end

function cls:updateCards()
	for _, v in ipairs(self.cards) do
		v:remove()
	end
	self.cards = {}

	local cardLst = GameModel:getTableCards(self.tablePos)
	self.delta = cls.POS_DELTA[self.tablePos]
	for i, v in ipairs(cardLst) do
		local x = self.delta.calDeltaX(i, self.colCount) 
		local y = self.delta.calDeltaY(i, self.colCount) 
		local img = Majiang.new(self.tablePos+4, v)
						:addTo(self)
		img:pos(x, y)
		img:zorder(display.height-y)
		table.insert(self.cards, img)
	end

	self:adjustPos()

end

function cls:adjustPos()
	if self.tablePos == 1 then 
		self:pos(490, 200)
	elseif self.tablePos == 2 then
		self:pos(440, 490)
	elseif self.tablePos == 3 then
		self:pos(760, 530)
	elseif self.tablePos == 4 then
		self:pos(800, 250)
		-- sel:pos(display.width - 130, display.height / 2 - self.delta.y * self:getCardCount() / 2)
	end
end

function cls:addCard()

end

function cls:removeCard()
end

return cls