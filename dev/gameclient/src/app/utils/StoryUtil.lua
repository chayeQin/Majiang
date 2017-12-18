--
-- Author: lyt
-- Date: 2016-10-13 19:48:02
-- 剧情
local cls = class("beforeFight")

function cls:ctor()
end

function cls:init()
	if self.data then
		return
	end

	self.data = {}
	local list = Util:getSortData(db.DStory)
	for k,v in ipairs(list) do
		-- id=自增ID,trigger=触发条件,pointId=关卡ID,direction=方向,name=名称,imageId=头像ID,text=对话,
		local list1 = self.data[v.trigger]
		if not list1 then
			list1 = {}
			self.data[v.trigger] = list1
		end

		local list2 = list1[v.pointId]
		if not list2 then
			list2 = {}
			list1[v.pointId] = list2
		end

		table.insert(list2, v)
	end
end

function cls:beforeFight(pointId, rhand)
	self:init()
	return self:getStor(1, pointId, rhand)
end

function cls:afterFight(pointId, rhand)
	self:init()
	return self:getStor(2, pointId, rhand)
end

function cls:getStor(trigger, pointId, rhand)
	local map = self.data[trigger]
	if not map then
		rhand()
		return
	end

	local data = map[pointId]
	if not data then
		rhand()
		return
	end

	require("app.views.game.story.UIStory").new(data, function()

		rhand()
	end)
end

return cls