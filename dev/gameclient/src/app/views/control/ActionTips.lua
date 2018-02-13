--
-- Author: qyp
-- Date: 2018/01/08
-- Brief: 
--

local cls = class("ActionTips", cc.load("mvc").ViewBase)

cls.ACTION_TYPE_CHI = 1 -- 吃
cls.ACTION_TYPE_PENG = 2 -- 碰
cls.ACTION_TYPE_GANG = 3 -- 杠
cls.ACTION_TYPE_HU = 4 -- 胡
cls.ACTION_TYPE_TING = 10 -- 听
cls.ACTION_TYPE_CHUPAI = 11 -- 出牌
cls.ACTION_TYPE_GUO = 12  -- 取消


local ACTION_IMG = {
	[cls.ACTION_TYPE_HU] = {"playscene_btn_hu", "hu"},
	[cls.ACTION_TYPE_GANG] = {"playscene_btn_gang", "gang"},
	[cls.ACTION_TYPE_PENG] = {"playscene_btn_peng", "peng"},
	[cls.ACTION_TYPE_CHI] = {"playscene_btn_chi", "chi"},
	[cls.ACTION_TYPE_GUO] = {"playscene_btn_guo", "guo"},
	[cls.ACTION_TYPE_TING] = {"playscene_btn_ting", "ting"},
}

local ACTION_SORT = {
	[cls.ACTION_TYPE_HU] = 1,
	[cls.ACTION_TYPE_TING] = 2,
	[cls.ACTION_TYPE_GANG] = 3,
	[cls.ACTION_TYPE_PENG] = 4,
	[cls.ACTION_TYPE_CHI] = 5,
	[cls.ACTION_TYPE_GUO] = 6,
}

function cls:ctor()
	cls.super.ctor(self)
	self.btnLst = {}
end

function cls:initActionLst(actionLst)
	for _, v in ipairs(self.btnLst) do
		v:remove()
	end
	self.btnLst = {}

	for i, v in ipairs(actionLst) do
		if v == cls.ACTION_TYPE_CHUPAI then
			table.remove(actionLst, i)
			break
		end
	end

	if #actionLst > 0 and cls.ACTION_TYPE_GUO ~= actionLst[1] then
		table.insert(actionLst, cls.ACTION_TYPE_GUO)
	end
	table.sort(actionLst, function(v1, v2)
		return ACTION_SORT[v1] < ACTION_SORT[v2]
	end)

	local deltaX = -115
	local index = 1
	for i = #actionLst, 1, -1 do
		local v = ACTION_IMG[actionLst[i]]
		if v then 
			local btn  = Util:button("playScene/" ..v[1], handler(self, self[v[2]]), nil, nil, nil)
						:addTo(self)
			local x = (index-1)* deltaX
			btn:x(x)
			index = index + 1
			if actionLst[i] == cls.ACTION_TYPE_GUO then
				btn:scale(0.8)
			end

			table.insert(self.btnLst, btn)

		end
	end

	if #self.btnLst > 0 then
		self:show()
	else
		self:hide()
	end
end

function cls:onEnter()
	--监听手牌变化
	self.onUpdateHandle = Util:addEvent(Event.gameInfoUpdate, handler(self, self.onInfoUpdate))
end

function cls:onExit()
	Util:removeEvent(self.onUpdateHandle)
end

function cls:onInfoUpdate()
	local info = User:getUserCardInfo()
	User:setCheckTing(false)
	self.tingCards = nil
	if User.gameInfo.outIndex == info.index then -- 到玩家自己回合
		local isTing, tingCards = AlgoUtil:checkTing(info.hand)
		self.tingCards = tingCards
		if isTing then
			User:setCheckTing(true)
			table.insert(info.actions, 1, cls.ACTION_TYPE_TING)
		end
	end

	self:initActionLst(clone(info.actions))
end

function cls:hu()
	print("hu")
	GameProxy:doAction(ActionTips.ACTION_TYPE_HU, nil)
	self:hide()
end

function cls:gang()
	print("gang")
	local info = User:getUserCardInfo()
	local num = 0
	if User.gameInfo.outIndex == info.index then -- 到玩家自己回合
		-- 查找有多少杠牌，让玩家选择一个
		local optionLst = {}

		local tops = clone(info.top) -- 打开的牌
		local topOpt = {}
		local tmpNum = 0
		local count = 0

		for _, group in ipairs(tops) do
			for __, v in ipairs(group) do
				if tmpNum == v then
					count = count + 1
				else
					tmpNum = v
				 	count = 1 
				end
				
				if count == 3 then -- 碰了的牌
					topOpt[v] = true
				end
			end
		end

		local tmpNum = 0
		local count = 0
		local hands = clone(info.hand)
		table.sort(hands, function(v1, v2)
			return v1 < v2
		end)

		for i, v in ipairs(hands) do
			if tmpNum == v then
				count = count + 1
			else
				tmpNum = v
			 	count = 1 
			end
			
			if count == 4 or topOpt[v] then
				table.insert(optionLst, tmpNum)
			end
		end


		local tmpLst = {}
		for _, v in ipairs(optionLst) do
			local lst = {}
			for i = 1, 4 do
				table.insert(lst, v)
			end
			table.insert(tmpLst, lst)
		end


		ChooseOptionCards.new(tmpLst, function(index)
			local num = optionLst[index]
			GameProxy:doAction(ActionTips.ACTION_TYPE_GANG, {num})
		end)

		return

	else --  杠其他玩家
		local playerInfo = User:getPlayerCardInfoByIndex(User.gameInfo.outIndex)
		num = playerInfo.lose[#playerInfo.lose]
	end

	GameProxy:doAction(ActionTips.ACTION_TYPE_GANG, {num})
	self:hide()
end

function cls:peng()
	print("*****peng")
	GameProxy:doAction(ActionTips.ACTION_TYPE_PENG, nil)
	self:hide()
end

function cls:chi()
	print("*****chi")
	local playerInfo = User:getPlayerCardInfoByIndex(User.gameInfo.outIndex)
	local num = playerInfo.lose[#playerInfo.lose]
	local userCardInfo = User:getUserCardInfo()
	local option = {}
	local cardType = math.floor(num / 10) -- 牌型
	local n = math.floor((num-2) / 10)
	if n == cardType then
		option[1] = {[num-2]=0, [num-1]=0}
	end
	local n2 = math.floor((num-1) / 10)
	local n3 = math.floor((num+1) / 10)
	if n2 == cardType and n3 == cardType then
		option[2] = {[num-1]=0, [num+1]=0}
	end
	local n4 = math.floor((num+2) / 10)
	if n4 == cardType then
		option[3] = {[num+1]=0, [num+2]=0}
	end

	for i, v in ipairs(userCardInfo.hand) do
		for j = 1, 3 do
			if option[j] and option[j][v] then
				option[j][v] = option[j][v] + 1
			end	
		end
	end

	local validLst = {}
	for _, v in pairs(option) do
		local valid = true
		for num, count in pairs(v) do
			if count == 0 then
				valid = false
			end
		end
		if valid then
			table.insert(validLst, v)
		end
	end

	local optionLst = {}
	for _, v in pairs(validLst) do
		local tmpLst = {}
		for num, count in pairs(v) do
			table.insert(tmpLst, num)
		end
		table.insert(tmpLst, num)
		table.sort(tmpLst, function(v1, v2)
			return v1 < v2
		end)
		table.insert(optionLst, tmpLst)
	end

	ChooseOptionCards.new(optionLst, function(index)
		local tmp = optionLst[index]
		local j = -1
		for i, v in ipairs(tmp) do
			if v == num then
				j = i
				break
			end
		end
		table.remove(tmp, j)

		GameProxy:doAction(ActionTips.ACTION_TYPE_CHI, tmp)
	end)

	self:hide()
end

function cls:ting()
	print("*****ting")
	-- GameProxy:doAction(ActionTips.ACTION_TYPE_TING, nil)
	if User:isCheckTing() then
		Util:event(Event.playerTing, self.tingCards)
		self:initActionLst({cls.ACTION_TYPE_GUO})
	end
end

function cls:pengTing()
end

function cls:guo()
	print("*****guo")
	if not User:isCheckTing() then
		GameProxy:doAction(ActionTips.ACTION_TYPE_GUO, nil)
	else
		Util:event(Event.playerTing)
	end
	self:hide()
end

return cls