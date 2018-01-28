--
--@brief: 准备界面
--@author: qyp
--@date: 2017/12/24
--

local cls = class("ReadyView", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/ReadyView.csb"

cls.RESOURCE_BINDING = {
	["btn_dismiss"] = {
		varname = "btn_dismiss",
		method = "btn_dismissHandler",
	},
	["btn_invite"] = {
		varname = "btn_invite",
		method = "btn_inviteHandler",
	},
}


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
end

function cls:onExit()
end

function cls:updateUI()
	self:onInfoUpdate()
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

			if not v.state then -- 未准备
				GameProxy:ready()
			end
		else
			sortKey = sortKey + 1
		end
		indexMap[i] = {i, sortKey}
	end
	table.sort(indexMap, function(v1, v2)
		return v1[2] < v2[2]
	end)

	local posMap = {}
	if User.info.maxSize == 2 then
		posMap[1] = ICON_POS_MAP[1]
		posMap[2] = ICON_POS_MAP[3]
	else 
		posMap = ICON_POS_MAP
	end

	for i, v in ipairs(indexMap) do
		local posInfo = posMap[i]
		local index = v[1]
		local info = User.roomInfo.players[index]

		local node = PlayerIcon.new(info.headimgurl)
		node:addTo(self)
		node:x(posInfo[1])
		node:y(posInfo[2])
	end
end

return cls
