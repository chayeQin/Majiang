--
-- Author: qyp
-- Date: 2018/01/08
-- Brief: 
--

local cls = class("ActionTips", cc.load("mvc").ViewBase)

local ACTION_IMG = {
	{"playscene_btn_hu", "hu"},
	{"playscene_btn_gang", "gang"},
	{"playscene_btn_peng", "peng"},
	{"playscene_btn_chi", "chi"},
	{"playscene_btn_guo", "guo"}
}
function cls:ctor(actionLst)
	cls.super.ctor(self)
	table.insert(actionLst, 5)
	local deltaX = -115
	local index = 1
	for i = #actionLst, 1, -1 do
		-- display.newSprite(res)
		local v = ACTION_IMG[actionLst[i]]
		local btn  = Util:button(v[1], handler(self, self[v[2]]), nil, nil, nil, ccui.TextureResType.plistType)
						:addTo(self)
		local x = (index-1)* deltaX
		btn:x(x)
		index = index + 1
		if actionLst[i] == 5 then
			btn:scale(0.8)
		end
	end
end

function cls:hu()
	print("hu")
	self:remove()
end

function cls:gang()
	print("gang")
	self:remove()
end

function cls:peng()
	print("peng")
	self:remove()
end

function cls:chi()
	print("chi")
	self:remove()
end
function cls:guo()
	print("guo")
	self:remove()
end

return cls