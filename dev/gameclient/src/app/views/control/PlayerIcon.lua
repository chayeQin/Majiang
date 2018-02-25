--
-- @brief 玩家头像
-- @author myc
-- @date 2018/1/9
--

local cls = class("PlayerIcon",cc.Node)

function cls:ctor(url)
	local bg = Util:sprite("com/com_img_iconframe")
	self:size(bg:size())
	self:anchor(display.CENTER)
	bg:addTo(self)
		:center()
	self.icon = Util:sprite("com/com_icon_head"):scale(1.1)
	self.icon:addTo(self, -1)
				:center()
	self:loadIcon(url)
	self:enableNodeEvents()
end

function cls:onEnter()
	self.chatEventHandler = Util:addEvent(Event.chatNotify,handler(self,self.onChatHandler))
end

function cls:onExit()
	Util:removeEvent(self.chatEventHandler)
end

function cls:bindUid(uid)
	self.uid = uid
end

function cls:loadIcon(url,isStep)
	if not url or url == "" then
		return
	end
	local fileName = Crypto.md5(url)
	local path1 = device.writablePath .. "user_icon" .. device.directorySeparator
	Util:mkdir(path1)
	local path2 = path1 .. fileName
	if Util:exists(path2) then
		self.icon:setTexture(path2)
		local scaleX = self:width() / self.icon:width()
		local scaleY = self:height() / self.icon:height()
		local scale = math.max(scaleX, scaleY)
		self.icon:scale(scale)
		return
	elseif isStep then
		return
	end
	Http.load(url, function(str, req)
		req:saveResponseData(path2)
		if not tolua.isnull(self) then
			self:loadIcon(url, true)
		end
	end, false, nil, nil, false)
end

function cls:onChatHandler(event)
	if not self.uid then return end
	local params = event.params
	local uid = params[1]
	local content = params[2]
	if self.uid ~= uid then return end
	local contentNode = nil
	if (string.find(content,"#") == 1) then
		local id = Util:strSplit(content,"#")[1] or ""
		if Util:exists(Util:path("biaoqing/" .. id)) then
			contentNode = Util:sprite("biaoqing/" .. id)
		end
	else
		contentNode = Util:label(content,24,Const.COLOR_GRAY)
	end
	if not contentNode then return end
	local bg = Util:sprite9("com/com_img_panel2",24,24,24,24)
	bg:size(contentNode:width() + 20,contentNode:height() + 20)
	contentNode:addTo(bg)
				:center()
	bg:anchor(display.LEFT_BOTTOM)
	bg:addTo(self)
		:pos(self:width() / 2, self:height() / 2)
	bg:run{
	"seq",
	{"delay",2},
	{"remove"},
}
end

return cls