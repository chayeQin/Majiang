--
-- @brief 玩法说明(详细版)
-- @author myc
-- @date 2017/12/19
--

local cls = class("PlayContent",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/PlayContent.csb"

cls.RESOURCE_BINDING = {
	["list_play"] = {
		varname = "list_play",
	},
	["btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
}

function cls:onCreate()
	PopupManager:push(self)
	Util:touchLayer(self)
	self.list_play = ListView.bind(self,self.list_play)
	Util:sprite("other/other_txt_title_wfsm_")
			:addTo(self)
			:pos(650,630)
	self.list_play:update({1})
end

function cls:cell(i,data)
	local node = display.newNode()
	local width = self.list_play:width()
	local sp = Util:sprite("bg/big_txt_ccmj_help")
	local scale = self.list_play:width() / sp:width()
	sp:setScale(scale)
	local height = sp:height() * scale
	node:size(self.list_play:width(),height)
	sp:addTo(node)
		:align(display.LEFT_BOTTOM,0,0)
	return node
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

return cls