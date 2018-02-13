--
-- @brief 聊天界面
-- @author myc
-- @date 2018/1/26
--

local cls = class("ChatView",cc.load("mvc").ViewBase)

cls.RESOURCE_FILENAME = "csb/ChatView.csb"

cls.RESOURCE_BINDING = {
	["list_chat"] = {
		varname = "list_chat",
	},
	["img_chat"] = {
		varname = "img_chat",
	},
	["img_face"] = {
		varname = "img_face",
	},
	["btn_face"] = {
		varname = "btn_face",
		method = "btn_faceHandler",
	},
	["btn_chat"] = {
		varname = "btn_chat",
		method = "btn_chatHandler",
	},
	["img_bg"] = {
		varname = "img_bg",
	},
}

cls.CHAT = 1	-- 常用语
cls.FACE = 2 	-- 表情
cls.MAX_FACE = 44	-- 最大表情数

local config = require("app." .. GAME_NAME .. ".ChatConfig")

function cls:onCreate()
	Util:popupHandler(self,self.img_bg,handler(self,self.closeHandler))
	PopupManager:push(self)
	self.list_chat = ListView.bind(self,self.list_chat)
	self.index = nil
	self:updateTab(cls.CHAT)
	self:btn_chatHandler()
end

function cls:updateTab(index)
	if self.index == index then
		return
	end
	self.index = index
	self.btn_chat:opacity(self.index == cls.CHAT and 255 or 0)
	self.btn_face:opacity(self.index == cls.FACE and 255 or 0)
	self.img_chat:loadTexture(self.index == cls.CHAT and "other/other_img_cyychoose.png" or "other/other_img_cyyunchoose.png")
	self.img_face:loadTexture(self.index == cls.FACE and "other/other_img_bqchoose.png" or "other/other_img_bqunchoose.png")
end

function cls:btn_faceHandler(target)
	self:updateTab(cls.FACE)
	local list = {}
	for index = 1,cls.MAX_FACE do
		table.insert(list,"#" .. index)
	end
	local showLst = Util:convertSubLst(list,9)
	self.list_chat:update(showLst)
end

function cls:btn_chatHandler(target)
	self:updateTab(cls.CHAT)
	local showLst = config.CHAT or {}
	self.list_chat:update(showLst)
end

function cls:cell(index,data)
	if self.index == cls.FACE then
		return self:createFaceCell(index,data)
	else
		return self:createChatCell(index,data)
	end
end

-- 聊天文本
function cls:createChatCell(index,data)
	local node = display.newNode()
	local labContent = Util:label(data.content,24,Const.COLOR_GRAY,
		{width = self.list_chat:width() - 30},cc.TEXT_ALIGNMENT_CENTER
		,cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	local btn = Util:button("other/other_img_chatcellbg",handler(self,self.btnSendHandler),
		nil,nil,nil)
	node:size(self.list_chat:width(),btn:height() + 5)
	btn:addTo(node)
		:center()
	labContent:addTo(btn)
			:center()
	btn:setSwallowTouches(false)
	btn:setZoomScale(0)
	btn.content = data.content
	return node
end

function cls:createFaceCell(index,data)
	local node = display.newNode()
	node:size(self.list_chat:width(),65)
	for i,str in ipairs(data) do
		local array = Util:strSplit(str,"#")
		local path = "biaoqing/"..array[1]
		local btn = Util:button(path,handler(self,self.btnSendHandler))
		btn:addTo(node)
		btn:pos(10 * i + (i - 0.5) * 60,node:height() / 2)
		btn:setSwallowTouches(false)
		btn:setZoomScale(0)
		btn.content = str
	end
	return node
end

function cls:btnSendHandler(target)
	local content = target.content
	if not content then return end
	GameProxy:sendChat(content,function ()
	end)
end

function cls:onListViewEvent(event)
end

function cls:closeHandler()
	PopupManager:popView(self)
end

return cls