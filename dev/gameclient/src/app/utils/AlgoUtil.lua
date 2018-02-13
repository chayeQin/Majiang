--
-- @brief 各种计算工具
-- @author: qyp
-- @date: 2016/03/12
--

local cls = class("AlgoUtil")

local file = io.open("commanderDetail.txt", "w+")

local function writeDetail(...)
	print(...)
	file:write(...)
	file:write("\n")
end

local TEST_PRINT = true

function cls:checkHu(cardLst)
	table.sort(cardLst, function(v1, v2)
		return v1 < v2
	end)
	--只有2张牌，一样的话，就胡牌
	if #cardLst == 2 then
		return cardLst[1] == cardLst[2]
	end

	if self:isQixiaodui(cardLst) then
		return true
	end

	for i = 1, #cardLst do
		local tmpLst = clone(cardLst)
		local tmpCard = cardLst[i]
		local jiangPaiLst = self:getCardByCards(tmpLst, tmpCard, 2);
		if #jiangPaiLst >= 2 then
			i = i + 2
			self:list_remove(tmpLst, tmpCard)
			self:list_remove(tmpLst, tmpCard)
			if self:checkHu2(tmpLst) then
				return true
			end
		end
	end
	return false
end

function cls:getCardByCards(cardLst, card, count)
	local tmpCards = {}
	for _, v in ipairs(cardLst) do
		if v == card then
			table.insert(tmpCards, v);
		end
		if #tmpCards >= count then
			return tmpCards
		end
	end
	return tmpCards
end

function cls:isQixiaodui(cardLst)
	if #cardLst == 14 then
		for i = 1, 14, 2 do
			if cardLst[i] ~= cardLst[i+1] then
				return false
			end
		end
		return true
	end

	return false

end

function cls:list_remove(cardLst, card)
	for i = #cardLst, 1, -1 do
		if cardLst[i] == card then
			table.remove(cardLst, i)
			return true
		end
	end
	return false
end

function cls:checkHu2(cardLst)
	if #cardLst == 0 then return true end
	for _, c in ipairs(cardLst) do
		local tmpKezi = self:getCardByCards(cardLst, c, 3)
		if #tmpKezi == 3 then
			self:list_remove(cardLst, c)
			self:list_remove(cardLst, c)
			self:list_remove(cardLst, c)
			return self:checkHu2(cardLst);
		else
			if self:hasVal(cardLst, c+1) and self:hasVal(cardLst, c+2) then
				self:list_remove(cardLst, c)
				self:list_remove(cardLst, c+1)
				self:list_remove(cardLst, c+2)
				return self:checkHu2(cardLst)
			end 
		end
	end
	return false
end


function cls:hasVal(cardLst, card)
	for _, v in ipairs(cardLst) do
		if v == card then
			return true
		end
	end
end


function cls:checkTing(cardLst)
	dump(cardLst, "check ting")
	if #cardLst == 2 then
		local tmpMap = {}
		tmpMap[cardLst[1]] = {cardLst[2]}
		tmpMap[cardLst[2]] = {cardLst[1]}
		return true, tmpMap
	end

	local isTing = false
	local tingCardsMap = {} -- [扔牌] = {听什么牌, xxx}
	local lastCheckCard = nil
	for i, tmpCard in ipairs(cardLst) do
		if lastCheckCard ~= tmpCard then
			lastCheckCard = tmpCard
			local tmpLst = clone(cardLst)
			table.remove(tmpLst, i)
			local isHu = false
			for _, v in ipairs(Const.CARD_LIBS) do
				table.insert(tmpLst, v)
				isHu = self:checkHu(tmpLst)
				if isHu then
					tingCardsMap[tmpCard] = tingCardsMap[tmpCard] or {}
					table.insert(tingCardsMap[tmpCard], v)
				end

				if not isTing and isHu then
					isTing = true
				end
				self:list_remove(tmpLst, v)
			end
		end
	end
	

	return isTing, tingCardsMap
end


function cls:sortCards(cardLst)
	table.sort(cardLst, function(v1, v2)
		local val1 = v1 > 10 and v1 or v1 + 40  -- 花牌排最后
		local val2 = v2 > 10 and v2 or v2 + 40
		return val1 < val2
	end)
end

return cls
