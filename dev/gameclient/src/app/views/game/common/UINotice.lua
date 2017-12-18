--
-- @brief 
-- @author yjg
-- @date 2015年11月16日 18:15:38
-- 公告界面
local cls = class("UINotice", cc.load("mvc").ViewBase)


cls.RESOURCE_FILENAME = "csb/UINoticeView.csb"

cls.RESOURCE_BINDING = {
	["img_bg"] = {
		varname = "img_bg",
	},
	["img_bg.Image_4.node_listview"] = {
		varname = "node_listview",
	},
	["img_bg.btn_close"] = {
		varname = "btn_close",
		method = "btn_closeHandler",
	},
	-- 游戏公告
	["img_bg.Image_2.lab_title"] = {
		varname = "lab_title",
	},
}




function cls:ctor()
	self.super.ctor(self)

	self.notice = SDK.notice

	Util:focusLayer(self)

	self.img_bg:run{"seq",
			{"scaleTo", 0.2, 1.1},
			{"scaleTo", 0.2, 1},
	}

	PopupManager:push(self)


	self:initParam()

end

function cls:initParam()

	for i =1,27	 do
		Util:sprite("ui/zhuangshi_103"):addTo(self.img_bg):pos(40 + 10*(i -1),560)
		Util:sprite("ui/zhuangshi_103"):addTo(self.img_bg):pos(690 + 10*(i -1),560)
	end
	
	self.node_listview = ListView.bind(self,self.node_listview)
	self.node_listview.callback = handler(self, self.callback)
	self.node_listview.cell = handler(self, self.createCell)
	self.node_listview:update({1})
end

function cls:createCell(i,data)
	
	local node = display.newNode()--:size(940,490)

	local notice = self.notice
	if self.notice == "null" then
		notice = "暂无公告"
	end

	-- local str = "亲爱的玩家\n\t\t"..notice.."\n\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t游戏运营团队"


	local lab = Util:label(notice, 22, cc.c3b(0xfb,0xe7,0xbb), cc.size(930, 0)) --cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER
	node:size(940,lab:height() + 20)
	lab:addTo(node):align(display.LEFT_BOTTOM,5,10)	


	return node

end

function cls:callback(event)
	-- body
end


function cls:btn_closeHandler()
	PopupManager:popView(self)
end


return  cls