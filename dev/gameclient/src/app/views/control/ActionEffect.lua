--
-- Author: qyp
-- Date: 2018/01/31
-- Brief: 
--

local cls = class("ActionEffect", cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/ActionEffect.csb"

cls.RESOURCE_BINDING = {
	["img_act"] = {
		varname = "img_act",
	},
}


function cls:ctor(actType)
	cls.super.ctor(self)
	if actType == ActionTips.ACTION_TYPE_CHI then
		self.img_act:setTexture(Util:texture("playScene/playscene_btn_chi"))
	elseif actType == ActionTips.ACTION_TYPE_PENG then
		self.img_act:setTexture(Util:texture("playScene/playscene_btn_peng"))
	elseif actType == ActionTips.ACTION_TYPE_GANG then
		self.img_act:setTexture(Util:texture("playScene/playscene_btn_gang"))
	elseif actType == ActionTips.ACTION_TYPE_HU then
		self.img_act:setTexture(Util:texture("playScene/playscene_btn_hu"))
	elseif actType == ActionTips.ACTION_TYPE_TING then
		self.img_act:setTexture(Util:texture("playScene/playscene_btn_ting"))
	end

	self:runTimeline(nil, nil, nil, 2)
	self:run({"seq",
				{"delay", 1},
				{"remove"}
	})
end

return cls
