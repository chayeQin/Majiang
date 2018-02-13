--
-- @brief 战绩
-- @author myc
-- @date 2018/1/9
--

local cls = class("PlayRecord",cc.load("mvc").ViewBase)

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
	Util:sprite("other/other_txt_title_zj")
			:addTo(self)
			:pos(650,630)
	self:updateRecord()
end

function cls:updateRecord()
	self.list_play:update({1})
end

function cls:cell(i,data)
	local node = display.newNode()
	if type(data) == "number" then
		self:createEmptyCell(node)
	else
	end
	return node
end

function cls:createEmptyCell(parent)
	parent:size(self.list_play:width(),190)
	local titleBg = Util:sprite("com/com_img_panel_celltitle")
	titleBg:addTo(parent)
			:align(display.CENTER_TOP,parent:width() / 2,parent:height() - 5)
	local contentBg = Util:sprite("com/com_img_panel_cellbg")
	contentBg:addTo(parent,-100)
			:align(display.CENTER_TOP,parent:width() / 2,titleBg:y() - titleBg:height() + 10)
	local labContent = Util:label("暂无战绩，快去喊小伙伴一起玩吧......",
		24,Const.COLOR_GRAY,{width = contentBg:width() - 100},
		cc.TEXT_ALIGNMENT_CENTER,cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	labContent:addTo(contentBg)
				:center()
end

function cls:btn_closeHandler(target)
	PopupManager:popView(self)
end

return cls