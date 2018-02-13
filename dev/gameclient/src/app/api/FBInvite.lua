--
-- Author: lyt
-- Date: 2016-12-14 15:43:47
-- FB 邀请
local cls = class("FBInvite")

function cls:ctor()
end

function cls:inviteFriend()
	self:getFriends(function(list)
		if not list then
			return
		end
		local ids = {}
		for k,v in ipairs(list) do
			table.insert(ids, v.id)
		end

		self:invite(Lang:find("fb_invite_title"), Lang:find("fb_invite_msg"), ids, function(data2)
			-- local friends = data2.invite_friends
		end)
	end)
end

-- 返回好友列表
-- 注意返回的ID只能用于邀请
-- [{"id":"","name":"","picture":"https://"}]
-- v.id -- 邀请用的ID
-- v.picture.data.url 图片地址
function cls:getFriends(rhand)
	if not rhand then return end
	Api:call("FBInvite", "friends", nil, function(v)
		local obj = json.decode(v) or {}
		rhand(obj)
	end)
end

-- 标题,内容,过虑好友
-- 返回[id1,id2]
function cls:invite(title, msg, friends, rhand)
	if not rhand then return end
	local param = {
		title   = title,
		msg     = msg,
		friends = friends,
	}
	Api:call("FBInvite", "invite", param, function(v)
		local obj = json.decode(v) or {}
		rhand(obj)
	end)
end

-- 获取被邀请ID,返回FB_ID或空
function cls:getInviteFriend(rhand)
	if not rhand then return end
	Api:call("FBInvite", "getInviteFrom", nil, rhand)
end

-- 获取自己uid,name,picture(头像)
function cls:getMe(rhand)
	if not rhand then return end
	Api:call("FBInvite", "getMe", nil, function(v)
		local obj = json.decode(v) or {}
		rhand(obj)
	end)
end

return cls