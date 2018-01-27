--
--@brief: 准备界面
--@author: qyp
--@date: 2017/12/24
--

local cls = class("ReadyView", cc.load("mvc").ViewBase)

local ICON_POS_MAP = {
	{80, 140},
	{80, 580},
	{980, 680},
	{1220, 140}

}

function cls:ctor()
	cls.super.ctor(self)
	self.playerNodes = {}
	self:enableNodeEvents()
end

function cls:onEnter()
	-- 监听玩家进入房间事件, 玩家准备状态改变
	-- 进入房间自动准备
	GameProxy:ready()
end

function cls:onExit()
end


function cls:onInfoUpdate()
	for _, v in ipairs(self.playerNodes) do
		v:remove()
	end

	self.playerNodes = {}
	local indexMap = {}
	local orig = 0
	local sortKey = orig
	-- 找出玩家自己的位置
	for i, v in ipairs(User.roomInfo.players) do
		if v.uid == User.info.uid then
			sortKey = sortKey - 4
		else
			sortKey = sortKey + 1
		end
		indexMap[i] = {i, sortKey}
	end
	table.sort(indexMap, function(v1, v2)
		return v1[2] < v2[2]
	end)

	for i, v in ipairs(indexMap) do
		local posInfo = ICON_POS_MAP[i]
		local index = v[1]
		local info = User.roomInfo.players[index]
		local node = display.newNode()
		Util:label(info.nickname)
			:addTo(node)
		node:addTo(self)
		node:x(posInfo[1])
		node:y(posInfo[2])
	end


	-- test
	User.roomInfo.size = 2
	if #User.roomInfo.players >= User.roomInfo.size and
		not User.roomInfo.status then  -- 还没开始牌局
		GameProxy:start()
	end


end

return cls
