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

	if #actionLst > 0 then
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
			local btn  = Util:button(v[1], handler(self, self[v[2]]), nil, nil, nil, ccui.TextureResType.plistType)
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
	self:initActionLst(clone(info.actions))
end

function cls:hu()
	print("hu")
	GameProxy:doAction(ActionTips.ACTION_TYPE_HU, nil)
	self:remove()
end

function cls:gang()
	print("gang")
	local info = User:getUserCardInfo()
	local num = 0
	if User.gameInfo.outIndex == info.index then -- 到玩家自己回合
		-- 查找有多少杠牌，让玩家选择一个
		local numLst = {}
		local tmpNum = 0
		local count = 0
		for i, v in ipairs(info.hand) do
			if tmpNum == v then
				count = count + 1
			else
			 	count = 1 
			end
			tmpNum = v

			if count == 4 then
				table.insert(numLst, tmpNum)
			end

		end
		num = numLst[1]
	else --  杠其他玩家
		local playerInfo = User:getPlayerCardInfoByIndex()
		num = playerInfo.lose[#playerInfo.lose]
	end
	GameProxy:doAction(ActionTips.ACTION_TYPE_GANG, {num})
	self:remove()
end

function cls:peng()
	print("*****peng")
	GameProxy:doAction(ActionTips.ACTION_TYPE_PENG, nil)
	self:remove()
end

function cls:chi()
	print("*****chi")
	local numLst = {}
	local playerInfo = User:getPlayerCardInfoByIndex()
	num = playerInfo.lose[#playerInfo.lose]
	for i, v in ipairs(info.hand) do
		
	end

	GameProxy:doAction(ActionTips.ACTION_TYPE_CHI, numLst)
	self:remove()
end

function cls:ting()
	print("*****ting")
	GameProxy:doAction(ActionTips.ACTION_TYPE_TING, nil)
	self:remove()
end

function cls:guo()
	print("*****guo")
	GameProxy:doAction(ActionTips.ACTION_TYPE_GUO, nil)
	self:remove()
end

return cls